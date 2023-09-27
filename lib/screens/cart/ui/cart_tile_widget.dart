import 'package:bloc_ecommerce_app/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/models/home_products_data_model.dart';

class CartTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartTile({
    Key? key,
    required this.productDataModel,
    required this.cartBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(productDataModel.imgUrl)),
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.01,
                      child: IconButton(
                          onPressed: () {
                            cartBloc
                                .add(CartRemoveFromCartEvent(productDataModel));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(productDataModel.id.toString()),
                            Text(
                              productDataModel.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  letterSpacing: 0.3),
                            ),
                            Text(
                              productDataModel.desc,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  letterSpacing: 0.3),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$${productDataModel.price}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).indicatorColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {
                                    cartBloc.add(
                                        CartDecrementItemButtonPressedEvent(
                                            productDataModel));
                                  },
                                  splashRadius: 1,
                                  disabledColor: Colors.grey[200],
                                  icon: Icon(
                                    Icons.remove,
                                    color: Theme.of(context).primaryColor,
                                  )),
                            ),
                            Text(
                              productDataModel.qty.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: GoogleFonts.lato().fontFamily),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).indicatorColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  splashRadius: 1,
                                  disabledColor: Colors.grey[200],
                                  onPressed: () {
                                    cartBloc.add(
                                        CartIncrementItemButtonPressedEvent(
                                            productDataModel));
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
