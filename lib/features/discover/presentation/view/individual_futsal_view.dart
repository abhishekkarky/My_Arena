import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:my_arena/config/router/app_routes.dart';
import 'package:my_arena/core/shared_prefs/user_shared_prefs.dart';
import 'package:my_arena/core/widget/appbar.dart';
import 'package:my_arena/core/widget/button.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';

class IndividualFutsalView extends ConsumerStatefulWidget {
  const IndividualFutsalView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualFutsalViewState();
}

class _IndividualFutsalViewState extends ConsumerState<IndividualFutsalView> {
  final _gap = const SizedBox(height: 15);
  final _belowGap = const SizedBox(
    height: 120,
  );
  DateTime? selectedDate;
  List<String> selectedTimes = [];
  List<String> _times = [];

  Future<void> fetchTimeSlots(String futsalId, DateTime date) async {
    String? token;
    var data = await UserSharedPrefs().getUserToken();
    data.fold((l) => token = null, (r) => token = r!);
    final formattedDate = '${date.year}-${date.month}-${date.day}';
    final url = Uri.parse(
        'http://localhost:5500/api/booking/timeSlotForBooking?futsalId=$futsalId&date=$formattedDate');

    print('Fetching time slots from URL: $url');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['timeSlots'] != null && data['timeSlots'] is List) {
          final List<dynamic> timeSlots = data['timeSlots'];
          setState(() {
            _times = timeSlots
                .map((slot) => '${slot['startTime']} - ${slot['endTime']}')
                .toList();
          });
        } else {
          print('Error: timeSlots is null or not a list');
        }
      } catch (e) {
        print('Error parsing time slots: $e');
      }
    } else if (response.statusCode == 403) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          data['message'],
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      print('Failed to load time slots. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> createBooking(Map<String, dynamic> data) async {
    String? token;
    var tokenData = await UserSharedPrefs().getUserToken();
    tokenData.fold((l) => token = null, (r) => token = r!);
    final url = Uri.parse('http://localhost:5500/api/user/bookings/add');

    print('Creating booking with URL: $url and data: $data');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            responseData['message'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ));
      } catch (e) {
        print('Error while booking: $e');
      }
    } else if (response.statusCode == 403) {
      final responseData = jsonDecode(response.body);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          responseData['message'],
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      print('Failed to create booking. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final futsal = ModalRoute.of(context)!.settings.arguments as FutsalEntity;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: MyAppBar(
        title: futsal.name ?? 'Futsal Details',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/images/ground.png',
                  height: 200,
                  width: MediaQuery.sizeOf(context).width * 1,
                  fit: BoxFit.cover,
                ),
              ),
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    futsal.location ?? 'Ratopul, Kathmandu',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        color: index < futsal.rating!.toInt()
                            ? Colors.orange
                            : Colors.grey,
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ground Size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    futsal.groundSize ?? '10 x 10',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price per hr',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Rs. ${futsal.price}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Opening days',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    futsal.dayOfWeek!.join(", "),
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              _gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'See Location in Map',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.mapViewRoute,
                            arguments: futsal);
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: Colors.blue,
                        ),
                      ))
                ],
              ),
              _gap,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _gap,
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? '${selectedDate!.toLocal()}'.split(' ')[0]
                          : '',
                    ),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: "Select Date",
                      filled: true,
                      fillColor: Colors.grey[300],
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey[800]!,
                      ),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                        await fetchTimeSlots(
                            futsal.futsalId.toString(), picked);
                      }
                    },
                  ),
                  _gap,
                  const Text(
                    'Select Time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _gap,
                  MultiSelectDialogField(
                    items: _times
                        .map((time) => MultiSelectItem<String>(time, time))
                        .toList(),
                    title: const Text("Times"),
                    backgroundColor: isDarkMode ? Colors.black : Colors.white,
                    selectedColor: isDarkMode ? Colors.white : Colors.black,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.access_time,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    buttonText: Text(
                      "Select Time",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        selectedTimes = results.cast<String>();
                      });
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      chipColor: isDarkMode ? Colors.black : Colors.white,
                      onTap: (value) {
                        setState(() {
                          selectedTimes.remove(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              _belowGap,
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          border: Border(
            top: BorderSide(
              width: 1,
              color: isDarkMode ? Colors.white12 : Colors.black12,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MAElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          KhaltiScope.of(context).pay(
                            config: PaymentConfig(
                              amount: futsal.price!.toInt() * 100,
                              productIdentity: "Futsal Ground",
                              productName: futsal.name.toString(),
                            ),
                            onSuccess: (successModel) async {
                              final bookingData = {
                                'futsal': futsal.futsalId,
                                'date': selectedDate
                                    ?.toIso8601String()
                                    .split('T')[0],
                                'timeSlot': selectedTimes,
                                'paid': "true"
                              };
                              await createBooking(bookingData);
                            },
                            onFailure: (failureModel) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    failureModel.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            onCancel: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Payment Cancelled',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    ],
                    title: const Text("Confirm"),
                    content: const Text(
                      "Are you sure you want to book ",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              );
            },
            text: 'Book Now',
          ),
        ),
      ),
    );
  }
}
