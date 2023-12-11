import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/drop_down.dart';

class AddLeadScreen extends StatefulWidget {
  final String leadid;
  const AddLeadScreen({super.key, required this.leadid});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddLeadViewModel>.reactive(
      viewModelBuilder: () => AddLeadViewModel(),
      onViewModelReady: (model) => model.initialise(context,widget.leadid),
      builder: (context, model, child)=>Scaffold(
       
      appBar:AppBar(title:  Text(model.isEdit ?model.leaddata.name.toString() :'Create Lead',style: TextStyle(fontSize: 18),),backgroundColor: Colors.transparent,
leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),actions: [
  IconButton.outlined(onPressed: ()=>model.onSavePressed(context), icon: const Icon(Icons.check))
],),
    body: fullScreenLoader(
      loader: model.isBusy,context: context,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                Row(children: [
 Expanded(child: CustomSmallTextFormField(prefixIcon: Icons.person,controller: model.firstnamecontroller,labelText:'First Name' ,hintText: 'Enter the first name',onChanged: model.setfirstname,validator: model.validatefirstname,)),
 SizedBox(width: 15,),
   Expanded(child: CustomSmallTextFormField(prefixIcon: Icons.person,controller: model.lastnamecontroller,labelText:'Last Name' ,hintText: 'Enter the last name',onChanged: model.setlastname,validator: model.validatelastname,)),
                
                ],),
             
                           SizedBox(height: 15,),
                            CustomSmallTextFormField(prefixIcon:EvaIcons.email_outline,controller: model.emailcontroller,labelText:'Email Address' ,hintText: 'Enter your email id',onChanged: model.setemail,validator: model.validateemail,),
                
            SizedBox(height: 15,),
                        Row(children: [
 Expanded(child:  CustomSmallTextFormField(prefixIcon: Icons.phone,controller:model.mobilenumbercontroller,labelText:'Mobile Number' ,hintText: 'Enter the your mobile number',onChanged: model.setmobilenumber,validator: model.validatemobile,length: 10,keyboardtype: TextInputType.phone),
              ),
 SizedBox(width: 15,),
   Expanded(child:  CustomSmallTextFormField(prefixIcon:Bootstrap.whatsapp,controller: model.whatsappcontroller,labelText:'WhatsApp Number' ,hintText: 'Enter your whatsapp number',onChanged: model.setwhatsapp,validator: model.validatemobile,length: 10,keyboardtype: TextInputType.phone,),
   )
                ],),
                     
                        
                          SizedBox(height: 15,),
              
                  CustomDropdownButton2(labelText: 'Territory',value: model.leaddata.territory,prefixIcon:Icons.location_on,searchInnerWidgetHeight: 35,items:model.territory, hintText: 'select territory', onChanged: model.setterritory,),
                  
                            SizedBox(height: 15,),
                             CustomSmallTextFormField(prefixIcon: Icons.factory_outlined,controller: model.companynamecontroller,labelText:'Organisation Name' ,hintText: 'Enter the organisation',onChanged: model.setCompanyName,validator: model.validatecompany,),
            
                           SizedBox(height: 15,),
                            CustomDropdownButton2(prefixIcon: Icons.factory_sharp,labelText: 'Industry Type',value:model.leaddata.industry,items:model.industrytype, hintText: 'select industry', onChanged: model.setindustry,searchController: model.textEditingController,),
        
          SizedBox(height: 15,),
            Row(children: [
 Expanded(child: CustomSmallTextFormField(prefixIcon:Icons.location_on,controller: model.citycontroller,labelText:'City' ,hintText: 'Enter the City',onChanged: model.setcity,validator: model.validatecity,),
                
              ),
 SizedBox(width: 15,),
   Expanded(child:   CustomDropdownButton2(labelText: 'State',value:model.leaddata.state..toString,items:model.state, hintText: 'select state', onChanged: model.setstate,searchController: model.statecontroller,),
   )
                ],),
                 SizedBox(height: 15,),
                 
            Visibility(visible: !model.isEdit,child: CustomSmallTextFormField(linelength: 5,prefixIcon:Icons.note_add,controller: model.noteController,labelText:'+ Add Note' ,hintText: 'Enter your Note',onChanged: model.setNote)),
                
                       
                          SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel'),
                            CtextButton(onPressed: ()=> model.onSavePressed(context), text:model.isEdit?'Update Lead' : 'Create Lead')],
                          )
              ],
            ),
          ),
        ),
      ),
    ),  ));
  }
}