import 'package:flutter/material.dart';

class CarouselItemTwo extends StatelessWidget {
  const CarouselItemTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(-6, -6),
                spreadRadius: -5,
                blurRadius: 15),
            BoxShadow(
                color: Colors.grey,
                offset: Offset(6.0, 6.0),
                spreadRadius: 1,
                blurRadius: 15),
          ],
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/coin.png'),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(-6, -6),
                spreadRadius: -5,
                blurRadius: 15),
            BoxShadow(
                color: Colors.grey,
                offset: Offset(6.0, 6.0),
                spreadRadius: 1,
                blurRadius: 15),
          ],
          image: const DecorationImage(
            image: AssetImage('assets/images/gip.jpg'),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
