import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator>
    with SingleTickerProviderStateMixin {
  final weightController = TextEditingController();
  final feetController = TextEditingController();
  final inchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    weightController.dispose();
    feetController.dispose();
    inchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.purple.shade300,
              Colors.pink.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFormState && state.isSuccess) {
                          _animationController.forward(from: 0);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'BMI calculated successfully!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: const EdgeInsets.all(16),
                              duration: const Duration(seconds: 2),
                              elevation: 6,
                            ),
                          );
                        }
                        if (state is AuthFormState &&
                            state.errorMessage.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      state.errorMessage,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.red.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: const EdgeInsets.all(16),
                              duration: const Duration(seconds: 2),
                              elevation: 6,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final formState = state is AuthFormState
                            ? state
                            : AuthFormState();

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Calculate Your BMI',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3142),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enter your details below',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              _buildTextField(
                                controller: weightController,
                                label: 'Weight (kg)',
                                hint: 'Enter your weight',
                                icon: Icons.monitor_weight_rounded,
                                isValid: formState.isweightvalid,
                                isEmpty: formState.weight.isEmpty,
                                errorText: 'Enter valid weight',
                                iconColor: Colors.blue.shade600,
                                onChanged: (value) {
                                  context.read<AuthBloc>().add(
                                    WeightChanged(value),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: feetController,
                                label: 'Height (feet)',
                                hint: 'Enter feet',
                                icon: Icons.straighten_rounded,
                                isValid: formState.isfeetvalid,
                                isEmpty: formState.feet.isEmpty,
                                errorText: 'Enter valid feet',
                                iconColor: Colors.purple.shade600,
                                onChanged: (value) {
                                  context.read<AuthBloc>().add(
                                    Feetchanged(value),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: inchController,
                                label: 'Height (inches)',
                                hint: 'Enter inches (0-11)',
                                icon: Icons.height_rounded,
                                isValid: formState.isinchvalid,
                                isEmpty: formState.inch.isEmpty,
                                errorText: 'Enter valid inches (0-11)',
                                iconColor: Colors.pink.shade600,
                                onChanged: (value) {
                                  context.read<AuthBloc>().add(
                                    Inchchanged(value),
                                  );
                                },
                              ),
                              const SizedBox(height: 32),
                              _buildCalculateButton(formState, context),
                              const SizedBox(height: 32),
                              if (formState.isSuccess)
                                FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: _buildBMIResult(formState),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'BMI Calculator',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(ResetBmi());
                weightController.clear();
                feetController.clear();
                inchController.clear();
                _animationController.reset();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isValid,
    required bool isEmpty,
    required String errorText,
    required Color iconColor,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2D3142),
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          suffixIcon: !isEmpty
              ? Icon(
                  isValid ? Icons.check_circle : Icons.cancel,
                  color: isValid ? Colors.green.shade600 : Colors.red.shade600,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isEmpty
                  ? Colors.grey.shade200
                  : (isValid ? Colors.green.shade300 : Colors.red.shade300),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: iconColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red.shade600, width: 2),
          ),
          errorText: !isEmpty && !isValid ? errorText : null,
          errorStyle: TextStyle(
            fontSize: 13,
            color: Colors.red.shade700,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton(AuthFormState formState, BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade400.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: formState.isSubmitting
            ? null
            : () {
                context.read<AuthBloc>().add(CalculateBmi());
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: formState.isSubmitting
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Calculating...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calculate_rounded, size: 24, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'Calculate BMI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBMIResult(AuthFormState formState) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getBMIColor(formState.bmi).withOpacity(0.1),
            _getBMIColor(formState.bmi).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _getBMIColor(formState.bmi).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _getBMIColor(formState.bmi).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getBMIColor(formState.bmi).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getBMIIcon(formState.bmi),
              size: 40,
              color: _getBMIColor(formState.bmi),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your BMI',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formState.bmi.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: _getBMIColor(formState.bmi),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: _getBMIColor(formState.bmi),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _getBMIColor(formState.bmi).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              _getBMICategory(formState.bmi),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _getBMIDescription(formState.bmi),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal Weight";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue.shade600;
    if (bmi < 25) return Colors.green.shade600;
    if (bmi < 30) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  IconData _getBMIIcon(double bmi) {
    if (bmi < 18.5) return Icons.arrow_downward_rounded;
    if (bmi < 25) return Icons.favorite_rounded;
    if (bmi < 30) return Icons.warning_rounded;
    return Icons.priority_high_rounded;
  }

  String _getBMIDescription(double bmi) {
    if (bmi < 18.5)
      return "You may need to gain weight. Consider consulting a healthcare provider for personalized advice.";
    if (bmi < 25)
      return "Excellent! You have a healthy weight for your height. Keep up the good work!";
    if (bmi < 30)
      return "You may want to consider losing weight for better health. Regular exercise and a balanced diet can help.";
    return "Consider consulting a healthcare provider about weight management options for your health.";
  }
}
