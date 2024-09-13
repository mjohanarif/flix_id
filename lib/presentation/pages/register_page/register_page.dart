import 'dart:io';

import 'package:flix_id/domain/usecase/register/register_param.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController retypePassController = TextEditingController();

  XFile? xfile;

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref
            .read(routerProvider)
            .goNamed('main', extra: xfile != null ? File(xfile!.path) : null);
      } else if (next is AsyncError) {
        context.shohSnackbar(
          next.error.toString(),
        );
      }
    });
    return Scaffold(
      body: ListView(
        children: [
          verticalSpaces(50),
          Center(
            child: Image.asset(
              'assets/flix_logo.png',
              width: 150,
            ),
          ),
          verticalSpaces(50),
          GestureDetector(
            onTap: () async {
              xfile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              setState(() {});
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  xfile != null ? FileImage(File(xfile!.path)) : null,
              child: xfile != null
                  ? null
                  : const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.white,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Name',
                  controller: nameController,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passController,
                  obscureText: true,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Retype Password',
                  controller: retypePassController,
                  obscureText: true,
                ),
                verticalSpaces(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (retypePassController.text ==
                                  passController.text) {
                                ref.read(userDataProvider.notifier).register(
                                      param: RegisterParam(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                      ),
                                    );
                              } else {
                                context.shohSnackbar(
                                    'Please retype your password with the same value');
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('login');
                      },
                      child: const Text(
                        'Login here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
