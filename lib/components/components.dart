import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:wazaaf/modules/to_do/cubit/cubit.dart';
import 'package:wazaaf/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  required double width,
  required Color background,
  required Function function,
  required String text,
  })=> Container(
    width: width,
    color: background,
       child: MaterialButton(
        onPressed: function(),
          child: Text(
           text.toUpperCase(),
              style: const TextStyle(
           color: Colors.white,
      ),
    ),
  ),
);


Widget defaultFormField({
  Function? onSubmit,
  Function? onChange,
  Function? validate,
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
})=>TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmit!(),
    onChanged: onChange!(),
    validator: validate!(),
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
  ),
);


Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 45.0,
          child: Text(
            '${model['time']}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0,),
              Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20.0,),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id']);
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            )),
        const SizedBox(width: 20.0,),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id']);
            },
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.black45,
            )),
      ],
    ),
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
  );

Widget buildArticleItem(article,context)=> InkWell(
  child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  '${article['urlToImage']}',),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
),
  onTap: (){
    navigateTo(context,WebViewScreen());
  },
);

Widget ArticleBuilder(list,context)=>ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
    itemBuilder:(context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>const SizedBox(
      height: 10.0,
    ),
    itemCount: 10,
    physics: const BouncingScrollPhysics(),
  ),
  fallback: (context)=>const Center(child: CircularProgressIndicator(),
  ),
);

void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
);