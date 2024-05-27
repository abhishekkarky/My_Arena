import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/core/widget/textformfield.dart';

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
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey[300],
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
      appBar: AppBar(
        title: const Text(
          'MY ARENA',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => showFilterOptions(context),
            icon: const FaIcon(
              FontAwesomeIcons.filter,
              size: 22,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 20.0, right: 20.0, bottom: 10),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    // Implement search logic here
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Futsal',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(12),
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildFutsalCard(
              index: 0,
              imageUrl: 'assets/images/ground.png',
              name: 'Velocity Futsal',
              location: 'Ratopul, Kathmandu',
              size: '12 x 14 ground size',
              price: 'Rs. 1500 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
            ),
            _buildFutsalCard(
              index: 1,
              imageUrl: 'assets/images/ground.png',
              name: 'Arena 2',
              location: 'Location 2, City',
              size: '15 x 20 ground size',
              price: 'Rs. 2000 per hr',
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
    required String size,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        print("Changed index to $index");
      },
      child: Card(
        elevation: 2,
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
                        return const Icon(
                          Icons.star,
                          color: Colors.orange,
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
                      price,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _favorites[index] ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _favorites[index] = !_favorites[index];
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}