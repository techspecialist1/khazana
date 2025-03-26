import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
  });

  factory User.fromSupabaseUser(supabase.User supabaseUser) {
    return User(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      name: supabaseUser.userMetadata?['name'] as String?,
      avatarUrl: supabaseUser.userMetadata?['avatar_url'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, email, name, avatarUrl];
} 