import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.shohSnackbar(
          next.error.toString(),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  ref.watch(userDataProvider).when(
                        data: (data) => data.toString(),
                        error: (error, stackTrace) => '',
                        loading: () => 'Loading',
                      ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(userDataProvider.notifier).logOut();
                  },
                  child: const Text(
                    'Logout',
                  ),
                ),
              ],
            ),
          ),
          BottomNavBar(
            items: const [
              BottomNavBarItem(
                  index: 0,
                  title: 'Home',
                  imageSelected: 'assets/movie-selected.png',
                  imageUnselected: 'assets/movie.png',
                  isSelected: false)
            ],
            onTap: (index) {},
            selectedIndex: 0,
          )
        ],
      ),
    );
  }
}
