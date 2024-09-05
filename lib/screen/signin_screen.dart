import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/responsive/mobile_screen_layout.dart';
import 'package:instagramclone/responsive/reposnsive_layout.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';
import 'package:instagramclone/screen/login_screen.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/utils/utils.dart';
import 'package:instagramclone/widgets/textfield.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordCotroller = TextEditingController();
  final TextEditingController _bioCotroller = TextEditingController();
  final TextEditingController _usernameCotroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordCotroller.dispose();
    _bioCotroller.dispose();
    _usernameCotroller.dispose();
  }

  void signUpUser() async {
    //loading bar
    setState(() {
      _isLoading = true;
    });

    //adding data to the database
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordCotroller.text,
        username: _usernameCotroller.text,
        bio: _bioCotroller.text,
        file: _image!);
    print(res);

    setState(() {
      _isLoading = false;
    });

    if (res != "success") {
      showSnakBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ReposnsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout())));
    }
  }

  //image picker
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigatorToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //svg image
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),

              const SizedBox(height: 32),
              //profile image
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://i.stack.imgur.com/l60Hf.png"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectImage, icon: Icon(Icons.add_a_photo)),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              //text field for username
              Textfield(
                hintText: 'enter your username',
                textEditingController: _usernameCotroller,
                textInputType: TextInputType.emailAddress,
              ),

              const SizedBox(
                height: 24,
              ),

              //user info
              Textfield(
                hintText: 'enter your bio',
                textEditingController: _bioCotroller,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                hintText: 'enter your email',
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field for password
              Textfield(
                hintText: 'enter your password',
                textEditingController: _passwordCotroller,
                textInputType: TextInputType.emailAddress,
                isPass: true,
              ),
              //button for login
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Sign Up"),
                ),
              ),

              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Container(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("I have an account!"),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: navigatorToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
