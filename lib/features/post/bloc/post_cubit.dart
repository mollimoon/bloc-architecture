import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:study_architecture/data/post_repository.dart';
import 'package:study_architecture/features/post/bloc/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState());

  final _postRepository = PostRepository(dio: Dio());

  Future<void> fetchPostList() async {
    emit(PostLoadingState());

    try {
      final postList = await _postRepository.getPosts();

      emit(PostSuccessState(postList: postList));
    } catch (e) {
      emit(PostErrorState(errorText: e.toString()));
    }
  }
}
