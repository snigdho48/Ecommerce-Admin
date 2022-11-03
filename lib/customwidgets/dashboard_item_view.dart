import 'package:ecom_admin_07/models/dashboard_model.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  final DashboardModel model;
  const DashboardItemView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, model.routeName),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(model.iconData, size: 50, color: Theme.of(context).primaryColor,),
              const SizedBox(height: 10,),
              Text(model.title, style: Theme.of(context).textTheme.headline6,),
            ],
          ),
        ),
      ),
    );
  }
}
