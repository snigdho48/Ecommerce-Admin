import '../auth/auth_service.dart';
import '../pages/launcher_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/badge_view.dart';
import '../customwidgets/dashboard_item_view.dart';
import '../models/dashboard_model.dart';
import '../providers/notification_provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllPurchases();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    Provider.of<OrderProvider>(context, listen: false).getOrders();
    Provider.of<UserProvider>(context, listen: false).getAllUsers();
    Provider.of<NotificationProvider>(context, listen: false).getAllNotifications();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          if(model.title == 'Notifications') {
            final count =
                Provider.of<NotificationProvider>(context).totalUnreadMessage;
            return DashboardItemView(
              model: model,
              badge: BadgeView(count: count,),);
          }
          return DashboardItemView(model: model);
        },
      ),
    );
  }
}
