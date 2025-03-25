import 'package:for_ever_young/models/user_model.dart';

abstract class ForEverYoungLoginStates {}

class ForEverYoungLoginInitialState extends ForEverYoungLoginStates {}

class ForEverYoungLoginLoadingState extends ForEverYoungLoginStates {}

class ForEverYoungLoginSuccessState extends ForEverYoungLoginStates {
  final UserModel userModel;
  ForEverYoungLoginSuccessState(this.userModel);
}

class ForEverYoungLoginErrorState extends ForEverYoungLoginStates
{
  final String error;

  ForEverYoungLoginErrorState(this.error);

}
class ForEverYoungChangePasswordVisibilityState extends ForEverYoungLoginStates{}
