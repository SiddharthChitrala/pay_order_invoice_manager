import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class UtilsReference{
  // Displays a toast message with the given text.
  // Uses Fluttertoast for simplicity. Toasts are lightweight and quick for showing short messages.
  // static toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //   );
  // }

  // Displays an error message using a Flushbar.
  // Flushbar is a highly customizable notification bar.
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message, // The main message to display.
          title: "Error", // Optional title for the message.
          backgroundColor: Colors.redAccent, // Sets the background color of the Flushbar.
          messageColor: Colors.white, // Sets the text color of the message.
          duration: const Duration(seconds: 3), // Specifies how long the Flushbar will be visible.
          flushbarPosition: FlushbarPosition.TOP, // Determines where the Flushbar appears on the screen.
          forwardAnimationCurve: Curves.decelerate, // Animation curve when the Flushbar appears.
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10), // Adds margin around the Flushbar.
          padding: const EdgeInsets.all(15), // Adds padding inside the Flushbar.
          borderRadius: BorderRadius.circular(25), // Gives the Flushbar rounded corners.
          reverseAnimationCurve: Curves.easeInOut, // Animation curve when the Flushbar disappears.
          icon: const Icon(
            Icons.error_outlined,
            size: 28, // Size of the icon.
            color: Colors.white, // Color of the icon.
          ),
        )..show(context)); // Displays the Flushbar.
  }

  // Displays a SnackBar with the given message.
  // SnackBars are lightweight widgets that appear at the bottom of the screen.
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent, // Sets the background color of the SnackBar.
      content: Text(message), // The main content of the SnackBar.
    ));
  }
}

/* Suggestions for improvement or additional features:

1. **Success and Warning Variants:**
   - Add methods for success and warning messages to standardize the app's feedback system.
     Example:
     ```dart
     static void flushBarSuccessMessage(String message, BuildContext context) {
       showFlushbar(
         context: context,
         flushbar: Flushbar(
           message: message,
           title: "Success",
           backgroundColor: Colors.green,
           messageColor: Colors.white,
           duration: const Duration(seconds: 3),
           flushbarPosition: FlushbarPosition.TOP,
           icon: const Icon(
             Icons.check_circle_outline,
             size: 28,
             color: Colors.white,
           ),
         )..show(context));
     }
     ```

2. **Customizable Durations and Colors:**
   - Allow passing parameters for duration, background color, and text color to make these methods reusable for various contexts.

3. **Localization Support:**
   - Integrate localization for message strings to support multiple languages.
     Example: Use `Intl` package for localized strings.

4. **Logging:**
   - Optionally log all messages to a logging system or analytics tool for tracking purposes.

5. **SnackBar Action:**
   - Add support for actions in SnackBars (e.g., an "Undo" button).
     ```dart
     static snackBarWithAction(String message, BuildContext context, VoidCallback action) {
       return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.redAccent,
         content: Text(message),
         action: SnackBarAction(
           label: "Undo",
           onPressed: action,
           textColor: Colors.white,
         ),
       ));
     }
     ```

6. **Theme Awareness:**
   - Adapt colors based on the app's current theme (light/dark mode).
     Example:
     ```dart
     static toastMessage(String message, {bool isDarkMode = false}) {
       Fluttertoast.showToast(
         msg: message,
         backgroundColor: isDarkMode ? Colors.grey[800] : Colors.black,
         textColor: Colors.white,
       );
     }
     ```
*/

