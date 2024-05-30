import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/widget/appbar.dart';

class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends ConsumerState<FavouritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Favourites',
        context: context,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
