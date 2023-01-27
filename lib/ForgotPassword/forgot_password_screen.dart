import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kazi_board/Models/barrel_exports.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _forgotPasswordController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _animationController.dispose();

    //_emailController.dispose();
    // _passTextController.dispose();
    // _phoneNumberTextController.dispose();
    // _emailFocusNode.dispose();
    // _passFocusNode.dispose();
    // _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();

    super.initState();
  }

  void _forgetPassSubmitForm() async {
    try {
      await _auth.sendPasswordResetEmail(
        email: _forgotPasswordController.text,
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Login(),
          ));
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl: forgotPasswordUrlImage,
              placeholder: (context, url) => Image.asset(
                'assets/images/wallpaper.jpg',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset(_animation.value, 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * .1,
                ),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email Address ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _forgotPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  onPressed: () {
                    //create ForgetPassSubmitForm
                    _forgetPassSubmitForm();
                  },
                  color: Colors.cyan,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    child: Text(
                      'Reset Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
