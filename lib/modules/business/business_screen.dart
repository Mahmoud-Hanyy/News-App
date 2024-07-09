import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazaaf/components/components.dart';
import 'package:wazaaf/modules/news/cubit/cubit.dart';
import 'package:wazaaf/modules/news/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).business;
        return ArticleBuilder(list,context);
      },

    );
  }
}
