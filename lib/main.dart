import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing/Bloc/Map/map_bloc.dart';
import 'package:healing/Bloc/MyUbication/my_ubication_bloc.dart';

import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/HomePage.dart';
import 'package:healing/Pages/InitialPage.dart';
import 'package:healing/Pages/LoadingPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyUbicationBloc>(create: (_) => MyUbicationBloc()),
        BlocProvider<MapBloc>(create: (_) => MapBloc())
      ],
      child: MaterialApp(
        home: getPage(),
      ),      
    );
  }

  Widget getPage() {
    return (isLoading)
        ? LoadingPage()
        : (count != null && user != null)
        ? HomePage(user!, count!)
        // ? MapPage()
        : InitialPage();
  }
}
