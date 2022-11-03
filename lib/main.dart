import 'package:ecom_admin_07/pages/add_product_page.dart';
import 'package:ecom_admin_07/pages/category_page.dart';
import 'package:ecom_admin_07/pages/dashboard_page.dart';
import 'package:ecom_admin_07/pages/launcher_page.dart';
import 'package:ecom_admin_07/pages/login_page.dart';
import 'package:ecom_admin_07/pages/order_page.dart';
import 'package:ecom_admin_07/pages/product_details_page.dart';
import 'package:ecom_admin_07/pages/product_repurchase_page.dart';
import 'package:ecom_admin_07/pages/settings_page.dart';
import 'package:ecom_admin_07/pages/user_list_page.dart';
import 'package:ecom_admin_07/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'pages/report_page.dart';
import 'pages/view_product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName : (_) => const LauncherPage(),
        LoginPage.routeName : (_) => const LoginPage(),
        DashboardPage.routeName : (_) => const DashboardPage(),
        AddProductPage.routeName : (_) => const AddProductPage(),
        ViewProductPage.routeName : (_) => const ViewProductPage(),
        ProductDetailsPage.routeName : (_) => const ProductDetailsPage(),
        CategoryPage.routeName : (_) => const CategoryPage(),
        OrderPage.routeName : (_) => const OrderPage(),
        ReportPage.routeName : (_) => const ReportPage(),
        SettingsPage.routeName : (_) => const SettingsPage(),
        ProductRepurchasePage.routeName : (_) => const ProductRepurchasePage(),
        UserListPage.routeName : (_) => const UserListPage(),
      },
    );
  }
}

