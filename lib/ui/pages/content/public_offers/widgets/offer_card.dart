import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:red_egresados/ui/widgets/card.dart';

class OfferCard extends StatelessWidget {
  final String title, content, arch, level, payment;
  final VoidCallback onApply;

  // OfferCard constructor
  const OfferCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.arch,
      required this.level,
      required this.payment,
      required this.onApply})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      key: const Key("offerCard"),
      title: title,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topRightWidget widget as an IconButton
      topRightWidget: IconButton(
        icon: Icon(
          Icons.copy_outlined,
          color: primaryColor,
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: content));
          Get.showSnackbar(
            GetBar(
              message: "Se ha copiado la oferta al portapapeles.",
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
      // extraContent widget as a column that contains more details about the offer
      // and an extra action (onApply)
      extraContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.architecture,
                  color: primaryColor,
                ),
              ),
              Text(
                arch,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.developer_mode_outlined,
                  color: primaryColor,
                ),
              ),
              Text(
                level,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.payments_outlined,
                  color: primaryColor,
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
