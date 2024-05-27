import 'package:flutter/material.dart';
// import 'package:todo_app_2/screens/login.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 204, 196, 196)),
              child: Text(
                "My To Do App",
                style: TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
              )),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            leading: const Icon(Icons.home),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
              //NAvigate to home Screen
            },
          ),
         
          ListTile(
            title: const Text(
              "My Day",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            leading: const Icon(Icons.wb_sunny),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => const MyDay()));
            },
          ),
          ListTile(
            title: const Text(
              "Important",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            leading: const Icon(Icons.notifications),
            onTap: () {
              //NAvigate to Help Screen
            },
          ),
          ListTile(
            title: const Text(
              "Sttings",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            leading: const Icon(Icons.settings),
            onTap: () {
              //NAvigate to Settings Screen
            },
          ),
        ],
      ),
    );
  }
}
