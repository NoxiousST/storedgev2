import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:storedgev2/features/item/application/item_provider.dart';
import 'package:storedgev2/features/item/application/item_state.dart';
import 'package:storedgev2/models/item/item.dart';

part 'item_service.g.dart';

@riverpod
class ItemService extends _$ItemService {
  @override
  ItemState build() {
    return const ItemState(LoadingStateEnum.initial, null);
  }

  Future<void> addItem({
    required Item item,
    required List<TempImage> files,
  }) async {
    state = const ItemState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(itemRepositoryProvider);
      await firestoreRepository.addItem(item: item, files: files);
      state = const ItemState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = ItemState(LoadingStateEnum.error, e);
    }
  }

  Future<void> updateItem({required Item item, required List<TempImage> files}) async {
    state = const ItemState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(itemRepositoryProvider);
      await firestoreRepository.updateItem(item: item, files: files);
      state = const ItemState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = ItemState(LoadingStateEnum.error, e);
    }
  }

  Future<void> deleteItem(String id) async {
    state = const ItemState(LoadingStateEnum.loading, null);
    try {
      final firestoreRepository = ref.watch(itemRepositoryProvider);
      await firestoreRepository.deleteItem(id: id);
      state = const ItemState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = ItemState(LoadingStateEnum.error, e);
    }
  }

}
