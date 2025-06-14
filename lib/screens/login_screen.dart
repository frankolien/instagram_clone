import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_method.dart';
import 'package:flutter_application_1/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_1/responsive/responsive_layout_screen.dart';
import 'package:flutter_application_1/responsive/web_screen_layout.dart';
import 'package:flutter_application_1/screens/sign_up_screen.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/util/utils.dart';
import 'package:flutter_application_1/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading =false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

  }

  void loginUser() async{
    setState(() {
      isLoading = true;
    });
    Future<String> res = AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScreen(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res as BuildContext, context as String);
      setState(() {
        isLoading = false;
      });
    } 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2,child: Container(),),
              //svg logo
              SvgPicture.asset(
                'lib/images/ic_instagram.svg',
                color: Colors.white,
                height: 64,
              ),
              // Instagram logo
               SizedBox(height: 64),
              // TextFieldInput for email
               TextFieldInput(
                   textEditingController: _emailController,
                   hintText: 'Enter your Email',
                   textInputType: TextInputType.emailAddress,
               ),
              SizedBox(height: 24,),

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your Password',
                textInputType: TextInputType.text,
                isPassed: true,
              ),
              SizedBox(height: 24,),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        )
                      ),
                    color: blueColor,
                  ),
                  child: isLoading ? 
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ) :
                  const
                   Text('Login'),
                ),
              ),
              SizedBox(height: 12,),
              Flexible(child: Container(),flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Dont have an account?',
                    ),
                  ),
                  SizedBox(width: 2),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Signup.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}