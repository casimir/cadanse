import 'package:flutter/material.dart';

import 'cadanse.dart';
import 'components/layouts/container.dart';
import 'components/widgets/adaptive/actions_menu.dart';
import 'components/widgets/cards.dart';
import 'components/widgets/error.dart';
import 'tokens/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadanse Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HomePage(title: 'Cadanse Components Demo'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO add a link to the source code
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ResponsiveContainer(
        padding: C.paddings.group,
        child: ListView(
          children: [
            ..._buildPaddedCardSection(context),
            ..._buildDivider(),
            ..._buildErrorScreenSection(context),
            ..._buildDivider(),
            ..._buildActionsMenuSection(context),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildDivider() {
  return [
    C.spacers.verticalContent,
    const Divider(),
    C.spacers.verticalContent,
  ];
}

List<Widget> _buildPaddedCardSection(BuildContext context) {
  return [
    Text('PaddedCard', style: Theme.of(context).textTheme.titleLarge),
    C.spacers.verticalContent,
    const Text('PaddedCard is a Card with the default cadanse padding.'),
    C.spacers.verticalContent,
    const WidgetDemoFrame(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          PaddedCard(
            child: Text('This is a PaddedCard.'),
          ),
        ],
      ),
    ),
  ];
}

List<Widget> _buildErrorScreenSection(BuildContext context) {
  final exceptionExample = Exception('Something went horribly wrong!');

  return [
    Text('ErrorScreen', style: Theme.of(context).textTheme.titleLarge),
    C.spacers.verticalContent,
    const Text(
        'ErrorScreen is a content placeholder to show in case of loading error. '
        'In the following example the widget as been embedded in a PaddedCard for better readability.'),
    const Text(
        'ErrorScreen can optionally have a description to provide more context.'),
    C.spacers.verticalContent,
    WidgetDemoFrame(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: kSpacingBetweenGroups,
        children: [
          PaddedCard(
            child: ErrorScreen(error: exceptionExample),
          ),
          PaddedCard(
            child: ErrorScreen(
              error: exceptionExample,
              description: 'It was going so well...',
            ),
          ),
        ],
      ),
    ),
  ];
}

List<Widget> _buildActionsMenuSection(BuildContext context) {
  final actions = [
    ActionsMenuEntry(
      title: 'Send message',
      icon: Icons.send,
      onTap: () {},
    ),
    ActionsMenuEntry(
      title: 'Delete message',
      icon: C(context).icons.delete,
      onTap: () {},
      isDestructive: true,
    ),
    null,
    ActionsMenuEntry(
      title: 'Reboot the world',
      onTap: () {},
    ),
  ];

  return [
    Text('ActionsMenu', style: Theme.of(context).textTheme.titleLarge),
    C.spacers.verticalContent,
    const Text(
      'ActionsMenu is a button that opens a menu providing a list of actions. '
      'The default behavior is adaptive but it can also used explicitly as a Material '
      'Design or Human Interface Guidelines widget.',
    ),
    C.spacers.verticalContent,
    WidgetDemoFrame(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text('Adaptive'),
              C.spacers.verticalComponent,
              ActionsMenuButton(actions: actions),
            ],
          ),
          Column(
            children: [
              const Text('Material 3'),
              C.spacers.verticalComponent,
              ActionsMenuButton.material(actions: actions),
            ],
          ),
          Column(
            children: [
              const Text('HIG'),
              C.spacers.verticalComponent,
              ActionsMenuButton.human(actions: actions),
            ],
          ),
        ],
      ),
    ),
  ];
}

class WidgetDemoFrame extends StatelessWidget {
  const WidgetDemoFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: C.paddings.group,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: child,
    );
  }
}
