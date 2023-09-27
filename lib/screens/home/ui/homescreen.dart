// ignore_for_file: prefer_const_constructors

import 'package:bloc_ecommerce_app/data/wishlist_items.dart';
import 'package:bloc_ecommerce_app/screens/cart/ui/cartscreen.dart';
import 'package:bloc_ecommerce_app/screens/home/bloc/home_bloc.dart';
import 'package:bloc_ecommerce_app/screens/home/ui/product_tile_widget.dart';
import 'package:bloc_ecommerce_app/screens/wishlist/ui/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      listener: (context, state) {
        if (state is HomeNavigateToCartActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        } else if (state is HomeNavigateToWishListActionState) {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WishList()))
              .whenComplete(() {
            homeBloc.add(HomeWishListBackPressedEvent());
          });
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Item Added to Cart",
                style: TextStyle(color: Theme.of(context).canvasColor)),
            backgroundColor: Theme.of(context).primaryColor,
            duration: Duration(milliseconds: 1200),
          ));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Item Added to Wishlist",
              style: TextStyle(color: Theme.of(context).canvasColor),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            duration: Duration(milliseconds: 1200),
          ));
        } else if (state is HomeBackPressedState) {
          setState(() {});
        }
      },
      buildWhen: (previous, current) {
        return current is! HomeActionState;
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishListButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.favorite_outline,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                      )),
                ],
                title: Text(
                  'Grocery App',
                ),
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    if (wishlistItems.contains(successState.products[index])) {
                      return ProductTile(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                        likedIcon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      );
                    } else {
                      return ProductTile(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                        likedIcon: Icon(
                          Icons.favorite_border_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  }),
            );

          case HomeErrorState:
            return Scaffold(
                body: Center(
              child: Text('Error'),
            ));
          default:
            return Scaffold();
        }
      },
    );
  }
}
