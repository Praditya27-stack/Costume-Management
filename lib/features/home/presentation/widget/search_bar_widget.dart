import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: const Color.fromRGBO(225, 225, 225, 1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Input Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Your Customer Here',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(165, 165, 165, 1),
                  fontFamily: 'Golos Text',
                  fontSize: 15,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          // Search Icon
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              'assets/icon/Search.svg',
              width: 20,
              height: 20,
              semanticsLabel: 'Search Icon',
            ),
          ),
        ],
      ),
    );
  }
}
