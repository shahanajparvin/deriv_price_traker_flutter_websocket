import 'package:json_annotation/json_annotation.dart';

part 'active_symbol_model.g.dart';

@JsonSerializable()
class ActiveSymbolModel {
  @JsonKey(name: 'display_name')
  final String symbolName;
  @JsonKey(name: 'symbol')
  final String symbol;
  @JsonKey(name: 'market_display_name')
  final String marketName;
  @JsonKey(name: 'market')
  final String market;

  ActiveSymbolModel(
      {required this.symbolName,
      required this.symbol,
      required this.marketName,
      required this.market});

  factory ActiveSymbolModel.fromJson(Map<String, dynamic> map) =>
      _$ActiveSymbolModelFromJson(map);

  Map<String, dynamic> toJson() => _$ActiveSymbolModelToJson(this);
}
