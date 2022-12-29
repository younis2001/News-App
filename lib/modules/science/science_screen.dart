
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/news_app/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list =NewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: list.length>0,
          builder: (context) => ListView.separated(
              physics:BouncingScrollPhysics(),//عشان الظل
              itemBuilder: (context, index) => buildArticleItem(list[index],context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: 9),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
