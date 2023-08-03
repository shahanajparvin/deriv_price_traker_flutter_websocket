import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymbolSelectionCubit extends Cubit<SymbolSelectState> {
  SymbolSelectionCubit() : super(SymbolSelectInitialState());

  void setSelectSymbol(String symbol) {
    emit(SymbolSelectLoadedState(symbol));
  }

  setLoadingState(){
    emit(SymbolSelectLoadingState());
  }

  setInitialState(){
    emit(SymbolSelectInitialState());
  }

}

abstract class SymbolSelectState extends Equatable {}

class SymbolSelectInitialState extends SymbolSelectState {
  @override
  List<Object> get props => [];
}

class SymbolSelectLoadingState extends SymbolSelectState {
  @override
  List<Object> get props => [];
}

class SymbolSelectLoadedState extends SymbolSelectState {
  SymbolSelectLoadedState(this.selectedValue);

  final String selectedValue;

  @override
  List<Object> get props => [selectedValue];
}

class SymbolSelectErrorState extends SymbolSelectState {
  @override
  List<Object> get props => [];
}