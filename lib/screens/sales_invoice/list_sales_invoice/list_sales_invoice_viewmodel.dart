import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../model/invoice_list_model.dart';
import '../../../router.router.dart';
import '../../../services/list_invoice_services.dart';

class ListInvoiceModel extends BaseViewModel {
  List<InvoiceList> invoiceList = [];
  List<InvoiceList> filterInvoiceList = [];
  List<String> searchcutomer = [""];


  initialise(BuildContext context) async {
    setBusy(true);
    invoiceList = await InvoiceListServices().fetchSaleInvoice();
    searchcutomer = await InvoiceListServices().fetchcustomer();
    filterInvoiceList=invoiceList;
    setBusy(false);
  }

  void onRowClick(BuildContext context, InvoiceList? farmresList) {
    Navigator.pushNamed(
      context,
      Routes.addInvoiceScreen,
      arguments: AddInvoiceScreenArguments(invoiceid: farmresList?.name ?? ""),
    );
  }

  DateTime? selecteddeliveryDate;

 Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      date = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

Future<void> refresh() async {
  invoiceList= await InvoiceListServices().fetchSaleInvoice();
  notifyListeners();
}

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Draft':
        return Colors.grey[400] ??
            Colors.grey; // Set the color for Draft status
      case 'On Hold':
        return Colors.amber; // Set the color for On Hold status
      case 'To Deliver and Bill':
        return Colors.redAccent; // Set the color for To Deliver and Bill status
      case 'To Bill':
        return Colors.indigo; // Set the color for To Bill status
      case 'To Deliver':
        return Colors.teal; // Set the color for To Deliver status
      case 'Completed':
        return Colors.green; // Set the color for Completed status
      case 'Cancelled':
        return Colors.red; // Set the color for Cancelled status
      case 'Closed':
        return Colors.grey[800] ??
            Colors.grey; // Set the color for Closed status
      default:
        return Colors.grey; // Set a default color for unknown status
    }
  }

 String? custm;
String? date;

  void setcustomer(String? customer) {
  custm = customer ?? "";
    notifyListeners();
  }

  void setfilter(String customer,String date) async {
    filterInvoiceList= await InvoiceListServices().filterFetchSalesInvoice(customer, date);
   notifyListeners();
  }

  void clearfilter() async {
 date="";
   custm="";
 filterInvoiceList= await InvoiceListServices().fetchSaleInvoice();
    notifyListeners();
  }

}
