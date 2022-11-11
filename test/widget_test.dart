// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/event_items.dart';

import 'package:to_dont_list/main.dart';

// unneeded import
// import 'package:to_dont_list/to_do_items.dart';

void main() {
  // test('Item abbreviation should be first letter', () {
  //   const item = Item(name: "add more todos");
  //   expect(item.abbrev(), "a");
  // });

  // // Yes, you really need the MaterialApp and Scaffold
  // testWidgets('ToDoListItem has a text', (tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //       home: Scaffold(
  //           body: ToDoListItem(
  //               item: const Item(name: "test"),
  //               completed: true,
  //               onListChanged: (Item item, bool completed) {},
  //               onDeleteItem: (Item item) {}))));
  //   final textFinder = find.text('test');

  //   // Use the `findsOneWidget` matcher provided by flutter_test to verify
  //   // that the Text widgets appear exactly once in the widget tree.
  //   expect(textFinder, findsOneWidget);
  // });

  // testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
  //     (tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //       home: Scaffold(
  //           body: ToDoListItem(
  //               item: const Item(name: "test"),
  //               completed: true,
  //               onListChanged: (Item item, bool completed) {},
  //               onDeleteItem: (Item item) {}))));
  //   final abbvFinder = find.text('t');
  //   final avatarFinder = find.byType(CircleAvatar);

  //   CircleAvatar circ = tester.firstWidget(avatarFinder);
  //   Text ctext = circ.child as Text;

  //   // Use the `findsOneWidget` matcher provided by flutter_test to verify
  //   // that the Text widgets appear exactly once in the widget tree.
  //   expect(abbvFinder, findsOneWidget);
  //   expect(circ.backgroundColor, Colors.black54);
  //   expect(ctext.data, "t");
  // });

  // testWidgets('Default ToDoList has one item', (tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //       home: ToDoList(
  //     title: "Personal List",
  //   )));

  //   final listItemFinder = find.byType(ToDoListItem);

  //   expect(listItemFinder, findsOneWidget);
  // });

  // testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
  //   await tester
  //       .pumpWidget(const MaterialApp(home: ToDoList(title: "Personal List")));

  //   expect(find.byType(TextField), findsNothing);

  //   await tester.tap(find.byType(FloatingActionButton));
  //   await tester.pump(); // Pump after every action to rebuild the widgets
  //   expect(find.text("hi"), findsNothing);

  //   await tester.enterText(find.byType(TextField), 'hi');
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   await tester.tap(find.byKey(const Key("OKButton")));
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   final listItemFinder = find.byType(ToDoListItem);

  //   expect(listItemFinder, findsNWidgets(2));
  // });

  testWidgets("An event item as all required fields", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: EventItem(
      event:
          const Event(event: "400m", mark: "49.03", year: "2022", meet: "UCA"),
      eventEdit: (Event event) {},
    ))));
    final textFinderEvent = find.text('400m');
    final textSubtitle = find.text("Mark: 49.03, Where: UCA 2022");

    expect(textFinderEvent, findsOneWidget);
    expect(textSubtitle, findsOneWidget);
  });

  testWidgets("List by default has one item", (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: TrackList(
      title: "Sprint PR",
    )));

    final trackItemFinder = find.byType(EventItem);

    expect(trackItemFinder, findsOneWidget);
  });

  testWidgets("Clicking and typing adds items to the Track List",
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TrackList(title: "Test")));

    expect(find.byType(TextFormField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byKey(const Key("EventField")), "100M");
    await tester.pump();
    expect(find.text("100M"), findsOneWidget);

    await tester.enterText(find.byKey(const Key("MarkField")), "10.99");
    await tester.pump();
    expect(find.text("10.99"), findsOneWidget);

    await tester.enterText(find.byKey(const Key("YearField")), "2022");
    await tester.pump();
    expect(find.text("2022"), findsOneWidget);

    await tester.enterText(find.byKey(const Key("MeetField")), "SAU");
    await tester.pump();
    expect(find.text("SAU"), findsOneWidget);

    await tester.tap(find.byKey(const Key("send")));
    await tester.pump();

    final textFinderEvent = find.byType(EventItem);
    expect(textFinderEvent, findsNWidgets(2));
  });
}
