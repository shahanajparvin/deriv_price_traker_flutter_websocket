import 'package:deriv_flutter_excercise/Services/web_chanel_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/active_symbols_cubit.dart';
import '../cubits/market_cubit.dart';
import '../cubits/price_cubit.dart';
import '../cubits/symbol_cubit.dart';
import '../cubits/symbol_selected_cubit.dart';
import '../screens/price_tracker_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildHomeRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _buildHomeRoute() {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ActiveSymbolsCubit(WebSocketChannelService())),
          BlocProvider(create: (_) => MarketCubit()),
          BlocProvider(create: (_) => SymbolsCubit()),
          BlocProvider(create: (_) => SymbolSelectionCubit()),
          BlocProvider(create: (_) => PriceCubit(WebSocketChannelService())),
        ],
        child: const PriceTrackingScreen(),
      ),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
