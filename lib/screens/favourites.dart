import 'package:flutter/material.dart';
import 'package:music_playaer/constants/colors.dart';
import 'package:music_playaer/constants/text_styles.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkClr,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              size: 30.0,
            ),
            color: white,
          )
        ],
        title: Text(
          'Favourites',
          style: textStyle(size: 28.0, weight: FontWeight.w800),
        ),
      ),
    );
  }
}
