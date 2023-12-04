
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_viewmodel.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../services/update_lead_services.dart';

class UpdateLeadScreen extends StatefulWidget {
  final String updateId;
  const UpdateLeadScreen({super.key, required this.updateId});

  @override
  State<UpdateLeadScreen> createState() => _UpdateLeadScreenState();
}

class _UpdateLeadScreenState extends State<UpdateLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLeadModel>.reactive(
      viewModelBuilder: () => UpdateLeadModel(),
      onViewModelReady: (model) => model.initialise(context,widget.updateId),
      builder: (context, model, child)=> Scaffold(
appBar: AppBar(title:  Text(model.leaddata.name ?? ""),
actions: [IconButton(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: widget.updateId)), icon:Icon(Icons.edit) ),],
leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),),
body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(
                        children: [
                          Expanded(child: AutoSizeText(model.leaddata.name ?? "")),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                                    child: CdropDown(dropdownButton: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Status',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: model.status.map((String item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                            fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: model.leaddata.status,
                                      onChanged: (String? value) {
                                       model.changestatus(widget.updateId, value);
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),)
                                  ),
                          ),
                        ],
                       ),
                       buildItemColumn(labelText:'Lead Owner',additionalText: '${model.leaddata.leadOwner}'),
                        SizedBox(height: 10,),
                         Divider(thickness: 1),
                    
                         buildItemColumn(labelText:'Name',additionalText: '${model.leaddata.leadName}'),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: buildItemColumn(labelText:'Email',additionalText: '${model.leaddata.emailId}'),),
                          Expanded(
                            child:buildItemColumn(labelText:'Mobile',additionalText: '${model.leaddata.mobileNo}'),
                          ),
                        ],
                       ),
                         
                         SizedBox(height: 10,),
                         buildItemColumn(labelText:'Territory',additionalText: '${model.leaddata.territory}'),
                          Divider(thickness: 1),
                    buildItemColumn(labelText:'Organisation Name',additionalText: '${model.leaddata.companyName}'),
                    SizedBox(height: 10,),
                    buildItemColumn(labelText:'Industry type',additionalText: '${model.leaddata.industry}'),
                     Divider(thickness: 1),
                     Text('------------------------  Notes  ------------------------',style: TextStyle(fontWeight: FontWeight.bold)),
                     CustomSmallTextFormField(controller: model.controller, hintText: 'Add your notes here', labelText: 'Add Notes',suffixicon: IconButton(
          onPressed: () {model.addnote(widget.updateId,model.controller.text);
            }, // Implement edit functionality
          icon: const Icon(Icons.send_rounded),
        ), ),
                     ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                               itemCount: model.notes.length,
                               itemBuilder: (context, index) {
                                 final noteData = model.notes[index];
                                 return ListTile(
  leading: CircleAvatar(
    backgroundColor: Colors.blue,
    child: const Icon(Icons.person_2_outlined),
  ),
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(noteData.commented ?? ''),
       Text(noteData.creation ?? ''),
    ],
  ),
  subtitle: Text(noteData.note!.join('\n')),
  trailing: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child:  Text(noteData.creation ?? "")),
      Expanded(
        child: IconButton(
          onPressed: () {model.deletenote(model.leaddata.name,index);
           }, // Implement edit functionality
          icon: const Icon(Icons.delete),
        ), 
      ),
    ],
  ),

  dense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
);

                               },
                             ),
      
                      ],
                    ),
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
                // floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: '')),child: Icon(Icons.add),),
      ));
  }

   Widget buildItemColumn( {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(labelText,style: TextStyle(fontWeight: FontWeight.w400),),
        AutoSizeText(additionalText,style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    );
}
}