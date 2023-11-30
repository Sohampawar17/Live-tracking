import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/drawer.dart';
import '../../widgets/text_button.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Homeviewmodel>.reactive(
        viewModelBuilder: () => Homeviewmodel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const AutoSizeText('Home'),
              ),
              drawer: myDrawer(context, (model.full_name ?? ""),
                  (model.user ?? ""), (model.role_profile ?? "")),
              body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CtextButton(
                        onPressed: () {
                          model.locationInbutton(context);
                        },
                        text: 'checkin',
                      ),
                      SizedBox(height: 20),
                      CtextButton(
                        onPressed: () {
                          model.locationOutbutton(context);
                        },
                        text: 'checkout',
                      ),
                    ],
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
            ));
  }
}
