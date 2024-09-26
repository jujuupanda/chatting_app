import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/parsing_date.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';

class MessagesCardView extends StatelessWidget {
  const MessagesCardView({
    super.key,
    required this.messages,
    required this.senderId,
  });

  final MessageEntity messages;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Column(
        crossAxisAlignment: messages.senderId == senderId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: messages.senderId == senderId
                  ? Colors.blueAccent
                  : Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: messages.senderId == senderId
                    ? const Radius.circular(12)
                    : const Radius.circular(0),
                bottomRight: messages.senderId == senderId
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: crossAlignmentContent(),
              children: [
                Text(
                  messages.content,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Gap(5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: messages.senderId == senderId
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      ParsingString().formatTimeHHmm(messages.timeStamp),
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  crossAlignmentContent() {
    if (messages.senderId == senderId) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }
}
