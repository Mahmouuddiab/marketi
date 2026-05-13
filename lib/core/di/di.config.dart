// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data%20source/auth_remote_ds.dart' as _i6;
import '../../features/auth/data/data%20source/auth_remote_ds_impl.dart'
    as _i624;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/cart/data/data%20source/cart_remote_ds.dart' as _i597;
import '../../features/cart/data/data%20source/cart_remote_ds_impl.dart'
    as _i509;
import '../../features/cart/data/repository/cart_repository_impl.dart'
    as _i1063;
import '../../features/cart/domain/repository/cart_repository.dart' as _i26;
import '../../features/cart/domain/usecase/add_to_cart_usecase.dart' as _i738;
import '../../features/cart/domain/usecase/get_cart_usecase.dart' as _i624;
import '../../features/cart/presentation/cubit/cart_cubit.dart' as _i499;
import '../../features/home/data/data%20source/local/home_local_ds.dart'
    as _i256;
import '../../features/home/data/data%20source/local/home_local_ds_impl.dart'
    as _i585;
import '../../features/home/data/data%20source/remote/home_remote_ds.dart'
    as _i889;
import '../../features/home/data/data%20source/remote/home_remote_ds_impl.dart'
    as _i170;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/usecase/brand_usecase.dart' as _i146;
import '../../features/home/domain/usecase/category_usecase.dart' as _i589;
import '../../features/home/domain/usecase/product_by_brand_usecase.dart'
    as _i288;
import '../../features/home/domain/usecase/product_by_category_usecase.dart'
    as _i49;
import '../../features/home/domain/usecase/product_usecase.dart' as _i1022;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../../features/profile/data/data%20source/profile_remote_ds.dart'
    as _i640;
import '../../features/profile/data/data%20source/profile_remote_ds_impl.dart'
    as _i56;
import '../../features/profile/data/repository/profile_repository_impl.dart'
    as _i309;
import '../../features/profile/domain/repository/profile_repository.dart'
    as _i364;
import '../../features/profile/domain/usecase/profile_usecase.dart' as _i721;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i36;
import '../network/dio_helper.dart' as _i172;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i172.DioHelper>(() => _i172.DioHelper());
    gh.factory<_i597.CartRemoteDs>(() => _i509.CartRemoteDsImpl());
    gh.factory<_i6.AuthRemoteDs>(() => _i624.AuthRemoteDsImpl());
    gh.factory<_i26.CartRepository>(
        () => _i1063.CartRepositoryImpl(gh<_i597.CartRemoteDs>()));
    gh.factory<_i256.HomeLocalDs>(() => _i585.HomeLocalDsImpl());
    gh.factory<_i889.HomeRemoteDs>(() => _i170.HomeRemoteDsImpl());
    gh.factory<_i640.ProfileRemoteDs>(() => _i56.ProfileRemoteDsImpl());
    gh.factory<_i738.AddToCartUseCase>(
        () => _i738.AddToCartUseCase(gh<_i26.CartRepository>()));
    gh.factory<_i624.GetCartUseCase>(
        () => _i624.GetCartUseCase(gh<_i26.CartRepository>()));
    gh.factory<_i961.AuthRepository>(
        () => _i409.AuthRepositoryImpl(gh<_i6.AuthRemoteDs>()));
    gh.factory<_i541.HomeRepository>(() => _i9.HomeRepositoryImpl(
          gh<_i889.HomeRemoteDs>(),
          gh<_i256.HomeLocalDs>(),
        ));
    gh.factory<_i364.ProfileRepository>(
        () => _i309.ProfileRepositoryImpl(gh<_i640.ProfileRemoteDs>()));
    gh.factory<_i721.ProfileUseCase>(
        () => _i721.ProfileUseCase(gh<_i364.ProfileRepository>()));
    gh.factory<_i499.CartCubit>(() => _i499.CartCubit(
          gh<_i738.AddToCartUseCase>(),
          gh<_i624.GetCartUseCase>(),
        ));
    gh.factory<_i36.ProfileCubit>(
        () => _i36.ProfileCubit(gh<_i721.ProfileUseCase>()));
    gh.factory<_i1022.ProductUseCase>(
        () => _i1022.ProductUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i146.BrandUseCase>(
        () => _i146.BrandUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i589.CategoryUseCase>(
        () => _i589.CategoryUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i49.ProductsByCategoryUseCase>(
        () => _i49.ProductsByCategoryUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i288.ProductsByBrandUseCase>(
        () => _i288.ProductsByBrandUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i769.RegisterUseCase>(
        () => _i769.RegisterUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i911.LoginUseCase>(
        () => _i911.LoginUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i9.HomeCubit>(() => _i9.HomeCubit(
          gh<_i1022.ProductUseCase>(),
          gh<_i49.ProductsByCategoryUseCase>(),
          gh<_i288.ProductsByBrandUseCase>(),
          gh<_i589.CategoryUseCase>(),
          gh<_i146.BrandUseCase>(),
        ));
    gh.factory<_i117.AuthCubit>(() => _i117.AuthCubit(
          gh<_i769.RegisterUseCase>(),
          gh<_i911.LoginUseCase>(),
        ));
    return this;
  }
}
