import 'package:authenticate_bloc/blocs/authentication/authentication_bloc.dart';
import 'package:authenticate_bloc/blocs/login/login_bloc.dart';
import 'package:authenticate_bloc/pages/home_page.dart';
import 'package:authenticate_bloc/pages/login_page.dart';
import 'package:authenticate_bloc/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationService: context.read<AuthenticationService>())
                ..add(AppLoaded())),
          BlocProvider(
              create: (context) => LoginBloc(
                  authenticationService: context.read<AuthenticationService>(),
                  authenticationBloc: context.read<AuthenticationBloc>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return HomePage(user: state.user);
              }
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
