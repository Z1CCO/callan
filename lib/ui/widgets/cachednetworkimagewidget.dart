import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_fire/ui/widgets/shimmerwidget.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  const CachedNetworkImageWidget({
    Key? key,
    required this.url,
    this.width = double.infinity,
    this.height = 300.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          ShimmerWidget(width: width, height: height),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: 40.0,
        ),
      ),
    );
  }
}
