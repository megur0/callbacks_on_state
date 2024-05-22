import 'package:callbacks_on_state/src/callbacks_on_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("", () {
    testWidgets("正常系", (tester) async {
      final notifier = ChangeNotifier();
      int a = 5;
      await tester.pumpWidget(MaterialApp(
        home: ListenableBuilder(
          builder: (context, child) => _Child(a),
          listenable: notifier,
        ),
      ));
      await tester.pump();
      expect(find.text("body text"), findsOne);
      expect(_ChildState.counter, 0);
      notifier.notifyListeners();
      await tester.pump();
      expect(_ChildState.counter, 1);
    });
  });
}

class _Child extends StatefulWidget {
  const _Child(this.arg);

  final int? arg;

  @override
  State<_Child> createState() => _ChildState();
}

class _ChildState extends State<_Child> with CallbacksOnStateMethod {
  static int counter = 0;

  @override
  void initState() {
    counter.onDidUpdateWidget(this, () {
      counter++;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        centerTitle: true,
      ),
      body: const Center(child: Text("body text")),
    );
  }
}
