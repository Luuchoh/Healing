import 'package:flutter/material.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/HomePage.dart';
import 'package:healing/Pages/InitialPage.dart';
import 'package:healing/Pages/LoadingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  User? user;
  Count? count;

  MyApp({this.user, this.count});

  @override
  State<StatefulWidget> createState() => MyAppState(user: user, count: count);
}
class MyAppState extends State<MyApp> {

  User? user;
  Count? count;
  bool isLoading = false;

  MyAppState({this.user, this.count});

  @override
  void initState() {
    if(count == null && user == null) getUserAndCount();
    super.initState();
  }

  getUserAndCount() async{
    setState(() => isLoading = true);
    Count? count = await Count().getCount();
    User? user = await User().getUserLocalDB();

    if(mounted) {
      if (count != null && user != null) {
        setState(() {
          this.user = user;
          this.count = count;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getPage(),
    );
  }

  Widget getPage() {
    return (isLoading)
        ? LoadingPage()
        : (count != null && user != null)
        ? HomePage(user!, count!)
        : InitialPage();
  }
}
