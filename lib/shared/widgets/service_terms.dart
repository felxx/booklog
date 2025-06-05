// lib/shared/widgets/terms_of_service_text_widget.dart
import 'package:flutter/material.dart';

class ServiceTermsWidget extends StatelessWidget {
  const ServiceTermsWidget({
    super.key,
    this.fontSize = 20.0,
    this.height = 1.4,
  });

  final double fontSize;
  final double height;

  final String _termsOfServiceText = '''
1. Acceptance of Terms
By downloading, installing, accessing, or using the Booklog application, you acknowledge that you have read, understood, and agree to be bound by these Terms, as well as our Privacy Policy. These Terms apply to all users of the application, including, without limitation, users who are browsers, vendors, customers, merchants, and/or content contributors.

2. Use of the Application
Eligibility: You must be at least 13 years old to use Booklog. By using the application, you represent and warrant that you are at least 13 years old.
User Account: Some functionalities of Booklog may require account registration. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.
User Conduct: You agree to use Booklog only for lawful purposes and in accordance with these Terms. 
You agree not to:
Use Booklog in any way that violates any applicable law or regulation.
Engage in any conduct that restricts or inhibits anyone's use or enjoyment of Booklog.
Attempt to interfere with the proper working of Booklog.

3. Intellectual Property
All content and materials available on Booklog, including, but not limited to, text, graphics, logos, icons, images, audio clips, digital downloads, and software, are the property of the Booklog developer or its licensors and are protected by copyright, trademark, and other intellectual property laws.

4. Privacy
Your use of Booklog is also governed by our Privacy Policy, which is incorporated into these Terms by this reference. By using Booklog, you consent to the data collection and use practices described in our Privacy Policy.

5. Limitation of Liability
Booklog is provided "as is" and "as available," without warranties of any kind, either express or implied. The Booklog developer does not warrant that the application will be uninterrupted, error-free, or secure. In no event shall the Booklog developer be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of or inability to use Booklog.

6. Changes to the Terms
We reserve the right to modify or replace these Terms at any time. Any changes will become effective immediately upon posting the revised Terms on the application. Your continued use of Booklog after the posting of any changes constitutes your acceptance of those changes.

7. Termination
We may terminate or suspend your access to Booklog immediately, without prior notice or liability, for any reason whatsoever, including, without limitation, if you breach these Terms.

8. Governing Law
These Terms shall be governed and construed in accordance with the laws of Brazil, without regard to its conflict of law principles.

9. Contact
If you have any questions about these Terms, please contact us through the application's support channel.


Effective Date: June 5, 2025
''';

  @override
  Widget build(BuildContext context) {
    return Text(
      _termsOfServiceText,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: fontSize,
        height: height,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }
}
