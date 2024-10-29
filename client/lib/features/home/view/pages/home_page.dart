import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/providers/current_user_notifier.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/features/home/view/pages/library_page.dart';
import 'package:music/features/home/view/pages/search_page.dart';
import 'package:music/features/home/view/pages/song_page.dart';
import 'package:music/features/home/view/widgets/music_slap.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
int selectedIndex = 0;
final pages = [
  const SongPage(),
  const SearchPage(),
  const LibraryPage(),
];
@override
  Widget build(BuildContext context) {
    ref.watch(currentUserNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          const Positioned(
            bottom: 0,
            child: MusicSlap(),
          )
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.transparentColor,
        elevation: 0,
        enableFeedback: false,
        currentIndex: selectedIndex,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 0
              ? 'assets/images/home_filled.png'
              : 'assets/images/home_unfilled.png',
              color: selectedIndex == 0
              ? Pallete.whiteColor
              : Pallete.inactiveBottomBarItemColor
            ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 1 
              ? 'assets/images/search_filled.png'
              : 'assets/images/search_unfilled.png',
              color: selectedIndex == 1
              ? Pallete.whiteColor
              : Pallete.inactiveBottomBarItemColor
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/library.png',
              color: selectedIndex == 2
              ? Pallete.whiteColor
              : Pallete.inactiveBottomBarItemColor
            ),
            label: 'Library',
          ),
        ]
      ),
    );
  }
}