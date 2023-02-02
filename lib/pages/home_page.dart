import 'package:authenticate_bloc/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(
                "Welcome ${user.email} ",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(UserLoggedOut());
                },
                child: const Text("Log out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
