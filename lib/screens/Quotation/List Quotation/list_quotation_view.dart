import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_quotation_model.dart';

class ListQuotationScreen extends StatelessWidget {
  const ListQuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListQuotationModel>.reactive(
        viewModelBuilder: () => ListQuotationModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Quotation'),
            leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),),
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  model.quotationlist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (builder, index) {
                          return  Container(
                                        decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                            child: GestureDetector(
                               onTap: () => model.onRowClick(
                                   context, model.quotationlist[index]),
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
                                              model.quotationlist[index]
                                                  .name ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              model.quotationlist[index]
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
                                              .quotationlist[
                                          index]
                                              .status ??
                                              ""),
                                          // Make the inside of the card hollow
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                10.0),
                                            child: AutoSizeText(
                                              model.quotationlist[index]
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
                                              model.quotationlist[index]
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
                                              model.quotationlist[index]
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
                                              '${model.quotationlist[index].grandTotal?.toString() ?? "0.0"}',
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
                        itemCount: model.quotationlist.length),
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
              Navigator.pushReplacementNamed(context, Routes.addQuotationView, arguments: AddQuotationViewArguments(quotationid: "")
                 );
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
