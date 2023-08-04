import 'package:flutter/material.dart';

class CardWidgets extends StatelessWidget {

  final String cardImage;

  const CardWidgets({
    super.key,
    required this.cardImage,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.only(right: 4.0),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), 
                  image: DecorationImage(
                    image: AssetImage(cardImage),
                    fit: BoxFit.cover, //change image fill type
                  ),
                ),
            );
  }
}