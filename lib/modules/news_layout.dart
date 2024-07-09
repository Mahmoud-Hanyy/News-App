import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazaaf/components/components.dart';
import 'package:wazaaf/modules/news/cubit/cubit.dart';
import 'package:wazaaf/modules/news/cubit/states.dart';
import 'package:wazaaf/modules/news/search/search_screen.dart';
import 'package:wazaaf/modules/to_do/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context,SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                ),
                IconButton(
                    onPressed: (){
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: const Icon(
                      Icons.dark_mode_outlined,
                      size: 30.0,
                    ),
                    ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              child: const Icon(
                Icons.add,
              ),
              ),
            );
        },
    );
  }
}
