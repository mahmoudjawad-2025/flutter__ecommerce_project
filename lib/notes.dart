/*
* Main Structure 
- for comments use this const line (put it at begining of your section , wherever it't long go to)
- (//-------------------------------------------------------------------------- section name)
- then if want change it, just use Find in all files (from edit tab) and replace with new, so all have same comment structure

* Naming Approach
- folder_folder : folders , but here in asp.net maybe Folder_Folder
- FileFile : files and clases and main parts
- varVar : camelCase , but here in asp.net maybe VarVAr
- group1VarVar group2VarVar : camelCase
(//-------------------------------------------------------------------------- built in framework)
* widget key
- note we set key value when we use page with multi widgets (as foget password steps), to tell Flutter (keep vs rebuild) new widget in tree
- Without keys, Flutter uses only the widget type and position in the tree to decide whether to reuse an old widget.
- But sometimes, two widgets of the same type appear in the same place in the tree → Flutter might reuse the wrong one (leading to stale state).
- Keys solve that by giving widgets a unique identity.
- ex:
Widget _buildStep(ForgetPasswordState state, ForgetPasswordCubit cubit) {
    switch (state) {
      case ForgetPasswordInitial():
        return PhoneStep( 
          cubit: cubit,
          state: state,
          key: const ValueKey("phone"),
        );

      case ForgetPasswordCodeSent():
        return VCodeStep(
          cubit: cubit,
          state: state, 
          key: const ValueKey("vcode"),
        );
      }
  }
(//-------------------------------------------------------------------------- router
- note using go_route package
// Good for normal navigation (preserves back stack)
context.push(AppRoutes.signIn);
context.push(AppRoutes.productDetailWithId('123'));
context.push(AppRoutes.forgetPassword);
// to go back step
context.pop();
// Only use go() when you specifically want to clear the stack
context.go(AppRoutes.signIn); // Good for logout -> login flow
-------------------------------------------------------------------------------- rename whole project identity
*** almost find and replace enough

🔎 1. What your find & replace covered

✅ pubspec.yaml → name: old_name → becomes new_name

✅ Dart imports like

import 'package:old_name/utils/helper.dart';
→ now package:new_name/...
✅ Some Android/iOS config strings that contain your old name
So yes, it fixes a lot, but there are hidden places where plain search & replace isn’t enough.

🔎 2. What still needs manual care
Android package name (applicationId)
Lives in android/app/build.gradle →
applicationId "com.example.oldname"

This must be changed manually if you want a new package ID (not just project name).
Java/Kotlin folder structure
Path under android/app/src/main/java/com/example/oldname/
You need to rename the folder too if you change the package ID.
Otherwise, app will crash with “package not found”.
iOS bundle identifier
In Xcode (ios/Runner.xcodeproj / Runner.xcworkspace) and ios/Runner/Info.plist.
This isn’t updated by text replace unless you carefully hit all keys like PRODUCT_BUNDLE_IDENTIFIER.
Main folder name (the root project folder)
This is just your file system folder.
Flutter doesn’t care what the folder is called.
Only matters for your own organization. That’s why your replace didn’t touch it — it’s not referenced inside project files.

🔎 3. Safe conclusion
If you only want to rename the Flutter package (so imports & pubspec name) → your find & replace is enough.
If you want to rename the whole app identity (package ID, bundle ID, Android/iOS display names) → you must fix the spots I listed above (or use rename / flutter_rename_app to automate).


-------------------------------------------------------------------------------- service locator : lib/core/services , note dependency injection
0- note: no need use object in ui, only need once when you provide through BlockProvider (almost once in main)
1- sl -----------------------------------------------------------------
explain it me theoritaccly how work, how best use, what can include in this files?
and how i send sl instead of apiclient for productapi, and instead of methods here:sl.registerFactory(() => ProductCubit(
        getProducts: sl(),
        getProductById: sl(),
        getRecommended: sl(),
      ));


Perfect — let’s go step by step conceptually, so you understand exactly how get_it works, what you put in it, and how to use it cleanly.
🧠 What get_it Does (Theory)
get_it is a service locator, which is a simple global registry for dependencies.
Think of it as a box of objects:
At app start, you put objects (or factories) inside the box and give each one a type label.
Anywhere in your app, you can ask the box for an object by type, and it gives you the same instance (singleton) or a new one (factory).

⚙️ How It Works Internally
You call:
sl.registerLazySingleton(() => ApiClient());
This means: "Whenever someone asks for ApiClient, build it the first time and reuse it forever."

Later, in any class, you call:
final api = sl<ApiClient>();
This means: "Get me the ApiClient instance from the box."
This gives you decoupling:
The class doesn’t care who created ApiClient.
You can swap the real ApiClient with a fake for testing just by changing registration, not the class code.
📦 What Should You Put in the Service Locator?

General rule of thumb:

Type of thing	Register as	Why
API clients / http clients	LazySingleton	One global instance is enough
Repositories	LazySingleton	Shared data access logic
Use cases	LazySingleton	Stateless, reusable
Cubits / Blocs	Factory	Each widget tree needs a new instance
Shared services (theme, auth, logging)	LazySingleton	Only one needed
You should not register:
Widgets
UI state (unless via Cubit/Bloc)
Temporary variables (use normal new).

📁 Clean File Organization
lib/
├── core/
│   └── di/
│       └── service_locator.dart  // where you register all dependencies
│
├── core/network/
│   └── api_client.dart
│
├── features/
│   └── products/
│       ├── data/
│       │   ├── product_api.dart
│       │   └── product_repository_impl.dart
│       ├── domain/
│       │   ├── product_repository.dart
│       │   └── usecases/
│       │       ├── get_products.dart
│       │       ├── get_product_by_id.dart
│       │       └── get_recommended_products.dart
│       └── presentation/
│           ├── product_cubit.dart
│           └── cart_cubit.dart


service_locator.dart knows how to build everything.
Other classes don’t create their own dependencies, they just ask sl() for what they need.
🧩 How sl() Resolves Dependencies Recursively
Look at this line:
sl.registerLazySingleton(() => ProductApi(client: sl()));
ProductApi needs ApiClient.
sl() looks in the box and finds an ApiClient you already registered earlier.
So it gives it to ProductApi.

➡️ This is called dependency chaining.
You can do the same for use cases and cubits:

sl.registerFactory(() => ProductCubit(
  getProducts: sl(),           // sl<GetProductsUseCase>()
  getProductById: sl(),         // sl<GetProductByIdUseCase>()
  getRecommended: sl(),         // sl<GetRecommendedProductsUseCase>()
));
Here sl() is just shorthand for “ask the box for this type”.
get_it uses Dart’s type inference to know what you’re asking for.

📝 Summary: How to Use
At startup:
await initServiceLocator();  // registers everything
Inside BlocProvider:
BlocProvider(create: (_) => sl<ProductCubit>()..loadProducts())
Inside any class:
class MyClass {
  final _client = sl<ApiClient>();
  ...
}

⚡ Why This Is the Best Practice
Centralized: One file (service_locator.dart) controls all dependency wiring.
Decoupled: Classes only say what they need, not how to create it.
Testable: In tests, you can register fake versions.
Scalable: Adding new features just means adding one sl.register... line.

🧠 Bonus Tip
If you want, you can stop passing dependencies into constructors manually and instead:
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase _getProducts = sl();
  final GetProductByIdUseCase _getProductById = sl();
  final GetRecommendedProductsUseCase _getRecommended = sl();
  ProductCubit(): super(ProductInitial());
}


Then register it simply as:
sl.registerFactory(() => ProductCubit());
This is called "self-locating" dependencies inside the class.
It reduces constructor clutter, but make sure not to overuse it (constructor injection is still cleaner for tests).

✅ Wrap-up
get_it is like a global dependency box.
register*() puts things in the box at startup.
sl<Type>() pulls them out anywhere you need.
You register singletons for shared logic and factories for UI-related cubits.
If you want, I can now refactor your current ProductCubit and CartCubit to use self-locating sl() inside them so your service_locator.dart becomes even cleaner.

-------------------------- how enable auto generate?
0- add in pubspec.yaml :  build_runner + injectable_generator
1- add 
@injectable => it registers the class as a factory (a new instance is created every time you ask for it)) 
or @LazySingleton(as: ProductRepository) , note last used 'as' because of interface => use it for these 2cases :
Singleton: You want only one shared instance of the class for the entire app. This is ideal for Repositories, ApiClients, UseCases, and Services. They hold no UI state and can be safely shared.
as: You are registering an implementation (ProductRepositoryImpl) for an abstract interface (ProductRepository). This tells the generator: "When someone asks for a ProductRepository, give them the singleton instance of ProductRepositoryImpl."
2- run flutter pub run build_runner build
3- which classes can included: 
In short: You need @injectable on almost everything that has dependencies.

1. Data Layer (Annotate Implementations)
lib/features/products/data/product_repository.dart (The implementation class, e.g., ProductRepositoryImpl)

lib/features/products/data/product_api.dart (The ProductApi class)

2. Domain Layer (Annotate Use Cases)
lib/features/products/domain/products_usecases.dart (Each UseCase class inside this file: GetProductsUseCase, GetProductByIdUseCase, etc.)

3. Presentation Layer (Annotate Cubits/Blocs)
lib/features/products/presentation/product_cubit.dart

lib/features/products/presentation/product_details_cubit.dart

lib/features/products/presentation/cart_cubit.dart


--------------------------------------------------------------------------------

*/
