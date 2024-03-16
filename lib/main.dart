import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/widgets/cards.dart';
import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';

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
        useMaterial3: true,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: C.paddings.defaultPadding,
        child: ListView(
          children: _buildPaddedCardSection(context) +
              _buildDivider() +
              _buildErrorScreenSection(context),
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
    const Text(
      'PaddedCard is a Card with the default cadanse padding.',
    ),
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
      'ErrorScreen can optionally have a description to provide more context.',
    ),
    C.spacers.verticalContent,
    WidgetDemoFrame(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16.0,
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

class WidgetDemoFrame extends StatelessWidget {
  const WidgetDemoFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: C.paddings.defaultPadding,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: child,
    );
  }
}
