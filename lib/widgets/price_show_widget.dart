import 'package:deriv_flutter_excercise/Widgets/app_loading_widget.dart';
import 'package:deriv_flutter_excercise/cubits/price_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_error_widget.dart';



class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, PriceState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case PriceInitialState:
            return const SizedBox();
          case PriceLoadingState:
            return const AppLoadingWidget();
          case PriceErrorState:
            return AppErrorWidget(errorMessage:(state as PriceErrorState).error.toString());
          case PriceLoadedState:
            return PriceShowWidget(state: (state as PriceLoadedState));
          default:
            return const SizedBox();
        };
      },
    );
  }
}

class PriceShowWidget extends StatelessWidget {
  final PriceLoadedState state;

  const PriceShowWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceCubit = BlocProvider.of<PriceCubit>(context);
    final currentPrice = state.price;
    final textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: priceCubit.priceChangeColor(currentPrice: currentPrice, previousPrice: priceCubit.previousPriceValue),
    );
    return Text('Price: $currentPrice', style: textStyle);
  }
}
