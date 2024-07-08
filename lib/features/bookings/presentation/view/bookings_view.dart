import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_arena/core/widget/appbar.dart';
import 'package:my_arena/core/widget/textformfield.dart';
import 'package:my_arena/features/bookings/presentation/view_model/booking_view_model.dart';

class BookingsView extends ConsumerStatefulWidget {
  const BookingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingsViewState();
}

class _BookingsViewState extends ConsumerState<BookingsView> {
  final ScrollController _scrollController = ScrollController();
  final _gap = const SizedBox(
    height: 5,
  );

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingViewModelProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final searchController = TextEditingController();
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(bookingViewModelProvider.notifier).getBookings();
          }
        }
        return true;
      },
      child: Scaffold(
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
                  _gap,
                  ...bookingState.bookingsData
                      .map((booking) => _buildFutsalCard(
                            imageUrl: booking.futsal?['futsalImageUrl'] ?? '',
                            name: booking.futsal?['name'] ?? '',
                            rating: booking.futsal?['rating'] ?? 0,
                            location: booking.futsal?['location'] ?? '',
                            bookedDate: booking.date.toString(),
                            bookedTime: booking.timeSlot.toString(),
                          )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFutsalCard({
    required String imageUrl,
    required String name,
    required String location,
    required String bookedDate,
    required String bookedTime,
    required int rating,
  }) {
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(bookedDate));
    String formatTimeSlot(String timeSlot) {
      return timeSlot.replaceAll('[', '').replaceAll(']', '');
    }

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
                'assets/images/ground.png',
                // imageUrl,
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
                      return Icon(
                        Icons.star,
                        color: index < rating ? Colors.orange : Colors.grey,
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formattedDate.toString(),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatTimeSlot(bookedTime),
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
