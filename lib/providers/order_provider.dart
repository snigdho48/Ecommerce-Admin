import '../db/db_helper.dart';
import '../models/order_constant_model.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantModel orderConstantModel = OrderConstantModel();
  List<OrderModel> orderList = [];

  OrderModel getOrderById(String id) {
    return orderList.firstWhere((element) => element.orderId == id);
  }

  getOrders() {
    DbHelper.getAllOrders().listen((snapshot) {
      orderList = List.generate(snapshot.docs.length,
          (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getOrderConstants() {
    DbHelper.getOrderConstants().listen((snapshot) {
      if (snapshot.exists) {
        orderConstantModel = OrderConstantModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Future<void> updateOrderConstants(OrderConstantModel model) {
    return DbHelper.updateOrderConstants(model);
  }

  Future<void> updateOrderStatus(String orderId, String status) {
    return DbHelper.updateOrderStatus(orderId, status);
  }

  num getOrderByDate(num day, num month, num year) {
    //final dt = DateTime.now().subtract(Duration(days: 7));
    num total = 0;
    for(final order in orderList) {
      if(order.orderDate.day == day &&
      order.orderDate.month == month &&
      order.orderDate.year == year) {
        total += 1;
      }
    }
    return total;
  }

  num getTotalItemsSoldByDate(num day, num month, num year) {
    num total = 0;
    for(final order in orderList) {
      if(order.orderDate.day == day &&
          order.orderDate.month == month &&
          order.orderDate.year == year) {
        for(final model in order.productDetails) {
          total += model.quantity;

        }
      }
    }
    return total;
  }
  num getWeeklyOrderPlace(){
    num total=0;
    final currentdate=DateTime.now();
    for(int i=0;i<7;i++){
      var date=currentdate.subtract(Duration(days: i));
      total+=getOrderByDate(date.day, date.month, date.year);
    }

    return total;
  }
  num getWeeklyOrderItemQuantity(){
    num total=0;
    final currentdate=DateTime.now();
    for(int i=0;i<7;i++){
      var date=currentdate.subtract(Duration(days: i));
      total+=getTotalItemsSoldByDate(date.day, date.month, date.year);

    }

    return total;
  }
  num getLastMonthOrderPlace(){
    num total=0;
    final currentdate=DateTime.now().subtract(Duration(days: DateTime.now().day));
    for(int i=0;i<currentdate.day;i++){
      var date=currentdate.subtract(Duration(days: i));
      print('$i:$total');
      total+=getOrderByDate(date.day, date.month, date.year);
    }
    return total;
  }
  num getLastMonthOrderItemQuantity(){
    num total=0;
    final currentdate=DateTime.now().subtract(Duration(days: DateTime.now().day));
    for(int i=0;i<currentdate.day;i++){
      var date=currentdate.subtract(Duration(days: i));
      print('$i:$total');
      total+=getTotalItemsSoldByDate(date.day, date.month, date.year);
    }
    return total;
  }
  num getYearOrderPlace(){
    num total=0;
    final currentdate=DateTime.now();
    for(int i=0;i<400;i++){
      var date=currentdate.subtract(Duration(days: i));
      if(date.year==(currentdate.year-1)) break;
      print('$i:$total');
      total+=getOrderByDate(date.day, date.month, date.year);

    }
    return total;
  }
  num getYearOrderItemQuantity(){
    num total=0;
    final currentdate=DateTime.now();
    for(int i=0;i<400;i++){
      var date=currentdate.subtract(Duration(days: i));
      if(date.year==(currentdate.year-1)) break;
      print('$i:$total');
      total+=getTotalItemsSoldByDate(date.day, date.month, date.year);
    }
    return total;
  }

}
