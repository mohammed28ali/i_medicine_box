import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_form_field.dart';

class ForgetPassScreen extends StatelessWidget {
   ForgetPassScreen({Key? key}) : super(key: key);

  final formKey=GlobalKey<FormState>();
   final TextEditingController emailController=TextEditingController();

   final controller =Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                'Forget Password',
                style: TextStyle(
                  color: mainColor,

                ),
              ),
              leading:IconButton(
                onPressed: (){
                  Get.offNamed(Routes.loginScreen);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: mainColor,
                ),
              ) ,
            ),
            backgroundColor: Colors.white,
            body: Form(
              key:formKey ,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "If you want to recover your account, then please provied your email Id below..",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/forgetpass copy.png",
                        width: 250,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      AuthTextFormFiled(
                        controller: emailController,
                        obscureText: false,
                        validator: (value){
                          if(!RegExp(validationEmail).hasMatch(value)){
                            return 'Invalid email';
                          }else{
                            return null;
                          }
                        },
                        prefixIcon:const Icon(Icons.email,color: mainColor,size: 30,),
                        suffixIcon: const Text(''),
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 50,),
                      GetBuilder<AuthController>(builder: (_){
                        return AuthButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              controller.resetPassword(emailController.text.trim());
                            }
                          },
                          text: "SEND",
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
