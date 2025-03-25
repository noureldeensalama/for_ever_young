import 'package:for_ever_young/models/user_model.dart';

abstract class ForEverYoungStates{}

class ForEverYoungInitialState extends ForEverYoungStates{}

class ForEverYoungBottomNavBarState extends ForEverYoungStates{
  final UserModel? userModel;

  ForEverYoungBottomNavBarState({this.userModel});
}

class ForEverYoungCalendarLoadingState extends ForEverYoungStates {}

class ForEverYoungGetCalendarSuccessState extends ForEverYoungStates {}

class ForEverYoungGetCalendarErrorState extends ForEverYoungStates {
  final String error;

  ForEverYoungGetCalendarErrorState(this.error);
}

class ForEverYoungSearchLoadingState extends ForEverYoungStates{}

class ForEverYoungGetSearchSuccessState extends ForEverYoungStates{}

class ForEverYoungGetSearchErrorState extends ForEverYoungStates{
  final String error;

  ForEverYoungGetSearchErrorState(this.error);
}

class ForEverYoungLoadingState extends ForEverYoungStates {}

class ForEverYoungErrorState extends ForEverYoungStates {
  final String errorMessage;
  ForEverYoungErrorState(this.errorMessage);
}

class ForEverYoungCountryEventsLoadedState extends ForEverYoungStates {
  final List<Map<String, dynamic>> countryEvents;
  ForEverYoungCountryEventsLoadedState(this.countryEvents);
}
class AppChangeModeState extends ForEverYoungStates{
  final UserModel? userModel;

  AppChangeModeState({this.userModel});
}

class ForEverYoungProfileImagePickedSuccessState extends ForEverYoungStates{}

class ForEverYoungProfileImagePickedErrorState extends ForEverYoungStates{}

class ForEverYoungCoverImagePickedSuccessState extends ForEverYoungStates{}

class ForEverYoungCoverImagePickedErrorState extends ForEverYoungStates{}

class ForEverYoungGetUserLoadingState extends ForEverYoungStates{}

class ForEverYoungGetUserSuccessState extends ForEverYoungStates {}

class ForEverYoungGetUserErrorState extends ForEverYoungStates {
  final String errorMessage;

  ForEverYoungGetUserErrorState(this.errorMessage);
}