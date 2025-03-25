import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/cubit/states.dart';

class ForEverYoungLayout extends StatelessWidget {
  const ForEverYoungLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForEverYoungCubit, ForEverYoungStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = ForEverYoungCubit.get(context);

        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}