import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthFormState()) {
    on<WeightChanged>(_onWeightChanged);
    on<Feetchanged>(_onFeetChanged);
    on<Inchchanged>(_onInchChanged);
    on<CalculateBmi>(_onCalculateBmi);
    on<ResetBmi>(_onResetBmi);
  }

  void _onWeightChanged(WeightChanged event, Emitter<AuthState> emit) {
    final currentState = state is AuthFormState
        ? state as AuthFormState
        : AuthFormState();
    final isValid =
        event.weight.isNotEmpty &&
        double.tryParse(event.weight) != null &&
        double.parse(event.weight) > 0;

    emit(
      currentState.copyWith(
        weight: event.weight,
        isweightvalid: isValid,
        isSuccess: false, // Reset success state when input changes
      ),
    );
  }

  void _onFeetChanged(Feetchanged event, Emitter<AuthState> emit) {
    final currentState = state is AuthFormState
        ? state as AuthFormState
        : AuthFormState();
    final isValid =
        event.feet.isNotEmpty &&
        int.tryParse(event.feet) != null &&
        int.parse(event.feet) > 0;

    emit(
      currentState.copyWith(
        feet: event.feet,
        isfeetvalid: isValid,
        isSuccess: false, // Reset success state when input changes
      ),
    );
  }

  void _onInchChanged(Inchchanged event, Emitter<AuthState> emit) {
    final currentState = state is AuthFormState
        ? state as AuthFormState
        : AuthFormState();
    final isValid =
        event.inch.isNotEmpty &&
        int.tryParse(event.inch) != null &&
        int.parse(event.inch) >= 0 &&
        int.parse(event.inch) < 12;

    emit(
      currentState.copyWith(
        inch: event.inch,
        isinchvalid: isValid,
        isSuccess: false, // Reset success state when input changes
      ),
    );
  }

  void _onCalculateBmi(CalculateBmi event, Emitter<AuthState> emit) {
    final currentState = state is AuthFormState
        ? state as AuthFormState
        : AuthFormState();

    // Validate all fields are filled and valid
    if (!currentState.isweightvalid ||
        !currentState.isfeetvalid ||
        !currentState.isinchvalid ||
        currentState.weight.isEmpty ||
        currentState.feet.isEmpty ||
        currentState.inch.isEmpty) {
      emit(
        currentState.copyWith(
          errorMessage: "Please enter valid inputs for all fields",
          isSuccess: false,
        ),
      );
      return;
    }

    // Show loading state
    emit(
      currentState.copyWith(
        isSubmitting: true,
        errorMessage: '',
        isSuccess: false,
      ),
    );

    try {
      final weight = double.parse(currentState.weight);
      final feet = int.parse(currentState.feet);
      final inch = int.parse(currentState.inch);

      // Convert height to meters
      final heightInInches = (feet * 12) + inch;
      final heightInMeters = heightInInches * 0.0254;

      // Calculate BMI
      final bmi = weight / (heightInMeters * heightInMeters);

      // Debug print to verify calculation
      print('Weight: $weight kg');
      print(
        'Height: $feet ft $inch in = $heightInInches inches = ${heightInMeters.toStringAsFixed(2)} meters',
      );
      print('BMI: ${bmi.toStringAsFixed(2)}');

      // Emit success state with calculated BMI
      emit(
        currentState.copyWith(
          isSubmitting: false,
          isSuccess: true,
          bmi: bmi,
          errorMessage: '',
        ),
      );
    } catch (e) {
      print('Error calculating BMI: $e');
      emit(
        currentState.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: "Error in calculation: ${e.toString()}",
          bmi: 0.0,
        ),
      );
    }
  }

  void _onResetBmi(ResetBmi event, Emitter<AuthState> emit) {
    emit(AuthFormState());
  }
}
