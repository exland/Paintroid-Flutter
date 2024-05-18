// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:paintroid/core/commands/command_implementation/graphic/graphic_command.dart';
import 'package:paintroid/core/commands/path_with_action_history.dart';
import 'package:paintroid/core/json_serialization/converter/offset_converter.dart';
import 'package:paintroid/core/json_serialization/converter/paint_converter.dart';
import 'package:paintroid/core/json_serialization/converter/path_with_action_history_converter.dart';
import 'package:paintroid/core/json_serialization/versioning/serializer_version.dart';
import 'package:paintroid/core/json_serialization/versioning/version_strategy.dart';

part 'line_command.g.dart';

@JsonSerializable()
class LineCommand extends GraphicCommand {
  final String type;
  final int version;
  bool isSourcePath = false;

  @PathWithActionHistoryConverter()
  PathWithActionHistory path;

  @OffsetConverter()
  Offset startPoint;

  @OffsetConverter()
  Offset endPoint;

  LineCommand(
    this.path,
    super.paint,
    this.startPoint,
    this.endPoint, {
    this.type = SerializerType.LINE_COMMAND,
    int? version,
  }) : version =
            version ?? VersionStrategyManager.strategy.getLineCommandVersion();

  @override
  void call(Canvas canvas) {
    canvas.drawPath(path.path, paint);
  }

  @override
  List<Object?> get props => [paint, path];

  void setAsSourcePath() {
    isSourcePath = true;
  }

  void updatePath(PathWithActionHistory newPath) {
    path = newPath;
  }

  @override
  Map<String, dynamic> toJson() => _$LineCommandToJson(this);

  factory LineCommand.fromJson(Map<String, dynamic> json) {
    int version = json['version'] as int;

    switch (version) {
      case Version.v1:
        return _$LineCommandFromJson(json);
      case Version.v2:
      // For different versions of PathCommand the deserialization
      // has to be implemented manually.
      // Autogenerated code can only be used for one version
      default:
        return _$LineCommandFromJson(json);
    }
  }
}
