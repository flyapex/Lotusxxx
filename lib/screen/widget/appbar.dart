import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lotuspmc/service/style/color.dart';

import '../../controller/db_controller.dart';

class MyappBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  const MyappBar(
      {super.key, required this.title, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        children: [
          const SizedBox(width: 10),
          Image.asset(
            'assets/images/logo_white.png',
            height: 50,
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              '${Get.find<DBController>().getUserName()!.toUpperCase()} $title',
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                height: 1.3,
                color: secondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
