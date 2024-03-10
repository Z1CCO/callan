import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  CarouselItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/gip.jpg'),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
