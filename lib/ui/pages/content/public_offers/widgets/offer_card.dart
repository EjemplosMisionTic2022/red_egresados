import 'package:flutter/material.dart';
import 'package:red_egresados/ui/widgets/card.dart';

class OfferCard extends StatelessWidget {
  final String title, content, arch, level;
  final int payment;
  final VoidCallback onCopy, onApply;

  // OfferCard constructor
  const OfferCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.arch,
      required this.level,
      required this.payment,
      required this.onCopy,
      required this.onApply})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: title,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topRightWidget widget as an IconButton
      topRightWidget: IconButton(
        icon: const Icon(
          Icons.copy_outlined,
          color: Colors.blue,
        ),
        onPressed: onCopy,
      ),
      // extraContent widget as a column that contains more details about the offer
      // and an extra action (onApply)
      extraContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.architecture,
                  color: Colors.blue,
                ),
              ),
              Text(
                arch,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.developer_mode_outlined,
                  color: Colors.blue,
                ),
              ),
              Text(
                level,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.payments_outlined,
                  color: Colors.blue,
                ),
              ),
              Text(
                '\$$payment',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
