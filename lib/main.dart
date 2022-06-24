import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/auth.dart';
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/order_list.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/screens/auth_or_home_screen.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/orders_screen.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:shopping/screens/product_form_screen.dart';
import 'package:shopping/screens/products_screen.dart';
import 'package:shopping/utils/app_routes.dart';
import 'package:shopping/utils/custom_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', []),
          update: (ctx, auth, previous) {
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList('', [].toString()),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
              TargetPlatform.android: CustomPageTransitionBuilder(),
            },
          ),
        ),
        //home: ProductsOverviewScreen(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomeScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
