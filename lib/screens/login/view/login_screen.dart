import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zone_fe/screens/home/controllers/home_controller.dart';
import 'package:zone_fe/screens/login/controller/login_controller.dart';
import 'package:zone_fe/widgets/custom_dialog.dart';

// import 'singInPage.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  MyDialog dialog = MyDialog();
  bool state = true;
  String check = "false";
  // checkLogin() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   check = preferences.getString('log').toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/image/1.jpg"),
                  maxRadius: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'مرحبا',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Welcome Back,You\'ve been missed',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                //User name
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: username,
                            validator: (val) {
                              return validInput(val!, 30, 5);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'إسم المستخدم',
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: password,
                            validator: (val) {
                              return validInput(val!, 16, 8);
                            },
                            obscureText: state,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'كلمة السر',
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                splashRadius: 25,
                                icon: state
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.remove_outlined),
                                onPressed: () {
                                  setState(() {
                                    state = !state;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                GetBuilder(
                    init: LoginController(),
                    builder: (controller) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(20),
                            child: GestureDetector(
                              child: Center(
                                child: controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                              onTap: () async {
                                var formData = formState.currentState;
                                if (formData!.validate()) {
                                  await controller.login(
                                      username: username.text,
                                      password: password.text);
                                 
                                    if (controller.error == null) {
                                      Navigator.of(context)
                                          .pushReplacementNamed("/home");
                                    }
                                    else{
                                      dialog.opendilog(
                                        context, "خطأ", "حدث خطأ");
                                    }
                                    
                                  
                                }
                              },
                            ),
                          ));
                    }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      ' Zone  الحل الافضل لتنظيم التوزيع',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validInput(String val, int max, int min) {
    if (val.length > max) {
      return " لايمكن ان يكون اكبر من $max ";
    }
    if (val.isEmpty) {
      return "يجب تعبأة هذا الحقل";
    }
    if (val.length < min) {
      return " لا يمكن ان يكون اقل من $min ";
    }
  }
}
