import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/config/supabase_config.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart' as entities;
import '../../domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  final supabase.SupabaseClient _client = SupabaseConfig.client;

  @override
  Future<Either<Failure, entities.User>> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Left(AuthFailure(message: 'Authentication failed'));
      }

      return Right(entities.User(
        id: response.user!.id,
        email: response.user!.email!,
        name: response.user!.userMetadata?['name'],
        avatarUrl: response.user!.userMetadata?['avatar_url'],
      ));
    } on supabase.AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AuthFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, entities.User>> signUp(String email, String password, String name) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'avatar_url': null,
        },
      );

      if (response.user == null) {
        return Left(AuthFailure(message: 'Registration failed'));
      }

      return Right(entities.User(
        id: response.user!.id,
        email: response.user!.email!,
        name: name,
        avatarUrl: null,
      ));
    } on supabase.AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AuthFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _client.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: 'Failed to sign out'));
    }
  }

  @override
  Future<Either<Failure, entities.User?>> getCurrentUser() async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) {
        return const Right(null);
      }

      return Right(entities.User(
        id: currentUser.id,
        email: currentUser.email!,
        name: currentUser.userMetadata?['name'],
        avatarUrl: currentUser.userMetadata?['avatar_url'],
      ));
    } catch (e) {
      return Left(AuthFailure(message: 'Failed to get current user'));
    }
  }
} 