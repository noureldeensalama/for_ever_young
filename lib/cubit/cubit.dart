import 'package:for_ever_young/layout/home_screen/home_screen.dart';
import 'package:for_ever_young/layout/services_screen/services_screen.dart';
import 'package:for_ever_young/layout/settings_screen/settings_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_ever_young/Network/Local/cache_helper.dart';
import 'package:for_ever_young/cubit/states.dart';
import 'package:for_ever_young/models/user_model.dart';

class ForEverYoungCubit extends Cubit<ForEverYoungStates> {

  ForEverYoungCubit() : super(ForEverYoungInitialState());
  static ForEverYoungCubit get(context) => BlocProvider.of(context);


  UserModel? userModel;
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        FluentIcons.home_20_regular,
        size: 25,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FluentIcons.text_bullet_list_20_regular,
        size: 25,
      ),
      label: 'Services',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(
    //     FluentIcons.cart_20_regular,
    //     size: 30,
    //   ),
    //   label: 'Shopping',
    // ),
    const BottomNavigationBarItem(
      icon: Icon(
        FluentIcons.settings_20_regular,
        size: 25,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    HomeScreen(),
    ServicesScreen(),
    // ShopScreen(),
    SettingsScreen(),
  ];

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'IsDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      fetchClientData();
    }
    emit(ForEverYoungBottomNavBarState());
  }


  // Profile Images



  Future<void> fetchClientData() async {
    try {
      emit(ForEverYoungGetUserLoadingState()); // Emit loading state if needed
      // await auth.getClientData(); // Call the method from AestheticProAuth
      emit(ForEverYoungGetUserSuccessState()); // Emit success state if needed
    } catch (e) {
      emit(ForEverYoungGetUserErrorState(e.toString())); // Emit error state
    }
  }
}