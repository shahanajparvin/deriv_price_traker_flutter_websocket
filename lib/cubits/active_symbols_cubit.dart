import 'dart:convert';
import 'package:deriv_flutter_excercise/Models/active_symbol_model.dart';
import 'package:deriv_flutter_excercise/Services/web_chanel_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ActiveSymbolsCubit extends Cubit<ActiveSymbolsState> {
  final WebSocketChannelService _webSocketService;

  ActiveSymbolsCubit(this._webSocketService) : super(LoadingState()) {
    initializeWebSocketConnection();
  }

  initializeWebSocketConnection() async{
    bool isConnected = await Utils.isInternetConnected();
    if(isConnected){
      _webSocketService.connectWs();
      listenWebSocketData();
      sendActiveSymbolsRequest();
    }else{
      emit(ErrorState(Constants.INTERNET_ERROR));
    }
  }



  listenWebSocketData() {
    _webSocketService.registerWebSocketListeners(
        onData: (data){
          final response = jsonDecode(data);
          try {
            if (response?.containsKey('active_symbols')&&response["active_symbols"] != null) {
              List<ActiveSymbolModel> activeSymbols = List<ActiveSymbolModel>.from(response["active_symbols"]
                  .map((data) => ActiveSymbolModel.fromJson(data))
                  .toList());
              emit(LoadedState(activeSymbols));
            } else {
              String errorMessage = 'Opps! Something is wrong';
              if (response?.containsKey('error') &&
                  response['error'] != null &&
                  response['error'].containsKey('message')) {
                errorMessage = response['error']['message'];
              }
              emit(ErrorState(errorMessage));
            }
          } on Exception catch (e) {
            emit(ErrorState(e.toString()));
          } finally {
            _webSocketService.closeWebSocketConnection();
          }
        },
        onError: (error) {
        emit(ErrorState(error.toString()));
      }
    );
  }

  void sendActiveSymbolsRequest() {
    _webSocketService.transmitWebSocketMessage({
      "active_symbols": 'brief',
    });
  }

}

abstract class ActiveSymbolsState extends Equatable {}

class InitialState extends ActiveSymbolsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ActiveSymbolsState {
  @override
  List<Object> get props => [];
}

class LoadedState extends ActiveSymbolsState {
  LoadedState(this.activeSymbols);

  final List<ActiveSymbolModel> activeSymbols;

  @override
  List<Object> get props => [activeSymbols];
}

class ErrorState extends ActiveSymbolsState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}


