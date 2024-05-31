import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/core/widget/appbar.dart';
import 'package:my_arena/core/widget/textformfield.dart';

class BookingsView extends ConsumerStatefulWidget {
  const BookingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingsViewState();
}

class _BookingsViewState extends ConsumerState<BookingsView> {
  final _gap = const SizedBox(
    height: 5,
  );
  final List<bool> _favorites = [false, false];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final searchController = TextEditingController();
    return Scaffold(
      appBar: MyAppBar(
        title: 'Bookings',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: maTextFormField(
                isDarkMode: isDarkMode,
                controller: searchController,
                hintText: 'Search Bookings',
                suffixIcon: FontAwesomeIcons.magnifyingGlass,
              ),
            ),
            _gap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '2nd April, 2022',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                _gap,
                _buildFutsalCard(
                  index: 0,
                  imageUrl: 'assets/images/ground.png',
                  name: 'Velocity Futsal',
                  location: 'Ratopul, Kathmandu',
                  bookedDate: '2nd April, 2022',
                  bookedTime: '05:00 PM - 06:00 PM',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFutsalCard({
    required int index,
    required String imageUrl,
    required String name,
    required String location,
    required String bookedDate,
    required String bookedTime,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    location,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: List.generate(5, (index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bookedDate,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bookedTime,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
