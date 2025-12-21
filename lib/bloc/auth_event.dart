abstract class AuthEvent {}

class WeightChanged extends AuthEvent {
  final String weight;
  WeightChanged(this.weight);
}

class Feetchanged extends AuthEvent {
  final String feet;
  Feetchanged(this.feet);
}

class Inchchanged extends AuthEvent {
  final String inch;
  Inchchanged(this.inch);
}

class CalculateBmi extends AuthEvent {}

class ResetBmi extends AuthEvent {}
