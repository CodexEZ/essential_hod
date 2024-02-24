
import 'package:ess_ward/components/application_list.dart';
import 'package:ess_ward/pages/approve.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:ess_ward/res/images.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? user;
  @override
  void initState(){
    super.initState();
    loadData();
  }
  void loadData(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        user = prefs.getString('user')??'none';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Center(child: SvgPicture.asset(essentialLogo),),
          bottom:TabBar(
            tabs: <Widget>[
              Tab(
                icon: Text("Requests",style:  GoogleFonts.poppins(textStyle: TextStyle(color: Colors.primaryColor)),),
              ),
              Tab(
                icon: Text("History",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.primaryColor)),),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Applications(user:user ,),
            Center(
              child: Text("Past leaves"),
            ),
          ],
        ),
      ),
    );
  }
}
