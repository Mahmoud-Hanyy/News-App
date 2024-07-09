import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazaaf/components/components.dart';
import 'package:wazaaf/modules/news/cubit/cubit.dart';
import 'package:wazaaf/modules/news/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child : FormField(builder: (context) {
                  return TextFormField(
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                  );
                },
                ),
              ),
              Expanded(child: ArticleBuilder(list, context)),
            ],
          ),
        );
      },
        );
  }
}
