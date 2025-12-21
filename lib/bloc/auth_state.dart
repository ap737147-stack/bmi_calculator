abstract class AuthState {}

class Authinitial extends AuthState {}

class AuthFormState extends AuthState {
  final String weight;
  final String feet;
  final String inch;
  final bool isweightvalid;
  final bool isfeetvalid;
  final bool isinchvalid;
  final bool isSubmitting;
  final bool isSuccess;
  final double bmi;
  final String errorMessage;

  AuthFormState({
    this.weight = '',
    this.feet = '',
    this.inch = '',
    this.isweightvalid = false,
    this.isfeetvalid = false,
    this.isinchvalid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.bmi = 0.0,
    this.errorMessage = '',
  });

  AuthFormState copyWith({
    String? weight,
    String? feet,
    String? inch,
    bool? isweightvalid,
    bool? isfeetvalid,
    bool? isinchvalid,
    bool? isSubmitting,
    bool? isSuccess,
    double? bmi,
    String? errorMessage,
  }) {
    return AuthFormState(
      weight: weight ?? this.weight,
      feet: feet ?? this.feet,
      inch: inch ?? this.inch,
      isweightvalid: isweightvalid ?? this.isweightvalid,
      isfeetvalid: isfeetvalid ?? this.isfeetvalid,
      isinchvalid: isinchvalid ?? this.isinchvalid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      bmi: bmi ?? this.bmi,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'AuthFormState(weight: $weight, feet: $feet, inch: $inch, '
        'isweightvalid: $isweightvalid, isfeetvalid: $isfeetvalid, '
        'isinchvalid: $isinchvalid, isSubmitting: $isSubmitting, '
        'isSuccess: $isSuccess, bmi: $bmi, errorMessage: $errorMessage)';
  }
}
