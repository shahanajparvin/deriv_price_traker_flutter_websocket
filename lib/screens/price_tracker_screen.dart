import 'package:deriv_flutter_excercise/Widgets/market_drop_down_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/app_error_widget.dart';
import '../Widgets/app_loading_widget.dart';
import '../Widgets/price_show_widget.dart';
import '../Widgets/symbol_drop_down_widget.dart';
import '../cubits/active_symbols_cubit.dart';
import '../cubits/market_cubit.dart';
import '../cubits/symbol_cubit.dart';

class PriceTrackingScreen extends StatelessWidget {
  const PriceTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Price Tracker'), centerTitle: true),
        backgroundColor: Colors.white,
        body: BlocConsumer<ActiveSymbolsCubit, ActiveSymbolsState>(
          listener: (context, state) {
            if (state is LoadedState) {
              _generateMarketsAndSymbolsDropdown(
                  context: context, state: state);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingState:
                return const AppLoadingWidget();
              case ErrorState:
                return AppErrorWidget(
                    errorMessage: (state as ErrorState).error.toString());
              case LoadedState:
                return const MarketAndSymbolDropDownWidget();
              default:
                return const SizedBox();
            }
            ;
          },
        ));
  }

  _generateMarketsAndSymbolsDropdown(
      {BuildContext? context, LoadedState? state}) {
    if (context != null && state != null) {
      BlocProvider.of<MarketCubit>(context)
          .generateMarketsFromActiveSymbols(state.activeSymbols);
      BlocProvider.of<SymbolsCubit>(context)
          .getSymbolListByMarketCategory(state.activeSymbols);
    }
  }
}

class MarketAndSymbolDropDownWidget extends StatelessWidget {
  const MarketAndSymbolDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          MarketDropDownWidget(),
          SizedBox(height: 20),
          SymbolDropDownWidget(),
          SizedBox(height: 50),
          PriceWidget()
        ],
      ),
    );
  }
}
