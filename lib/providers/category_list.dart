import 'dart:async';
import 'package:flutter_todo/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'category_list.g.dart';

@riverpod
class CategoryList extends _$CategoryList {
  @override
  Future<List<Category>> build() async {
    return await getCategories('ad5a4932-19e5-4f97-a4d8-29a6fa0e2c0b') ?? [];
  }

  Future<List<Category>?> getCategories(String userId) async {
    final supabase = Supabase.instance.client;
    try {
      final response =
          await supabase.from('category').select('*').eq('user_id', userId);

      if (response.isEmpty) {
        return null;
      }

      final categories = (response as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();

      return categories;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addCategory(String title, String? color) async {
    final supabase = Supabase.instance.client;
    try {
      var userId = 'ad5a4932-19e5-4f97-a4d8-29a6fa0e2c0b';

      final response = await supabase.from('category').insert({
        'user_id': userId,
        'title': title,
        'color': color,
      }).select();

      if (response.isEmpty) {
        throw Exception('Failed to insert category');
      }

      final newCategory = Category(
          id: response.first['id'],
          userId: response.first['user_id'],
          title: response.first['title'],
          color: response.first['color']);

      state = AsyncData([...?state.value, newCategory]);
    } catch (e) {}
  }

  Future<void> updateCategory(String id, String title, String? color) async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from('category')
          .update({'title': title, 'color': color})
          .eq('id', id)
          .select();

      if (response.isEmpty) {
        return;
      }

      state = state.whenData((categories){
        return categories.map((category){
          if(category.id == id){
            return category.copyWith(title: title, color: color)
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
      final response = await supabase
      .from('category')
      .delete()
      .eq('id', id)
      .select();

      if(response.isEmpty){
        return;
      }
      state = state.whenData((categories){
        return categories.where((category) => category.id != id).toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
