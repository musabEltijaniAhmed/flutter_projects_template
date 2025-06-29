

# 🧠 مفهوم Dependency Injection (DI) وإدارة الحالة باستخدام Riverpod في Flutter

## ✅ ما هو Dependency Injection (DI)؟

هو نمط تصميم يُستخدم لفصل مكونات التطبيق عن بعضها البعض، بحيث لا تعتمد الكائنات على إنشاء مثيلاتها من الكائنات الأخرى بنفسها، بل يتم تزويدها بها من الخارج.<br>
أو بطريقة أخرى:  
DI يعني: عدم إنشاء الكائنات (dependencies) داخل الكلاس نفسه، بل تمريرها من الخارج (مثل constructor أو مزود خارجي)<br>
⟶ هذا يجعل الكود قابل للاختبار، قابل لإعادة الاستخدام، ومرن في التغيير.



### ✨ فوائد DI:

* **قابلية الاختبار (Testability):** يمكن استبدال الكائنات الحقيقية بمزيفة بسهولة.
* **المرونة (Flexibility):** إمكانية تغيير طريقة التنفيذ دون تعديل المستهلك.
* **الاستدامة (Maintainability):** سهولة صيانة الكود وتوسيعه.
* **تقليل الترابط (Loose Coupling):** تقليل التبعية المباشرة بين المكونات.

---

## ✅ لماذا نستخدم Riverpod؟

* **حقن التبعيات (Dependency Injection).**
* **إدارة دورة حياة المزودين.**
* **سهولة في الكتابة والاختبار.**
* **دعم للمزودين المتعددين مثل `Provider` و `StateNotifierProvider` و `FutureProvider`.**

---

## 🧱 مبدأ التصميم: Loose Coupling

> "المكونات لا تعتمد على تطبيقات مباشرة، بل على واجهات مجردة (abstract interfaces)."

* لا يوجد استخدام لـ `BuildContext` أو `watch()` داخل الطبقات المنطقية.
* تعتمد الطبقات المنطقية على مزودين يتم حقنهم عبر `ref.read()` أو `ref.watch()` حسب الحاجة.

---

## 🗂️ نظرة على الهيكل المعماري للمشروع

```
lib/
├── domain/                  # الواجهات المجردة (Abstract Interfaces)
│   └── user_repository.dart  
├── data/                    # التطبيقات الفعلية (Concrete Implementations)
│   └── user_repository_impl.dart  
├── providers/               # إعداد المزودات (Providers)
│   └── user_providers.dart  
├── viewmodels/              # إدارة الحالة باستخدام StateNotifier
│   └── user_notifier.dart  
├── services/                # مصادر البيانات (محلي أو عن بعد)
│   └── remote_data_source.dart
```

---

## 🧩 أمثلة على المزودات الأساسية (بدون استخدام BuildContext أو watch)

```dart
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSourceImpl();
});

```dart
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remote = ref.read(remoteDataSourceProvider);
  return UserRepositoryImpl(remote);
});

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final UserRepository repo;

  UserNotifier(this.repo) : super(const AsyncValue.loading());

  Future<void> loadUser(String id) async {
    try {
      final user = await repo.getUser(id);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final userNotifierProvider =
StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  final repo = ref.read(userRepositoryProvider);
  return UserNotifier(repo);
});

class MockUserRepository implements UserRepository {
  @override
  Future<User> getUser(String id) async {
    return User(id: id, name: 'Test User');
  }
}

void main() async {
  final container = ProviderContainer(overrides: [
    userRepositoryProvider.overrideWithValue(MockUserRepository()),
  ]);

  final notifier = container.read(userNotifierProvider.notifier);
  await notifier.loadUser('123');

  final result = container.read(userNotifierProvider);
  expect(result.value?.name, 'Test User');
}
