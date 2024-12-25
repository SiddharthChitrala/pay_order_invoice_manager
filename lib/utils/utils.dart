import 'package:flutter/material.dart';


class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

   static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent, // Sets the background color of the SnackBar.
      content: Text(message), // The main content of the SnackBar.
    ));
  }

  //rating for movies
  static  double averageRating(List<int> rating){
    var avgRating = 0;
    for(int i=0 ; i< rating.length ; i++) {
      avgRating += rating[i];
      // avgRating = avgRating + rating[i];
      }
      return double.parse((avgRating/rating.length).toStringAsFixed(1));
      
  }
}
