import 'package:chatbot_ai/features/siginin/signin_screen.dart';
import 'package:chatbot_ai/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: 'https://npuqlzeurphcqbjaoajp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wdXFsemV1cnBoY3FiamFvYWpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUwMTkxMTcsImV4cCI6MjA1MDU5NTExN30.o26lVJh2mmJRxtJU3RU7s4CAaVHVyLB2GC1lD1VZjRk',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const SigninScreen(),
    );
  }
}
