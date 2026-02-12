import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: ListView.builder(
        itemBuilder: (_, index) {
          var note = results[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) => deleteNote(note),
            child: Card(
              child: ListTile(
                onTap: () {
                  showNoteDialog('update', note);
                },
                title: Text(note.title),
                trailing: Text(DateFormat.yMd().format(note.date!)),
              ),
            ),
          );
        },
        itemCount: results.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog('add', null),
        child: Icon(Icons.add),
      ),
    );
  }

  void showNoteDialog(String operation, Note? n) {
    titleCtrl.text = n?.title ?? '';
    contentCtrl.text = n?.content ?? '';

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () => operation == 'add' ? addNote() : updateNote(n!),
              child: Text(operation == 'add' ? 'ADD' : 'UPDATE'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
          title: Text(operation == 'add' ? 'Add Note' : 'Update Note'),
          content: Column(
            mainAxisSize: .min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
              ),
              Gap(12),
              TextField(
                controller: contentCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Note'),
                ),
              ),
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
    loadNotes();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Note added')));
  }

  void deleteNote(Note n) {
    realm.write(() {
      realm.delete(n);
    });
    loadNotes();
  }

  void updateNote(Note n) {
    realm.write(() {
      n.title = titleCtrl.text;
      n.content = contentCtrl.text;
      realm.add(n, update: true);
    });
    Navigator.pop(context);
    loadNotes();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Note updated')));
  }
}
