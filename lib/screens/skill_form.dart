import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/skill.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/skill_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_guard.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class SkillFormPage extends StatefulWidget {
  const SkillFormPage({super.key});

  @override
  State<SkillFormPage> createState() => _SkillFormPageState();
}

class _SkillFormPageState extends State<SkillFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _category = 'tools';
  String _description = '';
  String _iconPath = '';
  bool _isSubmitting = false;

  static const _categories = <MapEntry<String, String>>[
    MapEntry('frontend', 'Frontend'),
    MapEntry('backend', 'Backend'),
    MapEntry('database', 'Database'),
    MapEntry('tools', 'Dev Tools'),
  ];

  Future<void> _handleExpiredSession() async {
    try {
      await context.read<AuthState>().logout();
    } on ApiException {
      // AuthState clears the local token even if the logout request fails.
    }
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your session expired. Please log in again.')),
    );

    await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isSubmitting = true);

    try {
      final skill = Skill(
        title: _title.trim(),
        description: _description.trim(),
        category: _category,
        iconPath: _iconPath.trim(),
      );

      await context.read<ApiClient>().createSkill(skill, token: token);
      if (!mounted) return;

      final shouldViewList = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Skill added successfully'),
          content: const Text('Your skill has been saved.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Stay here'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('View skills'),
            ),
          ],
        ),
      );

      if (shouldViewList == true && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SkillListScreen()),
        );
      }
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        await _handleExpiredSession();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not save skill (${error.statusCode}): ${error.message}',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save skill: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Skill'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _title = value,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Please enter a skill title.'
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
            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _description = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Icon path',
                hintText: 'https://.../icon.svg',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _iconPath = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an icon URL.';
                }

                final uri = Uri.tryParse(value.trim());
                if (uri == null ||
                    !uri.hasScheme ||
                    !{'http', 'https'}.contains(uri.scheme) ||
                    uri.host.isEmpty) {
                  return 'Enter a valid http or https URL.';
                }
                return null;
              },
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
    );
  }
}