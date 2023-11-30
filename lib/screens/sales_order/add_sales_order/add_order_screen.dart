import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/textfielddecoration.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../model/add_order_model.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';
import 'add_order_viewmodel.dart';

class AddOrderScreen extends StatefulWidget {
  final String orderid;

  const AddOrderScreen({super.key, required this.orderid});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddOrderViewModel>.reactive(
      viewModelBuilder: () => AddOrderViewModel(),
      onViewModelReady: (model) => model.initialise(context, widget.orderid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: model.isEdit == true
              ? Text(model.orderdata.name ?? "")
              : const Text('Create Order'),
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.listOrderScreen);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
              child: Form(
            key: model.formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        SizedBox(
          height: 60,
          child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSearchBox: true,
          showSelectedItems: true,
              ),
              items:model.searchcutomer,
              dropdownDecoratorProps:  DropDownDecoratorProps(
          dropdownSearchDecoration: AppInputDecorations.textFieldDecoration(labelText: 'Customers', hintText: 'select the customers', prefixIcon: Icons.person_2_outlined),
              ),
              onChanged: model.setcustomer,
              selectedItem: model.orderdata.customer,
          ),
        ),
                
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CdropDown(
                          dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model.orderdata.orderType,
                              // Replace null with the selected value if needed
                              decoration: const InputDecoration(
                                 constraints: BoxConstraints(maxHeight: 60),
                                labelText: 'Order Type',
                              ),
                              hint: const Text('Select Order type'),
                              items: model.ordetype.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                              onChanged: (value) => model.setordertype(value),
                              validator: model.validateordertype),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          readOnly: true,
                          controller: model.deliverydatecontroller,
                          onTap: () => model.selectdeliveryDate(context),
                          decoration: AppInputDecorations.textFieldDecoration(
                              labelText: 'Delivery Date',
                              hintText: 'YYYY-MM-dd',
                              prefixIcon: Icons.calendar_today),
                          validator: model.validatedeliveryDob,
                          onChanged: model.ondeliveryDobChanged,
                        ),
                      ),
                    ],
                  ),
                  CdropDown(
                    dropdownButton: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: model.orderdata.setWarehouse,
                 decoration: const InputDecoration(
                   constraints: BoxConstraints(maxHeight: 60),
                                labelText: 'Set Warehouse',
                              ),
                              hint: const Text('Select Warehouse'),
                      items: model.warehouse.map((val) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.topStart,
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (value) => model.setwarehouse(value),
                      validator: model.validatewarehouse,
                      menuMaxHeight: 500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    readOnly: true,
                    
                    onTap: () async {
                        final SelectedItems = await Navigator.pushNamed(
                          context,
                          Routes.itemScreen,
                          arguments: ItemScreenArguments(
                              warehouse: model.orderdata.setWarehouse ?? "",
                              items: model.selectedItems),
                        ) as List<Items>?;
                        if (SelectedItems != null) {
                          Logger().i(SelectedItems.length);

                          // Update the model or perform any actions with the selected items
                          model.setSelectedItems(SelectedItems);
                        }
                    },
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60),
                      hintText: 'click here to select items',
                      labelText: 'Items',
                      prefixIcon:const Icon(Icons.shopping_cart_outlined) ,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (model.selectedItems.isNotEmpty)
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      // Prevent scrolling
                      shrinkWrap: true,
                      itemCount: model.selectedItems.length,
                      itemBuilder: (context, index) {
                        final selectedItem = model.selectedItems[index];
                        return Row(
                          children: [
                            Expanded(flex: 1,child: buildImage(selectedItem.image),),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      AutoSizeText(
                                        'ID:  ${selectedItem.itemCode}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          '(${selectedItem.itemName})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                           model.deleteitem(index);
                                          },
                                          icon: const Icon(
                                              Icons.delete_outline_rounded))
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const AutoSizeText('Quantity:'),
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle),
                                        onPressed: () {
                                          // Decrease quantity when the remove button is pressed
                                          if (selectedItem.qty != null &&
                                              (selectedItem.qty ?? 0) > 0) {
                                            model.removeitem(index);
                                          }
                                        },
                                      ),
                                      Text(
                                        model
                                            .getQuantity(selectedItem)
                                            .toString(),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle),
                                        onPressed: () {
                                          model.additem(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        'Rate: ${selectedItem.rate.toString()}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      AutoSizeText(
                                        'Amount: ${selectedItem.amount?.toString() ?? ""}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  buildbillingsection(model),
                  const SizedBox(
                    height: 25,
                  ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CtextButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          onPressed: () => model.onSavePressed(context),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12)),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            overlayColor: MaterialStateProperty.all(
                                Theme.of(context).badgeTheme.textColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              model.isloading
                                  ? LoadingAnimationWidget.hexagonDots(
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  :  Text(
                                     model.isEdit ?'Update Order' :'Create Order',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget buildImage(String? imageUrl) {
    return Image.network(
      '$baseurl$imageUrl',
    height: 40,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          // Image is done loading
          return child;
        } else {
          // Image is still loading
          return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent));
        }
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        // Handle the error by displaying a broken image icon
        return const Center(
            child: Icon(Icons.broken_image_outlined, size: 36.0));
      },
    );
  }

  Widget buildbillingsection(AddOrderViewModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tax and Discount',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow('Total Tax :',
              model.orderdata.totalTaxesAndCharges?.toString() ?? '0.0'),
          buildBillingRow(
              'Subtotal :', model.orderdata.netTotal?.toString() ?? '0.0'),
          buildBillingRow('Discount :',
              model.orderdata.discountAmount?.toString() ?? '0.0'),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow(
              'Total :', model.orderdata.grandTotal?.toString() ?? '0.0'),
        ],
      ),
    );
  }

  Widget buildBillingRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  Widget buildItemColumn(String labelText, {required String additionalText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(labelText),
        AutoSizeText(additionalText),
      ],
    );
  }
}
