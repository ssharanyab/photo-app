part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
}

class PhotoInitial extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoading extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoaded extends PhotoState {
  final PhotosData plantData;
  final PhotosData animalData;
  final PhotosData birdData;

  const PhotoLoaded(
      {required this.plantData,
      required this.animalData,
      required this.birdData});

  @override
  List<Object> get props => [plantData, animalData, birdData];
}

class SearchPhotoLoaded extends PhotoState {
  final PhotosData photoData;

  const SearchPhotoLoaded({required this.photoData});

  @override
  List<Object> get props => [photoData];
}

class PhotoError extends PhotoState {
  final String message;

  const PhotoError({required this.message});

  @override
  List<Object> get props => [message];
}
