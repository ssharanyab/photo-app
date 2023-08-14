part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();
}

class FetchPhoto extends PhotoEvent {
  @override
  List<Object> get props => [];
}

class SearchPhoto extends PhotoEvent {
  final String query;

  const SearchPhoto({required this.query});

  @override
  List<Object> get props => [query];
}
