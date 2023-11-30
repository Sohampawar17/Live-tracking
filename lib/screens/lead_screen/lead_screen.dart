import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/lead_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeadListViewModel>.reactive(
      viewModelBuilder: () => LeadListViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child)=> Scaffold(
appBar: AppBar(title: Text('Lead'),),
      ));
  }
}