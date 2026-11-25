import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/skill.dart';
import 'package:myportofolio_mobile/screens/skill_detail_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class SkillListScreen extends StatefulWidget {
  const SkillListScreen({super.key});

  @override
  State<SkillListScreen> createState() => _SkillListScreenState();
}

class _SkillListScreenState extends State<SkillListScreen> {
  late Future<List<Skill>> _skillsFuture;

  @override
  void initState() {
    super.initState();
    _skillsFuture = context.read<ApiClient>().getSkills();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getSkills();

    setState(() {
      _skillsFuture = future;
    });

    // FutureBuilder displays any error; catching here also prevents an
    // unhandled async error from the Retry button or RefreshIndicator.
    try {
      await future;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Skill>>(
        future: _skillsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load skills: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final skills = snapshot.data ?? const <Skill>[];

          if (skills.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 300,
                    child: Center(child: Text('No skills found.')),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(skill.title),
                    subtitle: Text(
                      '${skill.category} · ${skill.endorseCount} endorsements',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final wasDeleted = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute<bool>(
                          builder: (_) => SkillDetailScreen(skill: skill),
                        ),
                      );

                      if (wasDeleted == true && mounted) {
                        await _reload();
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
