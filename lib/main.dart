import 'package:booklog/config/app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://apeyaealkxrifyyzojie.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwZXlhZWFsa3hyaWZ5eXpvamllIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzOTMzOTcsImV4cCI6MjA2OTk2OTM5N30.7XFrr1vUDxe7Qn3LNAJTAqdr7CWRiTjzSJM43Y7KznU',
  );
  runApp(const App());
}