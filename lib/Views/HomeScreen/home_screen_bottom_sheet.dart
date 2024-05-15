import 'package:flutter/material.dart';
import 'package:water_tracker/Utils/constants.dart';
import '../../Models/bottom_sheet_contents.dart';
import '../Components/bottom_sheet_container.dart';

class HomeScreenBottomSheet extends StatelessWidget {
  final TextEditingController drinkSizeController;
  final Function(int) onContainerTap;
  final Function(BuildContext) addWaterIntake;
  final Orientation orientation;

  const HomeScreenBottomSheet(
      {super.key,
      required this.drinkSizeController,
      required this.onContainerTap,
      required this.addWaterIntake,
      required this.orientation});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) => SizedBox(
        height: (orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.height * 0.6
            : MediaQuery.of(context).size.height * 0.8,
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
                        bottomSheetDrinkTypeHeader,
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
                        bottomSheetDrinkTypeSecondaryHeader,
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
                    height: (orientation == Orientation.portrait)
                        ? MediaQuery.of(context).size.height * 0.35
                        : MediaQuery.of(context).size.height * 0.7,
                    child: GridView.builder(
                      itemCount: containerContents.length,
                      primary: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            (orientation == Orientation.landscape) ? 2.5 : 1.55,
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
                            orientation: orientation,
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
                    height: 5,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: drinkSizeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 16),
                      labelText: bottomSheetDrinkTypeEditBoxText,
                      hintFadeDuration: Duration(seconds: 1),
                      hintText: bottomSheetDrinkTypeEditBoxText,
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
                  SizedBox(
                    height: (orientation == Orientation.portrait) ? 20 : 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (orientation == Orientation.portrait)
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.15,
                    child: ElevatedButton(
                      onPressed: () {
                        addWaterIntake(context);
                        drinkSizeController.clear();
                      },
                      child: const Text(
                        bottomSheetAddDrinkButtonText,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (orientation == Orientation.portrait) ? 10 : 10,
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
