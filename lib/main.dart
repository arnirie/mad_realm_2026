import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_2026/car.dart';
import 'package:realm_2026/note.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NotesScreen());
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Realm realm;
  late RealmResults<Note> results;
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    var config = Configuration.local([Note.schema]);
    realm = Realm(config);
    loadNotes();
  }

  void loadNotes() {
    results = realm.all<Note>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: ListView.builder(
        itemBuilder: (_, index) {
          var note = results[index];
          return ListTile(title: Text(note.title));
        },
        itemCount: results.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          actions: [TextButton(onPressed: addNote, child: Text('ADD'))],
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: .min,
            children: [
              TextField(controller: titleCtrl),
              TextField(controller: contentCtrl),
            ],
          ),
        );
      },
    );
  }

  void addNote() {
    realm.write(() {
      var note = Note(titleCtrl.text, contentCtrl.text, date: DateTime.now());
      realm.add(note);
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Note added')));
  }
}
