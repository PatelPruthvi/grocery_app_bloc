import 'package:bloc_ecommerce_app/screens/cart/bloc/cart_bloc.dart';
import 'package:bloc_ecommerce_app/screens/cart/ui/cart_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      bottomNavigationBar: BottomBar(cartBloc: cartBloc),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        listener: (context, state) {
          if (state is CartRemovedFromCartActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "${state.productName} removed from cart..",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(seconds: 2),
            ));
          } else if (state is CartMaximumQtyActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Cart allows up to 5 identical items",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(milliseconds: 1400),
            ));
          } else if (state is CartMinimumQtyActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                "At least 1 item required",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                ),
              ),
              duration: const Duration(milliseconds: 1400),
            ));
          } else if (state is CartPayingNotSupportedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                "Buying not supported yet...",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                ),
              ),
              duration: const Duration(milliseconds: 1400),
            ));
          }
        },
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              if (successState.cartItems.isEmpty) {
                return Center(
                  child: Text(
                    "Cart is Empty..",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontSize: 20),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTile(
                      productDataModel: successState.cartItems[index],
                      cartBloc: cartBloc,
                    );
                  });

            default:
              return const Scaffold();
          }
        },
      ),
    );
  }
}
