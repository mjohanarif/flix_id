import 'package:flix_id/data/dummies/dummy_authentication_repository.dart';
import 'package:flix_id/data/dummies/dummy_user_repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/login/login.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Login login = Login(
              authenticationRepostitory: DummyAuthenticationRepository(),
              userRepository: DummyUserRepository(),
            );

            login(LoginParams(email: 'email@gmail.com', password: 'password'))
                .then((result) {
              if (result is Success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainPage(
                        user: result.resultValue!,
                      );
                    },
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.errorMessage!)),
                );
              }
            });
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
