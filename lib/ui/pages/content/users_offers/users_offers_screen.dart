import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/models/user_job.dart';
import 'package:red_egresados/domain/use_cases/controllers/authentication.dart';
import 'package:red_egresados/domain/use_cases/controllers/connectivity.dart';
import 'package:red_egresados/domain/use_cases/jobs_management.dart';
import 'package:red_egresados/ui/pages/content/users_offers/widgets/new_offer.dart';
import 'package:red_egresados/ui/pages/content/users_offers/widgets/offer_card.dart';

class UsersOffersScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const UsersOffersScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<UsersOffersScreen> {
  late final JobsManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> offersStream;
  late ConnectivityController controller;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    manager = JobsManager();
    offersStream = manager.getJobsStream();
    controller = Get.find<ConnectivityController>();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: ElevatedButton(
              child: const Text("Agregar"),
              onPressed: () {
                // We don't allow to trigger the action if we don't have connectivity
                if (controller.connected) {
                  Get.dialog(
                    PublishOffer(
                      manager: manager,
                    ),
                  );
                } else {
                  Get.snackbar(
                    "Error de conectividad",
                    "No se encuentra conectado a internet.",
                  );
                }
              },
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: offersStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                final items = manager.extractOffers(snapshot.data!);
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    UserJob offer = items[index];
                    return UserOfferCard(
                      title: offer.name,
                      content: offer.message,
                      picUrl: offer.picUrl,
                      onChat: () {},
                      onTap: () {
                        // If the offer email is the same as the current user,
                        // we know that the user is the owner of that offer.
                        if (offer.email == authController.currentUser?.email) {
                          Get.dialog(
                            PublishOffer(
                              manager: manager,
                              userJob: offer,
                            ),
                          );
                        } else {
                          Get.snackbar(
                            "No Autorizado",
                            "No puedes editar esta oferta debido a que fue enviada por otro usuario.",
                          );
                        }
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
      ],
    );
  }
}
