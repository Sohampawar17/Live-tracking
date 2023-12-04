import 'package:flutter/material.dart';
import 'package:geolocation/services/add_lead_services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_lead_model.dart';
import '../../../router.router.dart';

class AddLeadViewModel extends BaseViewModel{

TextEditingController firstnamecontroller=TextEditingController();
TextEditingController lastnamecontroller=TextEditingController();
TextEditingController mobilenumbercontroller=TextEditingController();
TextEditingController emailcontroller=TextEditingController();
TextEditingController companynamecontroller=TextEditingController();
TextEditingController citycontroller=TextEditingController();
TextEditingController statecontroller=TextEditingController();
TextEditingController whatsappcontroller=TextEditingController();
TextEditingController noteController=TextEditingController();
TextEditingController textEditingController=TextEditingController();
List<Notes> notes=[];
bool isEdit=false;
AddLeadModel leaddata =AddLeadModel();

final formKey = GlobalKey<FormState>();
List<String> industrytype=[""]; 
List<String> territory=[""]; 

  initialise(BuildContext context,String leadId) async {
    setBusy(true);
industrytype=await AddLeadServices().fetchindustrytype();
territory= await AddLeadServices().fetchterritory();
if(leadId != ""){
  isEdit=true;
  leaddata= await AddLeadServices().getlead(leadId) ?? AddLeadModel();
  firstnamecontroller.text=leaddata.firstName ?? "";
  lastnamecontroller.text=leaddata.lastName ?? "";
  mobilenumbercontroller.text=leaddata.mobileNo ?? "";
  emailcontroller.text=leaddata.emailId ?? "";
  whatsappcontroller.text=leaddata.whatsappNo ?? "";
  companynamecontroller.text=leaddata.companyName ?? "";
  citycontroller.text=leaddata.city ?? "";
  statecontroller.text=leaddata.state ?? "";
notes.addAll(leaddata.notes ?? [] );
for(var i in notes){
  noteController.text=RegExp(r'<p>(.*?)<\/p>').firstMatch(i.note ?? "")?.group(1) ?? '';
}
  notifyListeners();
}
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
       leaddata.notes=notes;
      bool res = false;
      Logger().i(leaddata.toJson());
    if(isEdit == true){
  res = await AddLeadServices().updateOrder(leaddata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pushReplacementNamed(context, Routes.leadListScreen);
        
      }}
    }else{
    
      res = await AddLeadServices().addLead(leaddata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pushReplacementNamed(context, Routes.leadListScreen);
        
      }}}
    }
  setBusy(false);
  }

void setfirstname(String firstname){
  firstnamecontroller.text=firstname;
  leaddata.firstName =firstnamecontroller.text;
  notifyListeners();
}

void setlastname(String lastname){
  lastnamecontroller.text=lastname;
  leaddata.lastName =lastnamecontroller.text;
  notifyListeners();
}

void setmobilenumber(String mobileno){
  mobilenumbercontroller.text=mobileno;
  leaddata.mobileNo =mobilenumbercontroller.text;
  notifyListeners();
}

void setCompanyName(String companyName){
  companynamecontroller.text=companyName;
  leaddata.companyName =companynamecontroller.text;
  notifyListeners();
}
void setindustry(String? industry){
  leaddata.industry =industry;
  notifyListeners();
}
void setterritory(String? territory){
  leaddata.territory =territory;
  notifyListeners();
}

void setemail(String emailId){
  emailcontroller.text=emailId;
  leaddata.emailId =emailcontroller.text;
  notifyListeners();
}

void setcity(String city){
  citycontroller.text=city;
  leaddata.city =citycontroller.text;
  notifyListeners();
}
void setwhatsapp(String whatsapp){
  whatsappcontroller.text=whatsapp;
  leaddata.whatsappNo =whatsappcontroller.text;
  notifyListeners();
}

void setNote(String note){
  noteController.text=note;
  notes[0].note = '<div class=\"ql-editor read-mode\"><p>${noteController.text}</p><p><br></p></div>';
  notifyListeners();
}

void setstate(String state){
  statecontroller.text=state;
  leaddata.state =statecontroller.text;
  notifyListeners();
}
  ///validators
  String? validatefirstname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter First name';
    }
    return null;
  }

  String? validatelastname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Last name';
    }
    return null;
  }
    String? validatemobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter mobile number';
    }
    return null;
  }
    String? validateemail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter  email address';
    }
    return null;
  }
    String? validatecompany(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter company';
    }
    return null;
  }
    String? validatestate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter State';
    }
    return null;
  }
   
    String? validatecity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter City';
    }
    return null;
  }
  ///dispose controllers
  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    mobilenumbercontroller.dispose();
    emailcontroller.dispose();
    citycontroller.dispose();
    statecontroller.dispose();
    companynamecontroller.dispose();
    noteController.dispose();
    textEditingController.dispose();
    super.dispose();
  }
}