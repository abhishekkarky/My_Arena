import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:my_arena/features/home/presentation/view_model/home_view_model.dart';

class PrimaryView extends ConsumerStatefulWidget {
  const PrimaryView({super.key});

  @override
  ConsumerState<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends ConsumerState<PrimaryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final homeState = ref.watch(homeViewModelProvider);
        return Scaffold(
          body: homeState.lstWidget[homeState.index],
          bottomNavigationBar: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.indicator,
            elevation: 10,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[900]!,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            currentIndex: homeState.index,
            onTap: (index) {
              ref.read(homeViewModelProvider.notifier).changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 25,
                ),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                  size: 25,
                ),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  size: 25,
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
