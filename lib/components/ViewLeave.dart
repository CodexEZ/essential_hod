import 'package:ess_ward/utils/leaveModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewLeave extends StatefulWidget {
  LeaveViewApiModel model;
  ViewLeave({super.key,required this.model});

  @override
  State<ViewLeave> createState() => _ViewLeaveState();
}

class _ViewLeaveState extends State<ViewLeave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
