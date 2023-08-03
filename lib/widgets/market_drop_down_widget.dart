import 'package:deriv_flutter_excercise/cubits/price_cubit.dart';
import 'package:deriv_flutter_excercise/cubits/symbol_selected_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/drop_down_item_model.dart';
import '../cubits/active_symbols_cubit.dart';
import '../cubits/market_cubit.dart';
import '../cubits/symbol_cubit.dart';
import 'drop_down_widget.dart';

class MarketDropDownWidget extends StatelessWidget {
  const MarketDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, MarketState>(
      builder: (context, state) {
        if (state is MarketLoadedState) {
          return DropDownWidget(
              hintTitle: 'Select a Market',
              dropDownItemList: _createDropDownItems(state),
              onItemSelect: (value) {
                _onMarketSelected(context, value);
              });
        } else {
          return const SizedBox();
        }
      },
    );
  }

  List<DropdownMenuItem<String>> _createDropDownItems(MarketLoadedState state){
    List<DropDownItemModel> markets = state.markets;
    List<DropdownMenuItem<String>> dropDownItems = markets.map((market) => DropdownMenuItem(
      value: market.value,
      child: Text(market.name),
    )).toList();
    return dropDownItems;
  }

  void _onMarketSelected(BuildContext context, String marketValue) {
    final activeSymbolCubit = BlocProvider.of<ActiveSymbolsCubit>(context);
    final activeSymbolState = activeSymbolCubit.state;
    if (activeSymbolState is LoadedState) {
      BlocProvider.of<PriceCubit>(context).initializePrice();
      BlocProvider.of<SymbolSelectionCubit>(context).setLoadingState();
      final activeSymbols = activeSymbolState.activeSymbols;
      BlocProvider.of<SymbolsCubit>(context).getSymbolListByMarketCategory(activeSymbols, marketCategory: marketValue);
    }
  }
}

