import 'package:bloc_ecommerce_app/screens/wishlist/bloc/wish_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/models/home_products_data_model.dart';

class WishListTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishListBloc wishListBloc;
  const WishListTile({
    Key? key,
    required this.productDataModel,
    required this.wishListBloc,
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
                Container(
                    padding: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.network(productDataModel.imgUrl)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
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
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 0.3),
                            ),
                            Text(
                              productDataModel.desc,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 0.3),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "\$${productDataModel.price}",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            wishListBloc.add(
                                WishListRemoveFromListEvent(productDataModel));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
