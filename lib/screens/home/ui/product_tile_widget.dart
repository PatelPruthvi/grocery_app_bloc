// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloc_ecommerce_app/screens/home/bloc/home_bloc.dart';
import 'package:bloc_ecommerce_app/screens/home/models/home_products_data_model.dart';

class ProductTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  final Icon likedIcon;

  const ProductTile({
    Key? key,
    required this.productDataModel,
    required this.homeBloc,
    required this.likedIcon,
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
                    padding: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                      productDataModel.imgUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    )),
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
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  letterSpacing: 0.3),
                            ),
                            Text(
                              productDataModel.desc,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 0.3),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$${productDataModel.price}",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 0.3),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeBloc.add(HomeProductWishListButtonClickEvent(
                              productDataModel));
                        },
                        icon: likedIcon,
                      ),
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeProductCartButtonClickEvent(
                                productDataModel));
                          },
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Theme.of(context).primaryColor,
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
