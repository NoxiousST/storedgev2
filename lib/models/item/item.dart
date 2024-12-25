import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:storedgev2/core/constants/constants.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const factory Item({
    String? id,
    @Default(defaultImage) List<String> image,
    required String name,
    required String description,
    required String category,
    required double price,
    @Default(0) int stock,
    String? supplierId
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);
}

class TempImage {
  InstaAssetsExportData? exportData;
  String? imageUrl;
  bool isFile;

  TempImage({this.exportData, this.imageUrl, required this.isFile});
}
