import 'package:flutter/material.dart';

import 'package:geolocation/model/order_details_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_invoice_model.dart';
import '../../../router.router.dart';
import '../../../services/add_invoice_services.dart';
import 'package:intl/intl.dart';

class AddInvoiceViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedtransactionDate;
  DateTime? selecteddeliveryDate;
  List<String> searchcutomer = [""];
  List<InvoiceItems> selectedItems = [];
  List<OrderDetailsModel> orderetails = [];
String displayString='';
  // int quantity= 0;
  bool res = false;
  bool isEdit = false;
  bool isloading = false;

  TextEditingController customercontroller = TextEditingController();
  TextEditingController searchcustomercontroller = TextEditingController();
  TextEditingController deliverydatecontroller = TextEditingController();
  late String orderId;

  AddInvoiceModel invoiceData = AddInvoiceModel();

  initialise(BuildContext context, String orderid) async {
    setBusy(true);
    searchcutomer = await AddInvoiceServices().fetchcustomer();
    orderId = orderid;
    //setting aleardy available data
    if (orderId != "") {
      isEdit = true;
      invoiceData = await AddInvoiceServices().getOrder(orderid) ?? AddInvoiceModel();
      customercontroller.text = invoiceData.customer ?? "";
      deliverydatecontroller.text = invoiceData.dueDate ?? "";
      selectedItems.addAll(invoiceData.items?.toList() ?? []);
      updateTextFieldValue();
      Logger().i(invoiceData.toJson());
    }

    notifyListeners();
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {

    isloading = true;
    if (formKey.currentState!.validate()) {
      invoiceData.items = selectedItems;
      bool res = false;
      Logger().i(invoiceData.toJson());
      if(isEdit == true){
        res = await AddInvoiceServices().addOrder(invoiceData);
        if (res) {
          if (context.mounted) {
            isloading = false;
            isloading = false;
            Navigator.pushReplacementNamed(context, Routes.listInvoiceScreen);
          }
        }
      }else{
      res = await AddInvoiceServices().addOrder(invoiceData);
      if (res) {
        if (context.mounted) {
          isloading = false;
          isloading = false;
          Navigator.pushReplacementNamed(context, Routes.listInvoiceScreen);
        }
      }}
    }
    isloading = false;
  }

  ///dates functions///
  void updateTextFieldValue() {
    final selectedItemsValue = selectedItems.isEmpty
        ?'Items are not selected'
        : '${selectedItems.length} items are selected';
    displayString = selectedItemsValue;
    notifyListeners();
  }

  Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      deliverydatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      invoiceData.dueDate = deliverydatecontroller.text;
    }
  }

  ///setvalues//

  void ondeliveryDobChanged(String value) {
    invoiceData.dueDate = value;
  }

  void setcustomer(String? customer) {
    invoiceData.customer = customer;
    notifyListeners();
  }


  void setSelectedItems(List<InvoiceItems> SelectedItems) async {
    selectedItems = SelectedItems;
    for (var item in selectedItems) {
      Logger().i(item.qty);
      item.amount = (item.qty ?? 1.0) * (item.rate ?? 0.0);
    }
    invoiceData.items = selectedItems;
    updateTextFieldValue();
    Logger().i(invoiceData.toJson());
    orderdetails(await AddInvoiceServices().orderdetails(invoiceData));
    notifyListeners();
  }


  void orderdetails(List<OrderDetailsModel> orderdetail) {
    Logger().i('edited');
    invoiceData.totalTaxesAndCharges =
        orderdetail.isNotEmpty ? orderdetail[0].totalTaxesAndCharges : 0.0;
    invoiceData.grandTotal =
        orderdetail.isNotEmpty ? orderdetail[0].grandTotal : 0.0;
    invoiceData.discountAmount =
        orderdetail.isNotEmpty ? orderdetail[0].discountAmount : 0.0;
    invoiceData.total = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
    invoiceData.netTotal = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
  }

  void updateItemQuantity(int index, int quantityChange) async {
    if (selectedItems.isNotEmpty) {
      selectedItems[index].qty =
          (selectedItems[index].qty ?? 0.0) + quantityChange.toDouble();
      selectedItems[index].amount = (selectedItems[index].qty ?? 0.0) *
          (selectedItems[index].rate ?? 0.0);
      orderdetails(await AddInvoiceServices().orderdetails(invoiceData));
    }
    notifyListeners();
  }

  double getQuantity(InvoiceItems item) {
    return item.qty ?? 1;
  }

  void additem(int index) async {
    updateItemQuantity(index, 1);
    notifyListeners();
  }

  void removeitem(int index) async {
    updateItemQuantity(index, -1);
    notifyListeners();
  }

  void deleteitem(int index) async {
   selectedItems.removeAt(index);
   invoiceData.items = selectedItems;
   orderdetails(await AddInvoiceServices().orderdetails(invoiceData));
   updateTextFieldValue();
    notifyListeners();
   Logger().i(selectedItems.length);
  }



  ///validators////
  String? validatewarehouse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Source warehouse';
    }
    return null;
  }

  String? validatedeliveryDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Delivery Date';
    }
    return null;
  }

  String? validateordertype(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Order Type';
    }
    return null;
  }

  @override
  void dispose() {
    customercontroller.dispose();
    deliverydatecontroller.dispose();
    super.dispose();
  }
}
