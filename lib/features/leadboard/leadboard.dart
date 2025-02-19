import 'package:flutter/material.dart';

class LeadboardScreen extends StatelessWidget {
  const LeadboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
      itemBuilder: (context, index) => LeaderboardCard(
        username: leaderboardData[index]['username'],
        email: leaderboardData[index]['email'],
        rank: leaderboardData[index]['rank'],
        score: leaderboardData[index]['score'],
        level: leaderboardData[index]['level'],
        position: leaderboardData[index]['position'],
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: leaderboardData.length,
    );
  }
}

class LeaderboardCard extends StatelessWidget {
  final String username;
  final String email;
  final String rank;
  final int score;
  final String level;
  final int position;

  const LeaderboardCard({
    super.key,
    required this.username,
    required this.email,
    required this.rank,
    required this.score,
    required this.level,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2), // Space for gradient border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Position Number (Rank)
            Text(
              "#$position",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(width: 16),

            // User Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Email
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Score & Level
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Score
                Text(
                  "Score: $score",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ), // Level Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
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

final List<Map<String, dynamic>> leaderboardData = [
  {
    "username": "PlayerOne",
    "email": "player1@example.com",
    "rank": "Diamond",
    "score": 2500,
    "level": "Expert",
    "position": 1
  },
  {
    "username": "ShadowKnight",
    "email": "shadow@example.com",
    "rank": "Platinum",
    "score": 2200,
    "level": "Advanced",
    "position": 2
  },
  {
    "username": "NightHawk",
    "email": "hawk@example.com",
    "rank": "Gold",
    "score": 2000,
    "level": "Advanced",
    "position": 3
  },
  {
    "username": "CyberNinja",
    "email": "ninja@example.com",
    "rank": "Gold",
    "score": 1800,
    "level": "Intermediate",
    "position": 4
  },
  {
    "username": "BlazeMaster",
    "email": "blaze@example.com",
    "rank": "Silver",
    "score": 1600,
    "level": "Intermediate",
    "position": 5
  },
  {
    "username": "StealthPro",
    "email": "stealth@example.com",
    "rank": "Silver",
    "score": 1400,
    "level": "Intermediate",
    "position": 6
  },
  {
    "username": "DarkPhantom",
    "email": "phantom@example.com",
    "rank": "Bronze",
    "score": 1200,
    "level": "Beginner",
    "position": 7
  },
  {
    "username": "IronFist",
    "email": "iron@example.com",
    "rank": "Bronze",
    "score": 1000,
    "level": "Beginner",
    "position": 8
  },
  {
    "username": "StormBreaker",
    "email": "storm@example.com",
    "rank": "Bronze",
    "score": 800,
    "level": "Beginner",
    "position": 9
  },
  {
    "username": "EchoSniper",
    "email": "echo@example.com",
    "rank": "Bronze",
    "score": 600,
    "level": "Beginner",
    "position": 10
  },
];
