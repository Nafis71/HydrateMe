import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewAllScreenNoDataLayout extends StatelessWidget {
  const ViewAllScreenNoDataLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: SvgPicture.asset(
              "assets/images/noHistory.svg",
              fit: BoxFit.contain,
            ),
          ),
          const Wrap(
            children: [
              Text(
                "You don't have any record of consuming water.",
                style: TextStyle(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
