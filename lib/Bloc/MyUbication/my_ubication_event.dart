part of 'my_ubication_bloc.dart';

@immutable
abstract class MyUbicationEvent {}

class onChangeUbication extends MyUbicationEvent {
  final LatLng ubication;

  onChangeUbication(this.ubication);
}