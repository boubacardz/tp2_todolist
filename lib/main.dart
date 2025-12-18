import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];

  final TextEditingController titreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }


  void _showAddTaskDialog() {
    selectedImage = null; // reset image à chaque nouveau formulaire

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ajouter une tâche'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titreController,
                  decoration: InputDecoration(labelText: 'Titre'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Choisir une image'),
                ),
                SizedBox(height: 10),
                selectedImage != null
                    ? Image.file(selectedImage!, width: 100, height: 100)
                    : SizedBox(),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                titreController.clear();
                descriptionController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Ajouter'),
              onPressed: () {
                if (titreController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  setState(() {
                    tasks.add({
                      'titre': titreController.text,
                      'description': descriptionController.text,
                      'image': selectedImage, // peut être null
                    });
                  });
                  titreController.clear();
                  descriptionController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }


  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  Widget _buildImage(Map<String, dynamic> task) {
    if (task['image'] != null) {
      return Image.file(
        task['image'],
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/default.png',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List Avancée',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(
        child: Text(
          'Aucune tâche pour le moment',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              leading: _buildImage(tasks[index]),
              title: Text(
                tasks[index]['titre'],
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(tasks[index]['description']),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteTask(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
