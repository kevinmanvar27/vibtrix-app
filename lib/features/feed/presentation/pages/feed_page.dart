import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../posts/presentation/pages/comments_page.dart';
import '../providers/feed_provider.dart';
import '../widgets/post_card.dart';

/// Main feed page showing posts from followed users and "For You" recommendations
class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final feedType = _tabController.index == 0 ? FeedType.forYou : FeedType.following;
      ref.read(feedProvider.notifier).switchFeedType(feedType);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(feedProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            elevation: 0,
            title: Text(
              'VidiBattle',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // TODO: Navigate to notifications
                },
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined),
                onPressed: () {
                  // TODO: Navigate to messages
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: theme.colorScheme.onSurface,
              unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              tabs: const [
                Tab(text: 'For You'),
                Tab(text: 'Following'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFeedContent(FeedType.forYou),
            _buildFeedContent(FeedType.following),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedContent(FeedType feedType) {
    final feedState = ref.watch(feedProvider);

    // Show loading indicator for initial load
    if (feedState.isLoading && feedState.posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    // Show error state
    if (feedState.errorMessage != null && feedState.posts.isEmpty) {
      return _buildErrorState(feedState.errorMessage!);
    }

    // Show empty state
    if (feedState.posts.isEmpty) {
      return _buildEmptyState(feedType);
    }

    // Show posts
    return RefreshIndicator(
      onRefresh: () => ref.read(feedProvider.notifier).refresh(),
      color: AppColors.primary,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: feedState.posts.length + (feedState.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Show loading indicator at the bottom
          if (index == feedState.posts.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            );
          }

          final post = feedState.posts[index];
          return PostCard(
            post: post,
            onTap: () => _navigateToPostDetail(post.id),
            onUserTap: () => _navigateToUserProfile(post.userId),
            onCommentTap: () => _navigateToComments(post.id),
            onShareTap: () => _sharePost(post.id),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.read(feedProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(FeedType feedType) {
    final isForYou = feedType == FeedType.forYou;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isForYou ? Icons.explore_outlined : Icons.people_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              isForYou ? 'No posts yet' : 'Follow users to see their posts',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isForYou
                  ? 'Be the first to share something!'
                  : 'Discover new creators and follow them to see their content here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (!isForYou)
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to explore/discover
                },
                icon: const Icon(Icons.search),
                label: const Text('Discover Creators'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToPostDetail(String postId) {
    // TODO: Navigate to post detail page
    debugPrint('Navigate to post: $postId');
  }

  void _navigateToUserProfile(String userId) {
    // TODO: Navigate to user profile page
    debugPrint('Navigate to user: $userId');
  }

  void _navigateToComments(String postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsPage(postId: postId),
      ),
    );
  }

  void _sharePost(String postId) {
    ref.read(feedProvider.notifier).sharePost(postId);
    // TODO: Show share sheet
    debugPrint('Share post: $postId');
  }
}
