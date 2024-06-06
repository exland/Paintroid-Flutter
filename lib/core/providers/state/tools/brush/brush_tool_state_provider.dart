// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:paintroid/core/commands/graphic_factory/graphic_factory_provider.dart';
import 'package:paintroid/core/providers/state/tools/brush/brush_tool_state_data.dart';

// Project imports:
part 'brush_tool_state_provider.g.dart';

@riverpod
class BrushToolStateProvider extends _$BrushToolStateProvider {
  void updateStrokeWidth(double newStrokeWidth) {
    Paint newPaint = state.paint..strokeWidth = newStrokeWidth;
    state = state.copyWith(paint: newPaint);
  }

  void updateStrokeCap(StrokeCap newStrokeCap) {
    Paint newPaint = state.paint..strokeCap = newStrokeCap;
    state = state.copyWith(paint: newPaint);
  }

  void updateColor(Color newColor) {
    Paint newPaint = state.paint..color = newColor;
    state = state.copyWith(paint: newPaint);
  }

  void updateBlendMode(BlendMode newMode) {
    Paint newPaint = state.paint..blendMode = newMode;
    state = state.copyWith(paint: newPaint);
  }

  @override
  BrushToolStateData build() {
    return BrushToolStateData(
      paint: ref.watch(graphicFactoryProvider).createPaint()
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..color = const Color(0xFF830000)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 25,
    );
  }
}
