// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_symbol_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveSymbolModel _$ActiveSymbolModelFromJson(Map<String, dynamic> json) =>
    ActiveSymbolModel(
      symbolName: json['display_name'] as String,
      symbol: json['symbol'] as String,
      marketName: json['market_display_name'] as String,
      market: json['market'] as String,
    );

Map<String, dynamic> _$ActiveSymbolModelToJson(ActiveSymbolModel instance) =>
    <String, dynamic>{
      'display_name': instance.symbolName,
      'symbol': instance.symbol,
      'market_display_name': instance.marketName,
      'market': instance.market,
    };
