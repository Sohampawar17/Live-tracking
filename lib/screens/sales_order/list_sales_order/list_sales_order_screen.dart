import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import 'list_salesorder_viewmodel.dart';

class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListOrderModel>.reactive(
        viewModelBuilder: () => ListOrderModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Sales Order'),
                leading: IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Routes.homePage);
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      model.orderlist.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                  itemBuilder: (builder, index) {
                                    return Card(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => model.onRowClick(
                                            context, model.orderlist[index]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        model.orderlist[index]
                                                                .name ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        model.orderlist[index]
                                                                .transactionDate ??
                                                            "",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                          color: Colors.black26,
                                                          width:
                                                              1), // Set border color and width
                                                    ),
                                                    color: model
                                                        .getColorForStatus(model
                                                                .orderlist[
                                                                    index]
                                                                .status ??
                                                            ""),
                                                    // Make the inside of the card hollow
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: AutoSizeText(
                                                        model.orderlist[index]
                                                                .status ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Customer name',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        model.orderlist[index]
                                                                .customerName ??
                                                            "",
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Items',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        model.orderlist[index]
                                                                .totalQty
                                                                ?.toString() ??
                                                            "0.0",
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Amount",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${model.orderlist[index].grandTotal?.toString() ?? "0.0"}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .green, // You can change the color
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, builder) {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: model.orderlist.length),
                            )
                          : Container()
                    ],
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.addOrderScreen,
                      arguments: AddOrderScreenArguments(orderid: ""));
                },
                child: Icon(Icons.add),
              ),
            ));
  }
}
