import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

import '../models/profile.dart';
import '../widgets/info_card.dart';
import '../widgets/skill_chip.dart'; 
import '../widgets/hobby_card.dart'; 
import '../widgets/blinking_status.dart'; 
import '../cubit/profil_cubit.dart'; 

class ProfilPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ProfilPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutQuart),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, 
      );
      
      if (!launched) {
        debugPrint('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  void _showProfilePictureFullscreen(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Hero(
              tag: 'profile_photo_hero',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 200, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 20.0, left: 20.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildSocialIconBtn(IconData icon, Color color, VoidCallback onTap, {Color? borderColor}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardTheme.color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: (borderColor ?? color).withOpacity(0.5), 
            width: 1.5
          ),
        ),
        child: FaIcon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildFlexibleHeader(BuildContext context, Profile profile) {
    final theme = Theme.of(context);

    return FlexibleSpaceBar(
      centerTitle: true,
      titlePadding: EdgeInsets.zero,
      background: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.9),
                  theme.colorScheme.primary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
                color: Colors.white,
                size: 30,
              ),
              onPressed: widget.toggleTheme,
            ),
          ),

          Positioned(
            top: 70, 
            child: Column(
              children: [
                Text(
                  profile.nama,
                  style: GoogleFonts.montserrat(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.nim} | ${profile.jurusan}',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 90,
            child: GestureDetector(
              onTap: () => _showProfilePictureFullscreen(context, 'assets/images/Healing2.jpg'),
              child: Hero(
                tag: 'profile_photo_hero',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.scaffoldBackgroundColor,
                      width: 6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/Healing2.jpg',
                      fit: BoxFit.cover,
                      width: 140,
                      height: 140,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 45,
            child: BlinkingStatus(
              statusText: profile.statusDisplay,
              statusColor: profile.status == StatusMahasiswa.aktif
                  ? Colors.green.shade600
                  : Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Profile profile) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIconBtn(
                  FontAwesomeIcons.github,
                  widget.isDarkMode ? Colors.white : Colors.black87,
                  () => _launchURL(profile.githubUrl),
                ),
                
                const SizedBox(width: 25), 

                _buildSocialIconBtn(
                  FontAwesomeIcons.instagram,
                  const Color.fromARGB(255, 226, 53, 111),
                  () => _launchURL(profile.instagramUrl),
                  borderColor: widget.isDarkMode ? Colors.white : null,
                ),
              ],
            ),
          ),

          _buildSectionTitle(context, 'Detail Kontak'),
          
          InfoCard(
            icon: Icons.email_rounded,
            text: profile.email,
            onTap: () => _launchURL('mailto:${profile.email}'),
          ),
          
          InfoCard(
            icon: FontAwesomeIcons.whatsapp,
            text: profile.telepon,
            onTap: () {
              final cleanNumber = profile.telepon.replaceAll(RegExp(r'\D'), '');
              _launchURL('https://wa.me/$cleanNumber');
            },
          ),

          _buildSectionTitle(context, 'Hobi & Minat'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profile.hobi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                return HobbyCard(hobby: profile.hobi[index]);
              },
            ),
          ),

          _buildSectionTitle(context, 'Keahlian (Skills)'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: profile.skill.map((skill) => SkillChip(skill: skill)).toList(),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        
        if (profile.nama.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 420.0,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: ClipPath(
                  clipper: HeaderClipper(),
                  child: _buildFlexibleHeader(context, profile),
                ),
                elevation: 0,
              ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildContent(context, profile),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height,
        size.width, size.height - 50
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}