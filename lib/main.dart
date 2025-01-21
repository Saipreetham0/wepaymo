// lib/main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';

// const supabaseUrl = 'https://cmqixeyxxibjtpgvxpdr.supabase.co';
// const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

// void main() async {
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  await Supabase.initialize(
    url: 'https://cmqixeyxxibjtpgvxpdr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtcWl4ZXl4eGlianRwZ3Z4cGRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczNjQ2MzMsImV4cCI6MjA1Mjk0MDYzM30.I4tyAV8ArEIU9ZR2GuOAjvRVPPAdBXWHcvtKex-g1OI',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final session = snapshot.data!.session;
          if (session != null) {
            return const HomeScreen();
          }
        }
        return const LoginScreen();
      },
    );
  }
}
