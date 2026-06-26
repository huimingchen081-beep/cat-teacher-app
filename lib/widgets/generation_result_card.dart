/// 生成任务的结果展示组件 — 欠揍儿完成生图/生视频/文档后的展示卡片
import 'dart:io';
import 'package:flutter/material.dart';

/// 生成类型枚举（用于展示不同样式）
enum GenResultType { image, video, document }

/// 生成结果数据
class GenResult {
  final GenResultType type;
  final String? title;
  final String? content;      // 文档文本内容
  final String? imagePath;    // 生图本地路径
  final String? imageBase64;  // 生图base64数据
  final bool isLoading;

  const GenResult({
    required this.type,
    this.title,
    this.content,
    this.imagePath,
    this.imageBase64,
    this.isLoading = false,
  });

  GenResult copyWith({
    GenResultType? type,
    String? title,
    String? content,
    String? imagePath,
    String? imageBase64,
    bool? isLoading,
  }) {
    return GenResult(
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      imageBase64: imageBase64 ?? this.imageBase64,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 生成结果卡片 — 在聊天中展示生图/文档结果
class GenerationResultCard extends StatelessWidget {
  final GenResult result;

  const GenerationResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    if (result.isLoading) return _buildLoading();

    switch (result.type) {
      case GenResultType.image:
        return _buildImageResult();
      case GenResultType.document:
        return _buildDocumentResult(context);
      case GenResultType.video:
        return _buildVideoPlaceholder();
    }
  }

  /// 加载中动画
  Widget _buildLoading() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD0B0)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40, height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Color(0xFFFF8C42),
            ),
          ),
          SizedBox(height: 12),
          Text(
            '猫咪老师正在努力中...',
            style: TextStyle(fontSize: 13, color: Color(0xFF996633)),
          ),
          SizedBox(height: 4),
          Text(
            '（一边嫌弃一边默默帮你干活）',
            style: TextStyle(fontSize: 11, color: Color(0xFFBBBBBB)),
          ),
        ],
      ),
    );
  }

  /// 图片结果展示
  Widget _buildImageResult() {
    if (result.imagePath != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFFD0B0), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Image.file(
                File(result.imagePath!),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFFFF5EE),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pets, size: 14, color: Color(0xFFFF8C42)),
                    SizedBox(width: 4),
                    Text(
                      '本喵出品',
                      style: TextStyle(fontSize: 11, color: Color(0xFF996633)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.broken_image, size: 40, color: Color(0xFFFFD0B0)),
            SizedBox(height: 8),
            Text('图片加载失败喵~', style: TextStyle(fontSize: 13, color: Color(0xFFBBBBBB))),
          ],
        ),
      ),
    );
  }

  /// 文档结果展示
  Widget _buildDocumentResult(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD0B0), width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF5EE),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                const Icon(Icons.article, size: 16, color: Color(0xFFFF8C42)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    result.title ?? '生成文档',
                    style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF996633),
                    ),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42).withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('本喵出品', style: TextStyle(fontSize: 10, color: Color(0xFFFF8C42))),
                ),
              ],
            ),
          ),
          // 内容
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Text(
                result.content ?? '',
                style: const TextStyle(fontSize: 13, color: Color(0xFF333333), height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 视频占位（后续实现真实视频生成后替换）
  Widget _buildVideoPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD0B0)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.movie_creation, size: 40, color: Color(0xFFFFD0B0)),
          SizedBox(height: 8),
          Text('🎬 视频生成功能即将上线喵~', style: TextStyle(fontSize: 13, color: Color(0xFF996633))),
          SizedBox(height: 4),
          Text('猫咪老师的爪子还在学剪辑...', style: TextStyle(fontSize: 11, color: Color(0xFFBBBBBB))),
        ],
      ),
    );
  }
}
