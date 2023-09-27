import 'package:bloc_ecommerce_app/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatelessWidget {
  final CartBloc cartBloc;
  const BottomBar({super.key, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        bloc: cartBloc,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 0.0,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.25,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: \$ ${successState.price.toStringAsFixed(2)} ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                fontFamily: GoogleFonts.lato().fontFamily),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cartBloc.add(CartOnPayButtonClickedEvent(
                                  successState.price));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).indicatorColor)),
                            child: Text(
                              "Pay Now",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: GoogleFonts.lato().fontFamily),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            default:
              return Scaffold();
          }
        });
  }
}
