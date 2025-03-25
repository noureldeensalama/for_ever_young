abstract class ForEverYoungRegisterStates {}

class ForEverYoungRegisterInitialState extends ForEverYoungRegisterStates {}

class ForEverYoungRegisterLoadingState extends ForEverYoungRegisterStates {}

class ForEverYoungRegisterSuccessState extends ForEverYoungRegisterStates {}

class ForEverYoungRegisterErrorState extends ForEverYoungRegisterStates
{
  final String error;

  ForEverYoungRegisterErrorState(this.error);

}
class ForEverYoungCreateUserSuccessState extends ForEverYoungRegisterStates {
  final String uID;

  ForEverYoungCreateUserSuccessState(this.uID);
}
class ForEverYoungCreateUserErrorState extends ForEverYoungRegisterStates
{
  final String error;

  ForEverYoungCreateUserErrorState(this.error);

}
class ForEverYoungChangePasswordVisibilityState extends ForEverYoungRegisterStates{}
