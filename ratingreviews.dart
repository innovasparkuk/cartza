import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingReviewsPage extends StatefulWidget{
  @override
  State<RatingReviewsPage> createState() => _RatingReviewsPageState();
}

  class _RatingReviewsPageState extends State<RatingReviewsPage> {
  double _overallRating = 4.8;
  final List<Review> _reviews = [
    Review(
      userName: 'Alex Johnson',
      rating: 5,
      date: '2 days ago',
      comment: 'This product exceeded my expectations! The quality is outstanding and it arrived sooner than expected.',
      likes: 12,
      userImage: '👨🏼',
    ),
    Review(
      userName: 'Sarah Miller',
      rating: 4,
      date: '1 week ago',
      comment: 'Pretty good overall, but I think the price could be more competitive compared to similar products.',
      likes: 8,
      userImage: '👩🏽',
    ),
    Review(
      userName: 'Michael Chen',
      rating: 5,
      date: '3 days ago',
      comment: 'Absolutely love it! Would definitely recommend to friends and family. Five stars!',
      likes: 15,
      userImage: '👨🏻',
    ),
    Review(
      userName: 'Emma Wilson',
      rating: 3,
      date: '2 weeks ago',
      comment: 'It\'s okay, but not as durable as I had hoped. Started showing wear after just a few uses.',
      likes: 3,
      userImage: '👩🏻',
    ),
    Review(
      userName: 'David Kim',
      rating: 5,
      date: '5 days ago',
      comment: 'Exceptional quality and customer service. Will purchase from this brand again!',
      likes: 10,
      userImage: '👨🏽',
    ),
  ];

  final List<int> _ratingDistribution = [5, 15, 8, 3, 2]; // 5-star to 1-star counts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            left: 35
          ),
          child: Text("Ratings and Reviews", style: TextStyle(fontSize: 18),),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall rating section
            _buildOverallRating(),
            const SizedBox(height: 24),

            // Rating distribution
            _buildRatingDistribution(),
            const SizedBox(height: 10),

            // Write review button
            _buildWriteReviewButton(),
            const SizedBox(height: 15),

            // Reviews list
            _buildReviewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              _overallRating.toString(),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            RatingBarIndicator(
              rating: _overallRating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20,
              direction: Axis.horizontal,
            ),
            const SizedBox(height: 4),
            Text(
              '${_reviews.length} reviews',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            children: [
              for (int i = 5; i >= 1; i--)
                _buildRatingBar(i, _ratingDistribution[i-1]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(int rating, int count) {
    final totalRatings = _ratingDistribution.reduce((a, b) => a + b);
    final percentage = totalRatings > 0 ? count / totalRatings : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$rating',
            style: const TextStyle(fontSize: 14),
          ),
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
            //  value: percentage,
              backgroundColor: Colors.grey[200],
              color: Colors.amber,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating Distribution',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        // This would be implemented with a chart library in a real app
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Rating chart visualization would appear here',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWriteReviewButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Show review dialog
          _showReviewDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Write a Review',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Reviews',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _reviews.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildReviewCard(_reviews[index]);
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  child: Text(review.userImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        review.date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 16,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: const TextStyle(
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      review.isLiked = !review.isLiked;
                      if (review.isLiked) {
                        review.likes++;
                      } else {
                        review.likes--;
                      }
                    });
                  },
                  icon: Icon(
                    review.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: review.isLiked ? Colors.blue : Colors.grey,
                    size: 18,
                  ),
                ),
                Text(
                  '${review.likes}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Reply',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewDialog() {
    double userRating = 5;
    String userComment = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Write a Review'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text('How would you rate this product?'),
                const SizedBox(height: 16),
                Center(
                  child: RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Share your experience...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    userComment = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (userComment.isNotEmpty) {
                  setState(() {
                    _reviews.insert(0, Review(
                      userName: 'You',
                      rating: userRating.round(),
                      date: 'Just now',
                      comment: userComment,
                      likes: 0,
                      userImage: '😊',
                    ));
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Review submitted successfully!'))
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class Review {
  final String userName;
  final int rating;
  final String date;
  final String comment;
  int likes;
  bool isLiked;
  final String userImage;

  Review({
  required this.userName,
  required this.rating,
  required this.date,
  required this.comment,
  required this.likes,
  required this.userImage,
  this.isLiked =false,
  });
}
