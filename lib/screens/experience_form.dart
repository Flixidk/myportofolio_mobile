import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_guard.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _category = 'full-time';
  DateTime? _startedAt;
  DateTime? _endedAt;
  bool _isSubmitting = false;

  final List<MapEntry<String, String>> _categories = const [
    MapEntry('internship', 'Internship'),
    MapEntry('research', 'Research'),
    MapEntry('volunteer', 'Volunteer'),
    MapEntry('part-time', 'Part-Time'),
    MapEntry('full-time', 'Full-Time'),
    MapEntry('freelance', 'Freelance'),
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate({required bool isStart}) async {
    final current = isStart ? _startedAt : _endedAt;
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked == null) return;
    setState(() {
      if (isStart) {
        _startedAt = picked;
      } else {
        _endedAt = picked;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isSubmitting = true);
    try {
      final newExperience = Experience(
        title: _title.trim(),
        description: _description.trim(),
        category: _category,
        startedAt: _startedAt!,
        endedAt: _endedAt,
      );

      await context.read<ApiClient>().createExperience(
        newExperience,
        token: token,
      );

      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Experience added successfully!'),
          content: const Text('Your experience has been saved.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        try {
          await context.read<AuthState>().logout();
        } on ApiException {
          // AuthState clears the local token even if the logout request fails.
        }
        if (!mounted) return;

        final shouldLogin = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Please log in again'),
            content: const Text('Your session expired. Log in to continue.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Later'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Log in'),
              ),
            ],
          ),
        );
        if (shouldLogin == true && mounted) {
          await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not save experience (${error.statusCode}): ${error.message}',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save experience: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Experience'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _title = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter an experience title.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _description = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter an experience description.'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category.key,
                        child: Text(category.value),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _category = value);
                },
              ),
              const SizedBox(height: 12),
              FormField<DateTime>(
                validator: (_) =>
                    _startedAt == null ? 'Please select a start date.' : null,
                builder: (field) => InkWell(
                  onTap: () async {
                    await _selectDate(isStart: true);
                    field.didChange(_startedAt);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Started at',
                      border: const OutlineInputBorder(),
                      errorText: field.errorText,
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(_formatDate(_startedAt)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FormField<DateTime>(
                validator: (_) =>
                    _endedAt == null ? 'Please select an end date.' : null,
                builder: (field) => InkWell(
                  onTap: () async {
                    await _selectDate(isStart: false);
                    field.didChange(_endedAt);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Ended at',
                      border: const OutlineInputBorder(),
                      errorText: field.errorText,
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(_formatDate(_endedAt)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
