import 'package:collection/collection.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

///
class WidgetbookWidget extends ExpandableOrganizer {
  WidgetbookWidget({
    required String name,
    required this.useCases,
    bool isExpanded = false,
  }) : super(
          name: name,
          isExpanded: isExpanded,
        ) {
    for (final state in useCases) {
      state.parent = this;
    }
  }

  /// Use cases define specific configurations of a widget which allows
  /// rendering the widget in isolation
  final List<WidgetbookUseCase> useCases;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WidgetbookWidget && listEquals(other.useCases, useCases);
  }

  @override
  int get hashCode => useCases.hashCode;
}
