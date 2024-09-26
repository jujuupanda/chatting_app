import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/parsing_date.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../../core/shared/model/user_model.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/message_bloc.dart';
import '../widgets/messages_card_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userChatTo});

  final UserModel userChatTo;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController messageController;
  late String senderId;

  @override
  void initState() {
    getToken();
    getMessages();
    messageController = TextEditingController();
    super.initState();
  }

  getToken() {
    senderId = SharedPrefs().getToken()!;
  }

  getMessages() {
    BlocProvider.of<MessageBloc>(context).add(
      ReceiveMessage(senderId, widget.userChatTo.id),
    );
  }

  buttonSendMessage() {
    BlocProvider.of<MessageBloc>(context).add(
      SendMessage(
        "",
        senderId,
        widget.userChatTo.id,
        messageController.text,
        DateTime.now().toString(),
      ),
    );
  }

  onTap() {
    if (messageController.text.isEmpty) {
      return () {};
    } else {
      return buttonSendMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
          messageController.clear();
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 56),
          child: AppBar(
            title: Text(ParsingString().formatFullName(
                "${widget.userChatTo.firstName} ${widget.userChatTo.middleName} ${widget.userChatTo.lastName}"),
            ),
            titleTextStyle: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            actions: [
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Panggil Video"),
                    ),
                  );
                },
                splashColor: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.videocam,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Panggil Suara"),
                    ),
                  );
                },
                splashColor: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Selengkapnya"),
                    ),
                  );
                },
                splashColor: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<MessageBloc, MessageState>(
                buildWhen: (previous, current) {
                  if (current is ReceiveMessageSuccess &&
                      previous is ReceiveMessageSuccess) {
                    return current.messages.length != previous.messages.length;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is ReceiveMessageSuccess) {
                    final messages = state.messages;
                    return ListView.builder(
                      itemCount: state.messages.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        Widget gap = const Gap(0);
                        if (index > 0 &&
                            messages[index].senderId !=
                                messages[index - 1].senderId) {
                          gap = const Gap(20);
                        }
                        return Column(
                          crossAxisAlignment: messageAlignment(messages[index]),
                          children: [
                            MessagesCardView(
                              messages: messages[index],
                              senderId: senderId,
                            ),
                            gap,
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,
                      ),
                      maxLines: 6,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(50),
                        splashColor: Colors.white.withOpacity(0.2),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  messageAlignment(MessageEntity message) {
    if (senderId == message.senderId) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }
}
