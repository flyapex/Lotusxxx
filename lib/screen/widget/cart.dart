import 'package:flutter/material.dart';
import 'package:lotuspmc/service/style/color.dart';

const String baseImageUrl = "https://sahedstar.xyz/";

class CartContainer extends StatelessWidget {
  final String label;
  final String image;

  const CartContainer({super.key, required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    const double borderRadiusValue = 6;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (image.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullImageView(title: label, imagerUrl: image),
                ),
              );
            }
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(borderRadiusValue), // Rounded border
            ),
            child: Stack(
              children: [
                image.isEmpty
                    ? const SizedBox(
                        height: 140,
                        child: Center(
                          child: Text(
                            "No Image",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadiusValue),
                        child: SizedBox(
                          height: 140,
                          width: double.infinity,
                          child: Image.network(
                            "$baseImageUrl$image",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: secondary,
          ),
        ),
      ],
    );
  }
}

class FullImageView extends StatelessWidget {
  final String title;
  final String imagerUrl;

  const FullImageView({
    super.key,
    required this.imagerUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Image.network(
          "$baseImageUrl$imagerUrl",
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
