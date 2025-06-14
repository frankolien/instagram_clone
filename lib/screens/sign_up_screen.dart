import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_method.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/util/utils.dart';
import 'package:flutter_application_1/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
    SelectImage() async {
     Uint8List im = await pickImage(ImageSource.gallery);
     setState(() {
       _image = im;
     });
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
              Flexible(child: Container(),flex: 2,),
              //svg logo
              SvgPicture.asset(
                'lib/images/ic_instagram.svg',
                color: Colors.white,
                height: 64,
              ),
              // Instagram logo
              SizedBox(height: 64),
              //circular widget to accept and show selected file
              Stack(
                children: [
               _image!=null? 
               CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                )
                : CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/66/ff/cb/66ffcb56482c64bdf6b6010687938835.jpg',
                  ),
                ),
                
                  Positioned(
                    bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: SelectImage,
                          icon: Icon(Icons.add_a_photo))
                  ),

                ],
              ),
              SizedBox(height: 24,),
              //TextFieldInput for username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your Username',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 24,),
              //TextFieldInput for bio
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your Bio',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 24,),
              // TextFieldInput
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
              GestureDetector(
                onTap: () async {
                  if (_image == null) {
                    showSnackBar(context, 'Please select an image');
                    return;
                  }
                  
                      // Call the signUpUser method from AuthMethod
                      String res = await AuthMethods().signUpUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                        bio: _bioController.text,
                        //profilePicUrl: 'https://example.com/profile_pic.png',
                        file: _image!, // Placeholder for file upload
                      );
                      if (res == "success") {
                        // Navigate to home screen or show success message
                        print('success');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Signup successful!')),
                        );
                        Navigator.of(context).pop();
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res)),
                        );
                      }
                    },

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
                  child: Text('SignUp'),
                ),
              ),
              SizedBox(height: 12,),
              Flexible(child: Container(),flex: 2,),

              // Row for login text
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
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
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