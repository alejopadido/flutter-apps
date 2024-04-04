import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

final isDarkmodeProvider = StateProvider<bool>((ref) => false);

// Inmutable color list
final colorListProvider = Provider((ref) => colorList);

// Index of the selected color
final selectedColorProvider = StateProvider((ref) => 0);
