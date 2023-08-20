// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_ap/utils/routes.dart';
import 'package:shopping_ap/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/shopping.dart';
import 'home_widget/shopping_header.dart';
import 'home_widget/shopping_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    final shoppingJson =
        await rootBundle.loadString("assets/files/shopping.json");
    final decodedData = jsonDecode(shoppingJson);
    var productsData = decodedData["products"];
    ShoppingModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cardRoute),
        backgroundColor: MyTheme.lightBluishColor,
        child: const Icon(CupertinoIcons.cart),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const ShoppingHeader(),
            if (ShoppingModel.items.isNotEmpty)
              const ShoppingList().py16().expand()
            else
              const CircularProgressIndicator().centered().expand(),
          ]),
        ),
      ),
    );
  }
}
