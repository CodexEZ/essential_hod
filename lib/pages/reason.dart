import 'package:ess_hod/data/reason.dart';
import 'package:ess_hod/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;

class ReasonPage extends StatefulWidget {
  const ReasonPage({super.key});

  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
  final reasonController = TextEditingController();
  bool expendReason = false;
  String selectedReason = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 150,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left_outlined,
                color: Colors.secondaryColor,
              ),
              label: const Text(
                "Back",
                style: TextStyle(
                    color: Colors.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "State the reason for denying the application:",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.shadowColor, blurRadius: 30)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: DropdownButtonFormField<String>(
                      menuMaxHeight: 200,
                      isExpanded: true,
                      hint: const Text(
                        "Select an option",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.gray,
                            fontWeight: FontWeight.w600),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "*required";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          border: InputBorder.none),
                      items: commonReason.map((String currentValue) {
                        return DropdownMenuItem(
                          value: currentValue,
                          child: Text(currentValue),
                        );
                      }).toList(),
                      value: null,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value!;
                          value.contains("other")
                              ? expendReason = true
                              : expendReason = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  expendReason
                      ? Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.shadowColor, blurRadius: 30)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "*required";
                              }
                              return null;
                            },
                            controller: reasonController,
                            maxLines: 5,
                            maxLength: 250,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                                isDense: true,
                                counter: Text(""),
                                hintText: "Type here...",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 18),
                                border: InputBorder.none),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
