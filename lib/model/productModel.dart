import 'package:json_annotation/json_annotation.dart';

part 'productModel.g.dart';


@JsonSerializable()
class Product {
  @JsonKey(name:'_id')
  String? id;
  String? productName;
  String? productDesc;
  double? productDisplayPrice;
  double? productActualPrice;
  String? productThumbnail;

  Product(
      {this.id,
      this.productName,
      this.productDesc,
      this.productDisplayPrice,
      this.productActualPrice,
      this.productThumbnail,
      });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
