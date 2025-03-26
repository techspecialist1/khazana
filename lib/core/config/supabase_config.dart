import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = 'https://irecaageayfpzvckzprc.supabase.co/';
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlyZWNhYWdlYXlmcHp2Y2t6cHJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI4ODg0NzMsImV4cCI6MjA1ODQ2NDQ3M30.2PWF2ZgpfPQ8zju2vqc4mLWgkyWV23MdorWPzhd2OoI';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      debug: false,
    );
  }
} 