import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/session_model.dart';
import '../providers/session_provider.dart';
import '../providers/auth_provider.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _gameTitle = '';
  String _hostName = '';

 void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // 1. Declare authUser here, inside the function
      final authUser = Provider.of<AuthProvider>(context, listen: false).user;
      
      // 2. Now use it to build the session
      final newSession = Session(
        id: '', 
        title: _title,
        gameTitle: _gameTitle,
        hostId: authUser?.uid ?? 'unknown_user', 
        hostName: _hostName,
        scheduledTime: DateTime.now().add(const Duration(days: 1)),
        status: 'Scheduled',
        participants: [authUser?.uid ?? 'unknown_user'],
        notes: '',
      );

      Provider.of<SessionProvider>(context, listen: false).addSession(newSession);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Session')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Session Title', hintText: 'e.g., Weekend Campaign Run'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Game', hintText: 'e.g., It Takes Two'),
                validator: (value) => value!.isEmpty ? 'Please enter a game title' : null,
                onSaved: (value) => _gameTitle = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Your Name (Host)'),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => _hostName = value!,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Save Session'),
              )
            ],
          ),
        ),
      ),
    );
  }
}