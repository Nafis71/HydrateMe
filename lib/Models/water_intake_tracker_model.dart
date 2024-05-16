class WaterIntakeTrackerModel{
  static WaterIntakeTrackerModel? instance;
  double selectedDrinkQuantity = 0.0;
  String selectedDrink = "";
  int goalCompletion = 0;

  WaterIntakeTrackerModel._();

  static WaterIntakeTrackerModel getInstance(){
    return instance ??= WaterIntakeTrackerModel._();
  }

}