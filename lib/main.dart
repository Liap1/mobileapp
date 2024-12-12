import 'package:flutter/material.dart';
import 'package:gamesinfo/MainScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://qpzbnzxxqkklmxhznwmb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwemJuenh4cWtrbG14aHpud21iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4MTg0OTYsImV4cCI6MjA0OTM5NDQ5Nn0.sHdohQH3WXx3n6lWuZCuMkIr9AQt4pi6m81vttojUfE',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamesINFO',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MainScreen(),
    );
  }
}
