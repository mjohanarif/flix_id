import 'dart:math';

import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/seat_booking_page.dart/methods/seat_section.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'methods/legend.dart';
import 'methods/movie_screen.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();

    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackNavigationBar(
                  movieDetail.title,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                movieScreen(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 1),
                      onTap: onSeatTap,
                      seatStatusChecker: seatStatusChecker,
                    ),
                    horizontalSpaces(30),
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 19),
                      onTap: onSeatTap,
                      seatStatusChecker: seatStatusChecker,
                    ),
                  ],
                ),
                verticalSpaces(20),
                legend(),
                verticalSpaces(40),
                Text(
                  '${selectedSeats.length} seats selected',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaces(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Next'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void onSeatTap(seatNumber) {
    if (!selectedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selected
          : SeatStatus.available;
}
