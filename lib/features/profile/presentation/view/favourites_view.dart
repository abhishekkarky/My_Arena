import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
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
        title: 'FAQs',
        context: context,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FAQ(
                question: 'Where is this futsal located?',
                answer: "It's located near Digi Technology Nepal.",
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                ansStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              FAQ(
                question: 'Can I book multiple futsals at a time?',
                answer:
                    "Yes, but you cannot book the same futsal at the same time twice.",
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                ansStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              FAQ(
                question: 'What are the operating hours?',
                answer: "The futsal is open from 6 AM to 11 PM daily.",
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                ansStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              FAQ(
                question: 'Are there any membership benefits?',
                answer:
                    "Yes, members receive discounts on bookings and exclusive access to special events.",
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                ansStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
