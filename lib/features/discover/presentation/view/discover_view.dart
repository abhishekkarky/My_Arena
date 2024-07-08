import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/config/constants/theme_constants.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/textformfield.dart';
import 'package:my_arena/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';
import 'package:my_arena/features/discover/presentation/view_model/futsal_view_model.dart';

class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends ConsumerState<DiscoverView> {
  final TextEditingController searchController = TextEditingController();
  RangeValues priceRange = const RangeValues(1000, 2000);
  final List<bool> _favorites = [false, false];

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authViewModelProvider);
    final futsalState = ref.watch(futsalViewModelProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    void showFilterOptions(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filter Options',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text('Location', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      maTextFormField(
                        isDarkMode: isDarkMode,
                        controller: searchController,
                        hintText: 'Enter Location',
                      ),
                      const SizedBox(height: 16),
                      const Text('Price Range', style: TextStyle(fontSize: 18)),
                      RangeSlider(
                        values: priceRange,
                        min: 0,
                        max: 5000,
                        divisions: 100,
                        labels: RangeLabels(
                          'Rs. ${priceRange.start.round()}',
                          'Rs. ${priceRange.end.round()}',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            priceRange = values;
                          });
                        },
                        activeColor: isDarkMode ? Colors.white : Colors.black,
                        inactiveColor:
                            isDarkMode ? Colors.grey[700] : Colors.grey[300],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rs. ${priceRange.start.round()}'),
                          Text('Rs. ${priceRange.end.round()}'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      MAElevatedButton(
                        onPressed: () {
                          print("price range: $priceRange");
                          Navigator.pop(context);
                        },
                        text: 'Apply Filters',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Builder(
                            builder: (BuildContext context) {
                              final currentTime = DateTime.now();
                              final currentHour = currentTime.hour;
                              String greeting;
                              if (currentHour < 12) {
                                greeting = 'Good Morning';
                              } else if (currentHour < 18) {
                                greeting = 'Good Afternoon';
                              } else {
                                greeting = 'Good Evening';
                              }
                              return Text(
                                greeting,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                ),
                              );
                            },
                          ),
                          Text(
                            userState.userDetail?.fullName ?? 'Loading...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => showFilterOptions(context),
                      icon: FaIcon(
                        FontAwesomeIcons.filter,
                        size: 22,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Available Futsal Grounds',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode
                            ? Colors.white
                            : ThemeConstant.buttonColor,
                      )),
                ),
              ),
              const SizedBox(height: 10),
              ...futsalState.futsals.map((futsal) => _buildFutsalCard(
                    futsal: futsal,
                    imageUrl: futsal.futsalImageUrl ?? '',
                    name: futsal.name ?? '',
                    location: futsal.location ?? '',
                    rating: futsal.rating ?? 0,
                    size: futsal.groundSize ?? '',
                    price: futsal.price.toString(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFutsalCard({
    required FutsalEntity futsal,
    required String imageUrl,
    required String name,
    required String location,
    required String size,
    required int rating,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.individualFutsalRoute,
            arguments: futsal);
      },
      child: Card(
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
              const SizedBox(width: 10),
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
                      size,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Rs. $price',
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   icon: Icon(
              //     Icons.favorite,
              //     color: _favorites[index] ? Colors.red : Colors.grey,
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       _favorites[index] = !_favorites[index];
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
