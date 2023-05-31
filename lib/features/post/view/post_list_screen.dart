import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_architecture/features/post/bloc/post_cubit.dart';
import 'package:study_architecture/features/post/bloc/post_state.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late final PostCubit _postCubit;

  @override
  void initState() {
    super.initState();

    _postCubit = PostCubit();

    Future(_postCubit.fetchPostList);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _postCubit.fetchPostList();
      },
      child: Scaffold(
        body: BlocBuilder<PostCubit, PostState>(
          bloc: _postCubit,
          builder: (context, state) {
            if (state is PostSuccessState) {
              final items = state.postList;

              return ListView.builder(
                itemBuilder: (context, index) => Text(items[index].title),
                itemCount: items.length,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
