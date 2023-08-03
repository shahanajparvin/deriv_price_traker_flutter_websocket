import 'package:deriv_flutter_excercise/cubits/price_cubit.dart';
import 'package:deriv_flutter_excercise/cubits/symbol_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/drop_down_item_model.dart';
import '../cubits/symbol_selected_cubit.dart';
import 'drop_down_widget.dart';

class SymbolDropDownWidget extends StatelessWidget {
  const SymbolDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymbolsCubit, SymbolsState>(
      builder: (context, state) {
        if (state is SymbolLoadedState) {
          List<DropdownMenuItem<String>> dropDownItems = _createDropDownItems(state);
          _selectInitialSymbol(context, dropDownItems);
          return SymbolDropDownChildWidget(dropDownItems: dropDownItems);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  List<DropdownMenuItem<String>> _createDropDownItems(SymbolLoadedState state){
    List<DropDownItemModel> symbols = state.symbols;
    List<DropdownMenuItem<String>> dropDownItems = symbols.map((symbol) => DropdownMenuItem(
      value: symbol.value,
      child: Text(symbol.name),
    )).toList();
    return dropDownItems;
  }

  void _selectInitialSymbol(BuildContext context, List<DropdownMenuItem<String>> dropDownItems) {
    final selectedSymbolCubit = BlocProvider.of<SymbolSelectionCubit>(context);
    if (selectedSymbolCubit.state is SymbolSelectLoadingState) {
      selectedSymbolCubit.setSelectSymbol(dropDownItems[0].value.toString());
    } else {
      selectedSymbolCubit.setInitialState();
    }
  }
}


class SymbolDropDownChildWidget extends StatelessWidget {
  final List<DropdownMenuItem<String>> dropDownItems;
  const SymbolDropDownChildWidget({Key? key, required this.dropDownItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymbolSelectionCubit, SymbolSelectState>(
        builder: (context, state) {
          if (state is SymbolSelectLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is SymbolSelectInitialState) {
            return DropDownWidget(
                hintTitle: 'Select a Asset',
                dropDownItemList: dropDownItems,
                onItemSelect: (value) {
                  BlocProvider.of<PriceCubit>(context).startLoadingPrice();
                  BlocProvider.of<PriceCubit>(context).getRequestTicketPrice(symbol: value.toString());
                });
          } else if (state is SymbolSelectLoadedState) {
            return DropDownWidget(
                hintTitle: 'Select a Asset',
                selectedValue: state.selectedValue,
                dropDownItemList: dropDownItems,
                onItemSelect: (value) {
                  BlocProvider.of<PriceCubit>(context).startLoadingPrice();
                  BlocProvider.of<PriceCubit>(context).getRequestTicketPrice(symbol: value.toString());
                });
          }
          return const SizedBox();
        });
  }
}

