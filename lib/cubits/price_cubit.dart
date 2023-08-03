import 'dart:convert';
import 'package:deriv_flutter_excercise/Services/web_chanel_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';


class PriceCubit extends Cubit<PriceState> {
  double previousPriceValue = 0.0;
  String subscriptionId= '';
  final WebSocketChannelService _webSocketService;


  PriceCubit(this._webSocketService) : super(PriceInitialState()) {
    initializeWebSocketConnection();
  }

  initializeWebSocketConnection() async{
    bool isConnected = await Utils.isInternetConnected();
    if(isConnected){
      _webSocketService.connectWs();
      listenWebSocketData();
    }else{
      emit(PriceErrorState(Constants.INTERNET_ERROR));
    }
  }

  listenWebSocketData() {
    _webSocketService.registerWebSocketListeners(
        onData: (data) {
          final response = jsonDecode(data);
          try {
            if (response?.containsKey('msg_type') &&
                response['msg_type'] == 'tick' &&
                response?.containsKey('tick')) {
              final tick = response['tick'];
              if (tick?.containsKey('quote')) {
                final price = tick['quote'];
                emit(PriceLoadedState(double.parse(price.toString())));
              } else {
                emit(PriceErrorState(Constants.GENERAL_ERROR));
              }
              if (response?.containsKey('subscription')) {
                final sub = response['subscription'];
                if (sub?.containsKey('id')) {
                  subscriptionId = sub['id'];
                }
              }
            }
            else if (response?.containsKey('msg_type') &&
                response['msg_type'] != null &&
                response['msg_type'] == 'forget') {
              emit(PriceInitialState());
            } else {
              String errorMessage = Constants.GENERAL_ERROR;
              if (response?.containsKey('error') &&
                  response['error'] != null &&
                  response['error'].containsKey('message')) {
                errorMessage = response['error']['message'];
              }
              emit(PriceErrorState(errorMessage));
            }
          } on Exception catch (e) {
            emit(PriceErrorState(e.toString()));
          }
        }, onError: (error) {
      emit(PriceErrorState(error.toString()));
    }, onDone: (value) {
      reconnectWebSocket();
    });
  }

  reconnectWebSocket() {
    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      _webSocketService.connectWs();
       listenWebSocketData();
    });
  }

  getRequestTicketPrice({String symbol = ''}) async{
    bool isConnected = await Utils.isInternetConnected();
    if(isConnected){
      cancelPreviousSubscription();
      _webSocketService.transmitWebSocketMessage({
        "ticks": symbol,
      });
    }else{
      emit(PriceErrorState(Constants.INTERNET_ERROR));
    }
  }

  cancelPreviousSubscription(){
    if(subscriptionId.isNotEmpty){
      _webSocketService.transmitWebSocketMessage({
        "forget": subscriptionId,
      });
      subscriptionId = '';
    }
  }

  initializePrice() {
    previousPriceValue= 0.0;
    emit(PriceInitialState());
  }

  startLoadingPrice(){
    previousPriceValue= 0.0;
    emit(PriceLoadingState());
  }


  Color priceChangeColor({double currentPrice = 0.0, double previousPrice = 0.0}) {
    Color color = Colors.grey;
    if(previousPrice==0.0){
      previousPriceValue = currentPrice;
      return color;
    }
    if (currentPrice < previousPrice) {
      color = Colors.red;
    } else if (currentPrice > previousPrice) {
      color = Colors.green;
    } else {
      color = Colors.grey;
    }
    previousPriceValue = currentPrice;
    return color;
  }
}

abstract class PriceState extends Equatable {}

class PriceInitialState extends PriceState {
  @override
  List<Object> get props => [];
}

class PriceLoadingState extends PriceState {
  @override
  List<Object> get props => [];
}

class PriceLoadedState extends PriceState {
  PriceLoadedState(this.price);

  final double price;

  @override
  List<Object> get props => [price];
}

class PriceErrorState extends PriceState {
  final String error;

  PriceErrorState(this.error);

  @override
  List<Object> get props => [error];
}
