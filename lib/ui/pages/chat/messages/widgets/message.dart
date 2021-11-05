import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final bool remote;
  final String message;
  final int time;
  final VoidCallback onHold;

  // ChatCard constructor
  const MessageBubble(
      {Key? key,
      required this.message,
      required this.time,
      required this.remote,
      required this.onHold})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    const _radious = Radius.circular(12);
    const _corner = Radius.circular(4);
    final _messageTheme = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 14.0, fontWeight: FontWeight.w500);
    final _timeTheme =
        Theme.of(context).textTheme.headline2!.copyWith(fontSize: 10.0);

    return Row(
      mainAxisAlignment:
          remote ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300, minWidth: 25),
            child: Card(
              elevation: 0,
              color: remote
                  ? Theme.of(context).cardTheme.color
                  : Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: _radious,
                    topRight: _radious,
                    bottomLeft: remote ? _corner : _radious,
                    bottomRight: remote ? _radious : _corner),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: remote
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      style: remote
                          ? _messageTheme
                          : _messageTheme.copyWith(color: Colors.white),
                    ),
                    Text(
                      _getTime(),
                      style: remote
                          ? _timeTheme
                          : _timeTheme.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onLongPress: onHold,
        ),
      ],
    );
  }

  String _getTime() {
    final messageTime = DateTime.fromMillisecondsSinceEpoch(time);
    final window = DateTime.now().subtract(const Duration(days: 1));
    late DateFormat formatter;
    if (messageTime.isAfter(window)) {
      formatter = DateFormat('hh:mm a');
    } else {
      formatter = DateFormat('dd/MM/yyyy');
    }
    return formatter.format(messageTime);
  }
}
