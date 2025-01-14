import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

class PickedAssetModel {
  String? id;
  String? path;
  String? type;
  Duration? videoDuration;
  DateTime? createDateTime;
  double? latitude;
  double? longitude;
  Uint8List? thumbnail;
  int? height;
  int? width;
  int? orientationHeight;
  int? orientationWidth;
  int? orientation;
  Size? orientationSize;
  File? file;
  DateTime? modifiedDateTime;
  String? title;
  Size? size;

  PickedAssetModel({
    this.id,
    this.path,
    this.type,
    this.videoDuration,
    this.createDateTime,
    this.latitude,
    this.longitude,
    this.thumbnail,
    this.height,
    this.width,
    this.orientationHeight,
    this.orientationWidth,
    this.orientationSize,
    this.orientation,
    this.file,
    this.modifiedDateTime,
    this.title,
    this.size,
  });

  factory PickedAssetModel.fromJson(Map<String, dynamic> json) =>
      PickedAssetModel(
        id: json["id"],
        path: json["path"],
        type: json["type"],
        videoDuration: json["videoDuration"],
        createDateTime: DateTime.parse(json["createDateTime"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        thumbnail: json["thumbnail"],
        height: json["height"],
        width: json["width"],
        orientationHeight: json["orientationHeight"],
        orientationWidth: json["orientationWidth"],
        orientationSize: json["orientationSize"],
        file: json["file"],
        modifiedDateTime: DateTime.parse(json["modifiedDateTime"]),
        title: json["title"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "type": type,
        "videoDuration": videoDuration,
        "createDateTime":
            "${createDateTime!.year.toString().padLeft(4, '0')}-${createDateTime!.month.toString().padLeft(2, '0')}-${createDateTime!.day.toString().padLeft(2, '0')}",
        "latitude": latitude,
        "longitude": longitude,
        "thumbnail": thumbnail,
        "height": height,
        "width": width,
        "orientationHeight": orientationHeight,
        "orientationWidth": orientationWidth,
        "orientationSize": orientationSize,
        "file": file,
        "modifiedDateTime":
            "${modifiedDateTime!.year.toString().padLeft(4, '0')}-${modifiedDateTime!.month.toString().padLeft(2, '0')}-${modifiedDateTime!.day.toString().padLeft(2, '0')}",
        "title": title,
        "size": size,
      };
}
