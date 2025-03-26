import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/config/supabase_config.dart';
import 'features/auth/data/repositories/supabase_auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  final authRepository = SupabaseAuthRepository();
  
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final SupabaseAuthRepository authRepository;

  const MyApp({
    super.key,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        signInUseCase: SignIn(authRepository),
        signUpUseCase: SignUp(authRepository),
      ),
      child: MaterialApp(
        title: 'Khazana',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF2196F3),
          scaffoldBackgroundColor: const Color(0xFF1A1A1A),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF2196F3),
            secondary: const Color(0xFF2196F3),
            background: const Color(0xFF1A1A1A),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
