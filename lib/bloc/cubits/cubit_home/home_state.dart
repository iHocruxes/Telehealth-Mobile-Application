part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    required this.doctors,
  });
  final List<TopDoctorsResponse> doctors;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'doctors': doctors.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      doctors: List<TopDoctorsResponse>.from(
          map['doctors']?.map((x) => TopDoctorsResponse.fromMap(x))),
    );
  }
}

class HomeInital extends HomeState {
  HomeInital({required super.doctors});
}

class HomeLoading extends HomeState {
  HomeLoading({required super.doctors});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message, required super.doctors});
}