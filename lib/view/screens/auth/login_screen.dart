
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_form_field.dart';
import '../../widgets/text_utils.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final fromKey=GlobalKey<FormState>();

  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();


  final controller=Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/1.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 40),
                    child: Form(
                      key: fromKey ,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              TextUtils(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                text: "LOG",
                                color: mainColor,
                                underline: TextDecoration.none,
                              ),
                              SizedBox(width:3 ,),
                              TextUtils(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                text: "IN",
                                color: mainColor3,
                                underline: TextDecoration.none,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const SizedBox(height: 20,),
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
                            prefixIcon:const Icon(Icons.person,color: mainColor,size: 30,),
                            suffixIcon: const Text(''),
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 20,),
                          GetBuilder<AuthController>(
                            builder:(_){
                              return AuthTextFormFiled(
                                controller: passwordController,
                                obscureText: controller.isVisibility ? false:true,
                                validator: (value){
                                  if(value.toString().length<6){
                                    return 'Password should be longer or equal to 6 characters';
                                  }else{
                                    return null;
                                  }
                                },
                                prefixIcon:const Icon(Icons.lock,color: mainColor,size: 30,),
                                suffixIcon:IconButton(
                                  onPressed: (){
                                    controller.visibility();
                                  },
                                  icon:controller.isVisibility ? const Icon(
                                    Icons.visibility,
                                    color: mainColor,
                                  ):  const Icon(Icons.visibility_off,color: mainColor3,),
                                ) ,
                                hintText: 'Password',
                              );
                            } ,
                          ),
                          Align(
                            alignment:Alignment.centerRight,
                            child: TextButton(
                              onPressed: (){
                                Get.offNamed(Routes.forgetPassScreen);
                              },
                              child: const TextUtils(
                                text:"Reset Password" ,
                                color: mainColor3,
                                fontWeight: FontWeight.normal,
                                fontSize:14 ,
                                underline:TextDecoration.none ,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50,),
                          GetBuilder<AuthController>(builder: (_){
                            return AuthButton(
                              onPressed: (){
                                if(fromKey.currentState!.validate()){
                                  String email=emailController.text.trim();
                                  String password=passwordController.text;
                                  controller.loginUsingFirebase(
                                    email: email,
                                    password: password,
                                  );
                                }
                              },
                              text: 'Log In',
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
