import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleWithMore extends StatelessWidget {
  const SubtitleWithMore({Key? key, required this.text, required this.press})
      : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: GoogleFonts.heebo(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          // SizedBox(
          //   height: 25,
          //   child: Stack(
          //     children: <Widget>[
          //       // Positioned(
          //       //   bottom: 0,
          //       //   left: 0,
          //       //   right: 0,
          //       //   child: Container(
          //       //     margin: const EdgeInsets.only(right: 5),
          //       //     height: 8,
          //       //     color: orange.withOpacity(0.5),
          //       //   ),
          //       // ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 5),
          //         child: Text(
          //           text,
          //           style: GoogleFonts.heebo(
          //               fontSize: 20, fontWeight: FontWeight.w800),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const Spacer(),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              alignment: Alignment.center,
              // height: 25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lainnya',
                    style: GoogleFonts.lora(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: Colors.black45,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right_alt_rounded,
                    size: 20,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
