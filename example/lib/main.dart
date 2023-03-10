import 'package:flutter/material.dart';
import 'package:flutter_heros/flutter_heros.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'Example',
          widgets: [
            WidgetbookComponent(
              name: 'Hello World',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => ExampleWidget(
                    text: context.knobs.nullableText(
                        label: 'Text', initialValue: 'Hello World'),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'Flutter heros'),
    );
  }
}
