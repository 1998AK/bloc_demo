import 'package:bloc/bloc.dart';
import 'package:bloc_demo/bloc/bottom_navigation_bar/bottom_navigation_bar_events.dart';
import 'package:bloc_demo/bloc/bottom_navigation_bar/bottom_navigation_bar_states.dart';

class BottomNavigationBarBloc extends Bloc<BottomNavigationBarEvents,BottomNavigationBarStates>{
  BottomNavigationBarBloc():super(BottomNavigationIndexChange()){
    on<OnTapBottom>((event,emit){
      emit(BottomNavigationIndexChange(index: event.getIndexFromUi));
    });
  }
}