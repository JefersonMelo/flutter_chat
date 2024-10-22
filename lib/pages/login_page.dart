import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/app_images.dart';
import '../utils/enums_utils.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailControl = TextEditingController(text: "db value");
  TextEditingController senhaControl = TextEditingController(text: "db value");
  late SharedPreferences storage;
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 229, 227, 227),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(23),
              ),
              Row(children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 5,
                  child: Image.asset(
                    AppImages.iconImg,
                    fit: BoxFit.contain,
                    width: 123,
                    height: 123,
                  ),
                ),
                Expanded(child: Container()),
              ]),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                width: double.infinity,
                // height: 30,
                child: TextField(
                  controller: emailControl,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    // hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                width: double.infinity,
                // height: 30,
                child: TextField(
                  obscureText: isObscureText,
                  controller: senhaControl,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        child: Icon(isObscureText ? Icons.visibility_off : Icons.visibility_sharp),
                      ),
                      hintText: "Senha",
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 11),
                width: double.infinity,
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      if (emailControl.text.trim().isEmpty || senhaControl.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("deu ruim ao tentar se conectar"),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(title: 'Contador Page')));
                        storage = await SharedPreferences.getInstance();
                        await storage.setBool(EnumsPreferencesUtils.keyLoggedIn.name, true);
                      }
                    },
                    // style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                    child: const Text("Entrar", style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
              ),
              Expanded(flex: 5, child: Container()),
              Container(
                margin: const EdgeInsets.all(7),
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: const Text(
                  "Conceder Novo Acesso ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(7),
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: const Text(
                  "Esqueci Minha Senha",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
