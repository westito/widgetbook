import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/models/app_info.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/widgets/header.dart';
import 'package:widgetbook/src/widgets/search_bar.dart';
import 'package:widgetbook/src/widgets/tiles/category_tile.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    Key? key,
    required this.appInfo,
    required this.categories,
  }) : super(key: key);

  final AppInfo appInfo;
  final List<WidgetbookCategory> categories;

  @override
  _NavigationPanelState createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  static double _scrollPosition = 0;

  final ScrollController controller =
      ScrollController(initialScrollOffset: _scrollPosition);
  WidgetbookUseCase? selectedComponent;

  final TextEditingController search = TextEditingController();
  String query = '';

  Widget _buildCategory(BuildContext context, int i) {
    final item = widget.categories[i];
    return CategoryTile(category: item);
  }

  @override
  void initState() {
    controller.addListener(() {
      _scrollPosition = controller.offset;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            appInfo: widget.appInfo,
          ),
          const SizedBox(
            height: 16,
          ),
          SearchBar(
            theme: ThemeProvider.of(context)!.state,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Radii.defaultRadius,
              ),
              padding: const EdgeInsets.all(16),
              child: Builder(
                builder: (context) {
                  return ListView.separated(
                    controller: controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.categories.length,
                    itemBuilder: _buildCategory,
                    padding: const EdgeInsets.only(bottom: 8),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
