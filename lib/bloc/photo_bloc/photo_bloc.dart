import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_app/models/photo_data.dart';

import '../../repository/data_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<FetchPhoto>((event, emit) async {
      emit(PhotoLoading());
      try {
        final roseData = await DataRepository().fetchData('rose');
        final dogData = await DataRepository().fetchData('dogs');
        final tortoiseData = await DataRepository().fetchData('tortoise');
        emit(
          PhotoLoaded(
            plantData: roseData!,
            animalData: dogData!,
            birdData: tortoiseData!,
          ),
        );
      } catch (e) {
        emit(PhotoError(message: e.toString()));
      }
    });
    on<SearchPhoto>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photoData = await DataRepository().fetchData(event.query);
        print(photoData!.photos![0]?.photographer);
        emit(
          SearchPhotoLoaded(
            photoData: photoData!,
          ),
        );
      } catch (e) {
        emit(PhotoError(message: e.toString()));
      }
    });
  }
}
