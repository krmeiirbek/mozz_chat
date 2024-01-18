import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/device/device_utility.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: TDeviceUtils.getScreenWidth(context),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: SvgPicture.asset(
              MozzImages.search,
              color: const Color(0xff9DB7CB),
              width: 24,
              height: 24,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            hintText: text,
            hintStyle: const TextStyle(color: Color(0xff9DB7CB), fontSize: 16, fontWeight: FontWeight.w500),
            fillColor: const Color(0xffEDF2F6),
            filled: true,
          ),
        ),
      ),
    );
  }
}
