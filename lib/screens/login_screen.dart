import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gest_event_slama_best_choice_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gest_event_slama_best_choice_app/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //device info

  String? _deviceName;
  @override
  void initState() {
    // TODO: implement initState
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //YO93DO MSAJLIN LI KTIBTHOM LIKHRIN
    _emailController.text = "beetiheb@gmail.com";
    _passwordController.text = "123456789";
    super.initState();
  }

  void getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        _deviceName = androidInfo.model;
      } else
        var isIos;
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
        _deviceName = iosInfo.utsname.machine;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // bae3ed maysaker l page tfassakh donnees taa luser mil bdd
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                minWidth: double.infinity,
                color: Colors.blue,
                child: Text('Login', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  //take data from form
                  Map creds = {
                    'email': _emailController.text,
                    'password': _passwordController.text,
                    'device_name': _deviceName ?? 'Unkown',
                  };
                  //send it to service authentication
                  if (_formKey.currentState!.validate()) {
                    // print(creds);
                    Provider.of<Auth>(context, listen: false)
                        .login(creds: creds);
                        
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
