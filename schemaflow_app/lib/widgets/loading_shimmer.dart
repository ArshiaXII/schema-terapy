import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer loading effect for cards
class ShimmerCard extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const ShimmerCard({
    Key? key,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Shimmer loading effect for text lines
class ShimmerLine extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerLine({
    Key? key,
    this.height = 16,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// Loading skeleton for assessment results
class ResultsLoadingSkeleton extends StatelessWidget {
  const ResultsLoadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerCard(height: 120),
          const SizedBox(height: 16),
          ShimmerLine(width: 200),
          const SizedBox(height: 8),
          ShimmerLine(width: 150),
          const SizedBox(height: 16),
          ShimmerCard(height: 200),
          const SizedBox(height: 16),
          ShimmerCard(height: 150),
        ],
      ),
    );
  }
}

