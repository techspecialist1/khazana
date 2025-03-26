import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import 'session_manager.dart';

class AuthState extends ChangeNotifier {
  final SupabaseClient _supabase = SupabaseConfig.client;
  User? _currentUser;
  bool _isLoading = true;

  AuthState() {
    _initialize();
  }

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> _initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      final hasLocalSession = await SessionManager.hasSession();
      if (hasLocalSession) {
        final sessionData = await SessionManager.getSession();
        if (sessionData != null && sessionData['access_token'] != null) {
          try {
            final response = await _supabase.auth.recoverSession(sessionData['access_token'] as String);
            if (response.session != null) {
              _currentUser = response.session!.user;
              await SessionManager.saveSession(response.session!);
              await SessionManager.saveUser(response.session!.user);
            }
          } catch (e) {
            await SessionManager.clearSession();
          }
        }
      }

      _supabase.auth.onAuthStateChange.listen((data) async {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        switch (event) {
          case AuthChangeEvent.signedIn:
            if (session != null) {
              _currentUser = session.user;
              await SessionManager.saveSession(session);
              await SessionManager.saveUser(session.user);
            }
            break;
          case AuthChangeEvent.signedOut:
            _currentUser = null;
            await SessionManager.clearSession();
            break;
          case AuthChangeEvent.tokenRefreshed:
            if (session != null) {
              _currentUser = session.user;
              await SessionManager.saveSession(session);
            }
            break;
          case AuthChangeEvent.userUpdated:
            if (session != null) {
              _currentUser = session.user;
              await SessionManager.saveUser(session.user);
            }
            break;
          default:
            break;
        }
        notifyListeners();
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    await SessionManager.clearSession();
    _currentUser = null;
    notifyListeners();
  }
} 