import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/models/message.dart';
import 'package:red_egresados/domain/use_cases/chat_management.dart';
import 'package:red_egresados/ui/pages/chat/messages/widgets/message.dart';
import 'package:red_egresados/ui/pages/chat/messages/widgets/option.dart';

class ChatView extends StatefulWidget {
  final String? chatReference;
  final String localEmail;
  final Future<String?> Function(String message) onSend;
  final Future<void> Function(ChatMessage message) updateChat;
  final ChatManager manager;

  const ChatView({
    Key? key,
    required this.manager,
    required this.localEmail,
    required this.updateChat,
    required this.onSend,
    this.chatReference,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ChatView> {
  late TextEditingController messageController;
  late Stream<Event> chatStream;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    chatStream = widget.manager
        .getChatStream(chatReference: widget.chatReference ?? 'chats/none');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: StreamBuilder<Event>(
              stream: chatStream,
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  final items = widget.manager
                      .extractMessages(snapshot.data!.snapshot)
                      .reversed
                      .toList();
                  return ListView.builder(
                    reverse: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      ChatMessage message = items[index];
                      return MessageBubble(
                        remote: message.sender != widget.localEmail,
                        message: message.message,
                        time: message.timestamp!,
                        onHold: () {
                          Get.dialog(
                            DeleteMessage(
                              actionAllowed:
                                  message.sender == widget.localEmail,
                              onDelete: () async {
                                if (message.reference == items[0].reference) {
                                  ChatMessage newLastMessage = items[1];
                                  await widget.updateChat(newLastMessage);
                                }
                                await widget.manager.deleteMessage(
                                    widget.chatReference!, message);
                                Get.back();
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Something went wrong: ${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        Container(
          color: Theme.of(context).cardTheme.color,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mensaje',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: RawMaterialButton(
                    fillColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    child: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final message = messageController.text;
                      messageController.clear();
                      final result = await widget.onSend.call(message);
                      if (result != null) {
                        setState(() {
                          chatStream = widget.manager
                              .getChatStream(chatReference: result);
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
