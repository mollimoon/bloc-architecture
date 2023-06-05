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
        backgroundColor: Colors.blue[50],
        body: 
            BlocBuilder<PostCubit, PostState>(
              bloc: _postCubit,
              builder: (context, state) {
                if (state is PostSuccessState) {
                  final items = state.postList;

                  return ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black,
                        child: ListTile(
                          title: Text(items[index].title),
                          contentPadding: const EdgeInsets.all(10),
                          tileColor: Colors.white38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    itemCount: items.length,
                  );
                }
                if (state is PostErrorState) {
                  return const Text('Something is wrong. Try again');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),

      ),
    );
  }
}
