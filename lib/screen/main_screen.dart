import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
import '../controller/calculate_controller.dart';
import '../utils/colors.dart';
import '../widget/button.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    "C",
    "",
    "DEL",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();

    return Scaffold(
      backgroundColor: LColors.scaffoldBgColor,
      body: Column(
        children: [
          GetBuilder<CalculateController>(builder: (context) {
            return outPutSection(controller);
          }),
          inPutSection(controller),
        ],
      ),
    );
  }

  /// In put Section - Enter Numbers
  Expanded inPutSection(CalculateController controller) {
    return Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: LColors.sheetBgColor,
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 2),
            ),
          ),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                switch (index) {

                  /// CLEAR BTN
                  case 0:
                    return CustomButton(
                        buttonTapped: () {
                          controller.clearInputAndOutput();
                        },
                        color: LColors.btnBgColor,
                        textColor: LColors.leftOperatorColor,
                        text: buttons[index]);

                  /// DELETE BTN
                  case 2:
                    return CustomButton(
                        buttonTapped: () {
                          controller.deleteBtnAction();
                        },
                        color: LColors.btnBgColor,
                        textColor: LColors.operatorColor,
                        text: buttons[index]);

                  /// EQUAL BTN
                  case 19:
                    return CustomButton(
                        buttonTapped: () {
                          controller.equalPressed();
                        },
                        color: const Color.fromARGB(255, 12, 142, 131),
                        textColor: const Color.fromARGB(255, 255, 255, 255),
                        text: buttons[index]);

                  default:
                    return CustomButton(
                        buttonTapped: () {
                          controller.onBtnTapped(buttons, index);
                        },
                        color: LColors.btnBgColor,
                        textColor: isOperator(buttons[index])
                            ? LColors.operatorColor
                            : Colors.grey,
                        text: buttons[index]);
                }
              }),
        ));
  }

  /// Out put Section - Show Result
  Expanded outPutSection(CalculateController controller) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.topCenter,
            child: Text(
              "Calculator",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 70),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  controller.userInput,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(controller.userOutput,
                    style: const TextStyle(color: Colors.black, fontSize: 36)),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  ///
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }
}
