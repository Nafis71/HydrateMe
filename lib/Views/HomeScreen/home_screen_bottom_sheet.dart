import 'package:flutter/material.dart';
import '../../Models/bottom_sheet_contents.dart';
import '../Components/bottom_sheet_container.dart';

class HomeScreenBottomSheet extends StatelessWidget {
  final TextEditingController drinkSizeController;
  final Function(int) onContainerTap;
  final Function(BuildContext) addWaterIntake;

  const HomeScreenBottomSheet(
      {super.key,
      required this.drinkSizeController,
      required this.onContainerTap,
      required this.addWaterIntake});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: const EdgeInsets.all(10.00),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Wrap(
                    children: [
                      Text(
                        "Choose drink type",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Wrap(
                    children: [
                      Text(
                        "Select what you actually drink",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.27,
                    child: GridView.builder(
                      itemCount: containerContents.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.7,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            onContainerTap(index);
                            setModalState(() {});
                          },
                          child: BottomSheetContainer(
                            backgroundColor:
                                containerContents[index].backgroundColor,
                            borderColor: containerContents[index].borderColor,
                            cardHeader: containerContents[index].header,
                            icon: containerContents[index].icon,
                            index: index,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: drinkSizeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 16),
                      labelText: "Enter size of the drink",
                      hintFadeDuration: Duration(seconds: 1),
                      hintText: "Enter size of the drink",
                      contentPadding: EdgeInsets.all(15.00),
                      prefixIcon: Icon(Icons.water_drop),
                      prefixIconColor: Colors.blue,
                      suffix: Text("ml"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        addWaterIntake(context);
                        drinkSizeController.clear();
                      },
                      child: const Text(
                        "ADD DRINK",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
