import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/skill.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_guard.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class SkillDetailScreen extends StatefulWidget {
  const SkillDetailScreen({required this.skill, super.key});

  final Skill skill;

  @override
  State<SkillDetailScreen> createState() => _SkillDetailScreenState();
}

class _SkillDetailScreenState extends State<SkillDetailScreen> {
  bool _isDeleting = false;

  String get _categoryLabel {
    const labels = {
      'frontend': 'Frontend',
      'backend': 'Backend',
      'database': 'Database',
      'tools': 'Dev Tools',
    };

    return labels[widget.skill.category] ?? widget.skill.category;
  }

  Future<void> _deleteSkill() async {
    final skillId = widget.skill.id;
    if (skillId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This skill has no ID and cannot be deleted.'),
        ),
      );
      return;
    }

    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete skill?'),
        content: Text('Delete "${widget.skill.title}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isDeleting = true);

    try {
      await context.read<ApiClient>().deleteSkill(skillId, token: token);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Skill deleted.')));
      Navigator.pop(context, true);
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        try {
          await context.read<AuthState>().logout();
        } on ApiException {
          // AuthState clears the local token even if logout fails.
        }
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your session expired. Please log in again.'),
          ),
        );
        await Navigator.push<bool>(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else if (error.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You do not have permission to delete this skill.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not delete skill (${error.statusCode}): ${error.message}',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not delete skill: $error')));
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.skill.title),
        actions: [
          IconButton(
            tooltip: 'Delete skill',
            onPressed: _isDeleting ? null : _deleteSkill,
            icon: _isDeleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (widget.skill.iconPath.isNotEmpty)
            Center(
              child: SizedBox(
                width: 96,
                height: 96,
                child: SvgPicture.network(
                  widget.skill.iconPath,
                  semanticsLabel: '${widget.skill.title} icon',
                  placeholderBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Chip(label: Text(_categoryLabel)),
          ),
          const SizedBox(height: 8),
          Text(
            widget.skill.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (widget.skill.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(widget.skill.description),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.thumb_up_outlined),
              const SizedBox(width: 8),
              Text('${widget.skill.endorseCount} endorsements'),
            ],
          ),
          if (widget.skill.isEndorsed) ...[
            const SizedBox(height: 8),
            const Text('You endorsed this skill.'),
          ],
          if (widget.skill.endorsedByNames.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Endorsed by ${widget.skill.endorsedByNames}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
