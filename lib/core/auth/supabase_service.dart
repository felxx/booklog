import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  
  factory SupabaseService() => _instance;
  
  SupabaseService._internal();
  
  SupabaseClient get client => Supabase.instance.client;
  
  GoTrueClient get auth => client.auth;
  
  SupabaseQueryBuilder from(String table) => client.from(table);
  
  SupabaseStorageClient get storage => client.storage;
  
  Stream<AuthState> get authStateChanges => auth.onAuthStateChange;
  
  User? get currentUser => auth.currentUser;
  
  bool get isAuthenticated => currentUser != null;

  Future<void> signOut() async {
    await auth.signOut();
  }
  
  bool get isConnected => client.realtime.isConnected;
}
