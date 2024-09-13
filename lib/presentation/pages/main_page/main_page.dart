import 'dart:io';

import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/pages/movie_page/movie_page.dart';
import 'package:flix_id/presentation/pages/profile_page.dart/profile_page.dart';
import 'package:flix_id/presentation/pages/ticket_page/ticket_page.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;

  const MainPage({this.imageFile, super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final PageController pageController = PageController();
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    User? user = ref.read(userDataProvider).valueOrNull;

    if (widget.imageFile != null && user != null) {
      ref.read(userDataProvider.notifier).uploadProfilePicture(
            param: UploadProfilePictureParam(
              imageFile: widget.imageFile!,
              user: user,
            ),
          );
    }
  }

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
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            children: const [
              MoviePage(),
              TicketPage(),
              ProfilePage(),
            ],
          ),
          BottomNavBar(
            items: [
              BottomNavBarItem(
                index: 0,
                title: 'Home',
                imageSelected: 'assets/movie-selected.png',
                imageUnselected: 'assets/movie.png',
                isSelected: selectedIndex == 0,
              ),
              BottomNavBarItem(
                index: 1,
                title: 'Ticket',
                imageSelected: 'assets/ticket-selected.png',
                imageUnselected: 'assets/ticket.png',
                isSelected: selectedIndex == 1,
              ),
              BottomNavBarItem(
                index: 2,
                title: 'Profile',
                imageSelected: 'assets/profile-selected.png',
                imageUnselected: 'assets/profile.png',
                isSelected: selectedIndex == 2,
              ),
            ],
            onTap: (index) {
              pageController.jumpToPage(index);
            },
            selectedIndex: selectedIndex,
          )
        ],
      ),
    );
  }
}
