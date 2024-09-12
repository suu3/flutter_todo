import 'dart:async';
import 'package:flutter_todo/models/category.dart';
import 'package:flutter_todo/providers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

part 'category_list.g.dart';

@riverpod
class CategoryList extends _$CategoryList {
  late final Auth auth;
  @override
  Future<List<Category>> build() async {
    // 초기 상태에서 빈 리스트를 반환
    return [];
  }

  Future<List<Category>?> getCategories() async {
    final supabase = Supabase.instance.client;
    auth = ref.read(authProvider);
    final currentUser = await auth.getCurrentUser();
    if (currentUser.user == null) {
      return null;
    } else {
      var currentUserId = currentUser.user?.id as String;

      try {
        final response = await supabase
            .from('categories')
            .select()
            .eq('user_id', currentUserId);

        if (response.isEmpty) {
          return null;
        }

        final categories = (response as List<dynamic>)
            .map((categoryJson) => Category(
                  id: categoryJson['id'],
                  userId: categoryJson['user_id'],
                  title: categoryJson['title'],
                  color: categoryJson['color'] == null
                      ? Colors.grey
                      : Category.getColorFromString(categoryJson['color']),
                  icon: categoryJson['icon'] == null
                      ? Icons.help
                      : Category.getIconDataFromString(categoryJson['icon']),
                ))
            .toList();

        return categories;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  Future<void> addCategory(String title, String? color, String? icon) async {
    final supabase = Supabase.instance.client;
    auth = ref.read(authProvider);
    final currentUser = await auth.getCurrentUser();
    if (currentUser.user == null) {
      return;
    } else {
      var currentUserId = currentUser.user?.id as String;
      try {
        final response = await supabase.from('categories').insert({
          'user_id': currentUserId,
          'title': title,
          'color': color,
          'icon': icon,
        }).select();

        if (response.isEmpty) {
          throw Exception('Failed to insert category');
        }

        final newCategory = Category(
            id: response.first['id'],
            userId: response.first['user_id'],
            title: response.first['title'],
            color: Category.getColorFromString(response.first['color']),
            icon: Category.getIconDataFromString(response.first['icon']));

        state = AsyncData([...?state.value, newCategory]);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> updateCategory(
      String id, String title, String? color, String? icon) async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from('categories')
          .update({
            'title': title,
            'color': color,
            'icon': icon,
          })
          .eq('id', id)
          .select();

      if (response.isEmpty) {
        return;
      }

      state = state.whenData((categories) {
        return categories.map((category) {
          if (category.id == id) {
            return category.copyWith(
              title: title,
              color: Category.getColorFromString(response.first['color']),
              icon: Category.getIconDataFromString(response.first['icon']),
            );
          }
          return category;
        }).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeCategory(String id) async {
    final supabase = Supabase.instance.client;
    try {
      final response =
          await supabase.from('categories').delete().eq('id', id).select();

      if (response.isEmpty) {
        return;
      }

      state = state.whenData((categories) {
        return categories.where((category) => category.id != id).toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
