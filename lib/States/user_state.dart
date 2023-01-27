import 'package:flutter/material.dart';
import 'package:kazi_board/Models/barrel_exports.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('User is not logged in yet');
            return Login();
          } else {
            if (userSnapshot.hasData) {
              print('user is already Logged in');
              return JobScreen();
            } else if (userSnapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('An error has occured. Try again later'),
                ),
              );
            } else if (userSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const Scaffold(
              body: Center(
                child: Text('Something Went Wrong'),
              ),
            );
          }
        });
  }
}
