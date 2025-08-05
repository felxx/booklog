import 'package:booklog/core/auth/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Connection {
  static final SupabaseService _supabaseService = SupabaseService();

  static SupabaseClient get client => _supabaseService.client;

  static SupabaseQueryBuilder from(String table) => client.from(table);
}