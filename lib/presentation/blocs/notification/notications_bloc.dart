import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notications_event.dart';
part 'notications_state.dart';

class NoticationsBloc extends Bloc<NoticationsEvent, NoticationsState> {
  NoticationsBloc() : super(const NoticationsState()) {
    // on<NoticationsEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }
}
