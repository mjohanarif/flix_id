import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/profile_page.dart/methods/profile_item.dart';
import 'package:flix_id/presentation/pages/profile_page.dart/methods/user_info.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          verticalSpaces(20),
          ...userInfo(ref),
          verticalSpaces(20),
          const Divider(),
          verticalSpaces(20),
          profileItem(
            'Update Profile',
            onTap: () {},
          ),
          verticalSpaces(20),
          profileItem(
            'My Wallet',
            onTap: () {
              ref.read(routerProvider).pushNamed('wallet');
            },
          ),
          verticalSpaces(20),
          profileItem(
            'Change Password',
            onTap: () {},
          ),
          verticalSpaces(20),
          profileItem(
            'Change Language',
            onTap: () {},
          ),
          verticalSpaces(20),
          const Divider(),
          verticalSpaces(20),
          profileItem(
            'Contact Us',
            onTap: () {},
          ),
          verticalSpaces(20),
          profileItem(
            'Privacy Policy',
            onTap: () {},
          ),
          verticalSpaces(20),
          profileItem(
            'Terms and Conditions',
            onTap: () {},
          ),
          verticalSpaces(60),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ref.read(userDataProvider.notifier).logOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          verticalSpaces(20),
          const Text(
            'Version 0.0.1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          verticalSpaces(100),
        ],
      ),
    );
  }
}
