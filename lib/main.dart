import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> tasks = [];

  final TextEditingController titreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  Uint8List? selectedImageBytes;

  Future<void> pickImage() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        selectedImageBytes = bytes;
      });
    }
  }

  void showAddTaskDialog() {
    selectedImageBytes = null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ajouter une tâche'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titreController,
                decoration: const InputDecoration(labelText: 'Titre'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Choisir une image'),
              ),
              const SizedBox(height: 10),
              if (selectedImageBytes != null)
                Image.memory(
                  selectedImageBytes!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              titreController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titreController.text.isNotEmpty) {
                setState(() {
                  tasks.add({
                    'titre': titreController.text,
                    'description': descriptionController.text,
                    'image': selectedImageBytes,
                  });
                });
                titreController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void deleteTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: showAddTaskDialog,
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('Aucune tâche'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          final task = tasks[index];
          return ListTile(
            leading: task['image'] != null
                ? Image.memory(
              task['image'],
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.task),
            title: Text(task['titre']),
            subtitle: Text(task['description'] ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}
