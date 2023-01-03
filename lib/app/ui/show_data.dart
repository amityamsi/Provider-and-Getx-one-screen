import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/app/providers/login_provider.dart';

class ShowDataScreen extends StatelessWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Data"),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (context, LoginProvider loginProvider, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 80,
                      backgroundImage: Image.file(
                        loginProvider.details[0]!,
                        fit: BoxFit.cover,
                      ).image),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * .05),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "User Name: ",
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            loginProvider.details[1].toString(),
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Gender: ",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          loginProvider.details[2].toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
