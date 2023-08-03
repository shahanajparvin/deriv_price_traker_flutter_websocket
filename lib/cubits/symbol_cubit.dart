
import 'package:deriv_flutter_excercise/Models/active_symbol_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/drop_down_item_model.dart';

class SymbolsCubit extends Cubit<SymbolsState> {

  SymbolsCubit() : super(SymbolLoadingState());

  getSymbolListByMarketCategory(List<ActiveSymbolModel> activeSymbols,{String marketCategory = ''}){
    List<DropDownItemModel> symbols = activeSymbols
        .where((activeSymbol) => marketCategory.isNotEmpty ? activeSymbol.market == marketCategory : true)
        .map((activeSymbol) => DropDownItemModel(name: activeSymbol.symbolName, value: activeSymbol.symbol))
        .toList();
    emit(SymbolLoadedState(symbols));
  }

 }

abstract class SymbolsState extends Equatable {}

class SymbolLoadingState extends SymbolsState {
  @override
  List<Object> get props => [];
}
class SymbolLoadedState extends SymbolsState {
  SymbolLoadedState(this.symbols);

  final List<DropDownItemModel> symbols;

  @override
  List<Object> get props => [symbols];
}
