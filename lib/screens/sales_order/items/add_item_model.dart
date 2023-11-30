import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/add_order_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../services/add_order_services.dart';

class ItemListModel extends BaseViewModel {
  List<Items> selecteditems = [];
  List<Items> isSelecteditems = [];
  double quantity = 0.0;

  List<Items> get selectedItems => selecteditems;

  bool isSelected(Items item) {
    return isSelecteditems.contains(item);
  }

  void initialise(
      BuildContext context, String warehouse, List<Items> itemlist) async {
    setBusy(true);
    Logger().i(itemlist.length);
    // isSelecteditems = itemlist;
  // isSelecteditems.clear(); // Clear the list before adding items
    selecteditems = await AddOrderServices().fetchitems(warehouse);
   
   
    notifyListeners();
    setBusy(false);
  }

  void toggleSelection(Items item) {
    if (isSelected(item)) {
      isSelecteditems.remove(item);
    } else {
      isSelecteditems.add(item);
    }

    print(isSelecteditems);
    notifyListeners();
  }

  void additem(int index) {
    quantity++;
    selecteditems[index].qty =
        quantity.toDouble(); // or just quantity.toDouble()
    notifyListeners();
  }

  double getQuantity(Items item) {
    return item.qty ?? 0.0;
  }

  void removeitem(int index) {
    if (quantity > 0) {
      quantity--;
      selecteditems[index].qty =
          quantity.toDouble(); // or just quantity.toDouble()
      notifyListeners();
    }
  }
}
