part of 'my_ubication_bloc.dart';

@immutable

class MyUbicationState {
  final bool following ;
  final bool existsUbication ;
  final LatLng? ubication ;

  MyUbicationState({this.ubication, this.following = true, this.existsUbication= false});

  MyUbicationState copyWith({
    bool? following,
    bool? existsUbication,
    LatLng? ubication,
  }) => new MyUbicationState(
    following: following ?? this.following,
    existsUbication: existsUbication ?? this.existsUbication,
    ubication: ubication ?? this.ubication,
  );

}
