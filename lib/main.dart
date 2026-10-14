import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/session_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SessionProvider()),
      ],
      child: const CoopSchedulerApp(),
    ),
  );
}

class CoopSchedulerApp extends StatelessWidget {
  const CoopSchedulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Co-op Session Scheduler',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      // The Consumer listens to AuthProvider and switches screens automatically
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.user == null) {
            return const LoginScreen();
          }
          Provider.of<SessionProvider>(context, listen: false).loadUserSessions(auth.user!.uid);
          return const HomeScreen();
        },
      ),
    );
  }
}