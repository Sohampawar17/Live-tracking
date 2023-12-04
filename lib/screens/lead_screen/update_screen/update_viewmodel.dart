import 'package:flutter/material.dart';
import 'package:geolocation/model/add_lead_model.dart';
import 'package:geolocation/model/notes_list.dart';
import 'package:geolocation/services/update_lead_services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../services/add_lead_services.dart';

class UpdateLeadModel extends BaseViewModel{

String? note;
TextEditingController controller=TextEditingController();
List<String> status=["Lead",
"Open",
"Replied",
"Opportunity",
"Quotation",
"Lost Quotation",
"Interested",
"Converted",
"Do Not Contact"];

  AddLeadModel leaddata =AddLeadModel();
bool res=false;
List<NotesList> notes=[];
  initialise(BuildContext context,String leadId) async {
    setBusy(true);
    if(leadId !=""){
 leaddata= await AddLeadServices().getlead(leadId) ?? AddLeadModel();
 notes=await UpdateLeadServices().getnotes(leadId);
 Logger().i(notes.length);
 notifyListeners();
    }
    setBusy(false);
  }

void deletenote(String? lead,int index)async{
  if(lead!.isNotEmpty){
 await UpdateLeadServices().deletenotes(lead, index);
  notifyListeners();
}
}

void addnote(String? lead,String? note)async{
  if(lead!.isNotEmpty && note!.isNotEmpty){
 await UpdateLeadServices().addnotes(lead, note);}
  notifyListeners();
  
controller.clear();
}


void changestatus(String? lead,String? type)async{
  if(lead!.isNotEmpty && type!.isNotEmpty){
  await UpdateLeadServices().changestatus(lead,type);
  leaddata.status=type;}
  notifyListeners();
}
}