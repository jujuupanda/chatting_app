import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInformationCardView extends StatelessWidget {
  const ProfileInformationCardView(
      {super.key,
      required this.onTap,
      required this.title,
      required this.information,
      required this.iconData});

  final VoidCallback onTap;
  final String title;
  final String information;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey.shade200,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  iconData,
                  size: 30,
                  color: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(fontSize: 12),
                    ),
                    Text(
                      information,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
