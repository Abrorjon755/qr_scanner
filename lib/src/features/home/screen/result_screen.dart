import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/router/app_router.dart';
import '../../../common/utils/context_extension.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});

  final String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go(AppRouter.home),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result,
              style: context.textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 30),
            Row(
              spacing: 20,
              children: [
                IconButton(
                  onPressed: () async {
                    final Uri searchUrl =
                        Uri.parse('https://www.google.com/search?q=$result');

                    await launchUrl(searchUrl,
                        mode: LaunchMode.externalApplication);
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: result));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 30,
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () => Share.share(result),
                  icon: const Icon(
                    Icons.share,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
