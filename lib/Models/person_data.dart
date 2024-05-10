class PersonData{

  late String  _personName,_personGender;
  late int _personAge;

  static PersonData? instance;
  PersonData._();
  factory PersonData(){
    instance ??= PersonData._();
    return instance!;
  }

  int get getAge => _personAge;

  set personAge(int value) {
    _personAge = value;
  }

  get getGender => _personGender;

  set personGender(value) {
    _personGender = value;
  }

  String get getName => _personName;

  set personName(String value) {
    _personName = value;
  }

  int calculateWaterIntake(){
    if(_personAge < 14 && _personGender.toLowerCase() == "male"){
      return 2100;
    } else if(_personAge < 14 && _personGender.toLowerCase() == "female"){
      return 1900;
    } else if(_personAge >= 14 && _personGender.toLowerCase() == "male"){
      return 2500;
    }
    return 2000;
  }

}