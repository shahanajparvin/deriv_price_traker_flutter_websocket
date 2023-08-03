import 'package:deriv_flutter_excercise/Models/drop_down_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/active_symbol_model.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(InitialState());

  generateMarketsFromActiveSymbols(List<ActiveSymbolModel> activeSymbols) {
    List<DropDownItemModel> markets = activeSymbols
        .map((symbol) => symbol.market)
        .toSet()
        .map((market) => DropDownItemModel(
            name: activeSymbols
                .firstWhere((symbol) => symbol.market == market)
                .marketName,
            value: market))
        .toList();
    emit(MarketLoadedState(markets));
  }
}

abstract class MarketState extends Equatable {}

class InitialState extends MarketState {
  @override
  List<Object> get props => [];
}

class MarketLoadedState extends MarketState {
  MarketLoadedState(this.markets);

  final List<DropDownItemModel> markets;

  @override
  List<Object> get props => [markets];
}
