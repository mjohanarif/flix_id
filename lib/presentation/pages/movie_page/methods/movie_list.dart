import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> movieList({
  required String title,
  required AsyncValue<List<Movie>> movies,
  void Function(Movie movie)? onTap,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 15,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 228,
        child: movies.when(
          data: (data) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data
                  .map(
                    (movie) => Padding(
                      padding: EdgeInsets.only(
                        left: movie == data.first ? 24 : 10,
                        right: movie == data.last ? 24 : 0,
                      ),
                      child: NetworkImageCard(
                        imageUrl: '${baseImageUrl('500')}/${movie.posterPath}',
                        boxFit: BoxFit.contain,
                        onTap: () => onTap?.call(movie),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    ];
