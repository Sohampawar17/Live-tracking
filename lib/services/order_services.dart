import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/order_list_model.dart';

class OrderServices {
  Future<List<OrderList>> fetchsalesorder() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Sales Order?fields=["name","customer_name","transaction_date","grand_total","status","total_qty"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<OrderList> caneList = List.from(jsonData['data'])
            .map<OrderList>((data) => OrderList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Orders!");
      return [];
    }
  }
}
