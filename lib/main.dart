// Started with https://docs.flutter.dev/development/ui/widgets-intro
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:to_dont_list/event_items.dart';
import 'package:to_dont_list/to_do_items.dart';

List<Event> sprints = [
  Event(event: "400M", mark: "49.03", year: "2022", meet: "UCA")
];
List<Event> distance = [
  Event(event: "1600M", mark: "5:00", year: "2019", meet: "Arkansas State")
];

class TrackList extends StatefulWidget {
  const TrackList({key, required this.title}) : super(key: key);

  @override
  State createState() => _TrackListState();
  final String title;
}

class _TrackListState extends State<TrackList> {
  var eventController = TextEditingController();
  var markController = TextEditingController();
  var yearController = TextEditingController();
  var meetController = TextEditingController();
  //Form code comes from https://stackoverflow.com/questions/54480641/flutter-how-to-create-forms-in-popup
  // ignore: non_constant_identifier_names
  Future<void> _EventInfoPopupForm(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: SingleChildScrollView(
            child: Container(
              height: 200,
              width: 200,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key("EventField"),
                    controller: eventController,
                    decoration: InputDecoration(hintText: 'Event'),
                  ),
                  TextFormField(
                    key: const Key("MarkField"),
                    controller: markController,
                    decoration: InputDecoration(hintText: 'Mark'),
                  ),
                  TextFormField(
                    key: const Key("YearField"),
                    controller: yearController,
                    decoration: InputDecoration(hintText: 'Year'),
                  ),
                  TextFormField(
                    key: const Key("MeetField"),
                    controller: meetController,
                    decoration: InputDecoration(hintText: 'Meet'),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              key: const Key("OKButton"),
              onPressed: () {
                setState(() {
                  _handleTrackItem(eventController.text, markController.text,
                      yearController.text, meetController.text);
                  Navigator.pop(context);
                });
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _handleTrackItem(event, mark, year, meet) {
    setState(() {
      Event _event = Event(event: event, mark: mark, year: year, meet: meet);
      sprints.insert(0, _event);
      eventController.clear();
      markController.clear();
      yearController.clear();
      meetController.clear();
    });
  }

  void _handleEventEdit(Event event) {
    setState(() {
      sprints.remove(event);
      _EventInfoPopupForm(context);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sprint Personal Records'),
        ),
        // drawer code from https://rushabhshah065.medium.com/flutter-navigation-drawer-tab-layout-e74074c249ce
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Text(
                  "Type of Event",
                  textAlign: TextAlign.justify,
                  textScaleFactor: 2.0,
                ),
              ),
              ListTile(
                  title: Text("Sprints"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TrackList(title: 'Sprints');
                    }));
                  }),
              ListTile(
                title: Text("Distance"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const TrackList(title: 'Distance');
                  }));
                },
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sprints.map((item) {
            return EventItem(
              event: item,
              eventEdit: _handleEventEdit,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _EventInfoPopupForm(context);
            }));
  }
}

// UNNEEDED CLASS (BOTH PAGES CALL TRACKLIST CLASS)

// class SecondPage extends StatefulWidget {
//   const SecondPage({key, required this.title}) : super(key: key);
//   @override
//   State createState() => _SecondPageState();
//   final String title;
// }

// class _SecondPageState extends State<SecondPage> {
//   var eventController = TextEditingController();
//   var markController = TextEditingController();
//   var yearController = TextEditingController();
//   var meetController = TextEditingController();
//   //Form code comes from https://stackoverflow.com/questions/54480641/flutter-how-to-create-forms-in-popup
//   // ignore: non_constant_identifier_names
//   Future<void> _EventInfoPopupForm(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Event'),
//           content: SingleChildScrollView(
//             child: Container(
//               height: 200,
//               width: 200,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: eventController,
//                     decoration: InputDecoration(hintText: 'Event'),
//                   ),
//                   TextFormField(
//                     controller: markController,
//                     decoration: InputDecoration(hintText: 'Mark'),
//                   ),
//                   TextFormField(
//                     controller: yearController,
//                     decoration: InputDecoration(hintText: 'Year'),
//                   ),
//                   TextFormField(
//                     controller: meetController,
//                     decoration: InputDecoration(hintText: 'Meet'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _handleTrackItem(eventController.text, markController.text,
//                       yearController.text, meetController.text);
//                   Navigator.pop(context);
//                 });
//               },
//               child: Text('Send'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String valueText = "";

//   //final List<Item> items = [const Item(name: "Add homework")];

//   final _itemSet = <Item>{};

//   void _handleTrackItem(event, mark, year, meet) {
//     setState(() {
//       Event _event = Event(event: event, mark: mark, year: year, meet: meet);
//       sprints.insert(0, _event);
//       eventController.clear();
//       markController.clear();
//       yearController.clear();
//       meetController.clear();
//     });
//   }

//   void _handleEventEdit(Event event) {
//     setState(() {
//       sprints.remove(event);
//       _EventInfoPopupForm(context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Distance Personal Records'),
//         ),
//         // drawer code from https://rushabhshah065.medium.com/flutter-navigation-drawer-tab-layout-e74074c249ce
//         drawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.green),
//                 child: Text(
//                   "Type of Event",
//                   textAlign: TextAlign.justify,
//                   textScaleFactor: 2.0,
//                 ),
//               ),
//               ListTile(
//                   title: Text("Sprints"),
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return const TrackList(title: 'Sprints');
//                     }));
//                   }),
//               ListTile(
//                 title: Text("Distance"),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const SecondPage(title: 'Distance');
//                   }));
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           children: distance.map((item) {
//             return EventItem(
//               event: item,
//               eventEdit: _handleEventEdit,
//             );
//           }).toList(),
//         ),
//         floatingActionButton: FloatingActionButton(
//             child: const Icon(Icons.add),
//             onPressed: () {
//               _EventInfoPopupForm(context);
//             }));
//   }
// }

void main() {
  runApp(const MaterialApp(
    title: 'Sprint PRs',
    home: TrackList(
      title: 'Sprint PR',
    ),
  ));
}
