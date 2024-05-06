class OnboardContents{
  String title,image, description;
  OnboardContents({required this.title, required this.image, required this.description});
}

List<OnboardContents> contents = [
  OnboardContents(
    title: "Welcome to HydrateMe!",
    image: "assets/images/drinkingWater.svg",
    description: "Stay hydrated and healthy with our intuitive water tracker app. Let us guide you through the journey of maintaining optimal hydration levels throughout your day."
  ),
  OnboardContents(
      title: "Track Your Daily Intake",
      image: "assets/images/tracking.svg",
      description: "Easily monitor your water consumption with our user-friendly interface. Input your daily goal and keep track of how much water you've consumed with just a few taps."
  ),
  OnboardContents(
      title: "Stay Motivated",
      image: "assets/images/notification.svg",
      description: "Set reminders and receive notifications to keep you on track with your hydration goals. Stay motivated with achievements as you progress towards a healthier, more hydrated you."
  ),
];