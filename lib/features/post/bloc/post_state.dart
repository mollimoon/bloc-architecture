import 'package:equatable/equatable.dart';
import 'package:study_architecture/data/post.dart';

class PostState {}

class PostLoadingState extends PostState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class PostSuccessState extends PostState with EquatableMixin {
  final List<Post> postList;
  PostSuccessState({required this.postList});

  @override
  List<Object?> get props => [postList];
}

class PostErrorState extends PostState with EquatableMixin {
  final String errorText;
  PostErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}
