import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../model/order_list_model.dart';
import '../../../router.router.dart';
import '../../../services/order_services.dart';

class ListOrderModel extends BaseViewModel {
  List<OrderList> orderlist = [];

  initialise(BuildContext context) async {
    setBusy(true);
    orderlist = await OrderServices().fetchsalesorder();
    setBusy(false);
  }

  void onRowClick(BuildContext context, OrderList? farmresList) {
    Navigator.pushNamed(
      context,
      Routes.addOrderScreen,
      arguments: AddOrderScreenArguments(orderid: farmresList?.name ?? ""),
    );
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
}
