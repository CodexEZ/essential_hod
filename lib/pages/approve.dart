import 'package:ess_ward/components/applicant_card_viewholder.dart';
import 'package:ess_ward/pages/reason.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;

class ApprovelPage extends StatefulWidget {
  final String id;
  const ApprovelPage({super.key, required this.id});

  @override
  State<ApprovelPage> createState() => _ApprovelPageState();
}

class _ApprovelPageState extends State<ApprovelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(top: 50, bottom: 40),
                child: Center(
                  child: Text(
                    "Approve the leave",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 40, left: 14, right: 14),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(color: Colors.shadowColor, blurRadius: 30)
                    ]),
                child: Column(
                  children: [
                    const ApplicantCardViewHolder(
                      id: "01UG21020037",
                      fullname: "Pratyush Behera",
                      course: "BTech",
                      branch: "CSE",
                      semester: "21",
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(color: Colors.shadowColor, blurRadius: 30)
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          dateRow(key: "From:", value: "23-jan-2024"),
                          const SizedBox(height: 6),
                          dateRow(key: "To:", value: "09-feb-2024"),
                          const SizedBox(height: 6),
                          dateRow(key: "Reason:", value: "Semester break")
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                                style: const ButtonStyle(
                                    shadowColor: MaterialStatePropertyAll(
                                        Colors.green_80),
                                    elevation: MaterialStatePropertyAll(3),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)))),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 16)),
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green)),
                                onPressed: () {},
                                icon: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                label: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "+918319312145",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: buttons(
                                      label: "Deny",
                                      color: Colors.red,
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ReasonPage())))),
                              const SizedBox(width: 16),
                              Expanded(
                                  child: buttons(
                                      label: "Accept",
                                      color: Colors.green,
                                      onPressed: () {}))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons(
          {required String label,
          required Color color,
          required Function() onPressed}) =>
      ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll(Colors.transparent),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(color: color))),
              elevation: const MaterialStatePropertyAll(0.0),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10))),
          child: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: color, fontSize: 24),
          ));

  Widget dateRow({required String key, String? value}) => Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                key,
                style: const TextStyle(fontSize: 16),
              )),
          Expanded(
              flex: 7,
              child: Text("$value", style: const TextStyle(fontSize: 16)))
        ],
      );
}
