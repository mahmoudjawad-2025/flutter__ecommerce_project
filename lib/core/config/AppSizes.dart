import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/core/utils/AppConstants.dart';

class AppSizes {
  //-------------------------------------------------------------------------- Font
  // ---------------- DISPLAY
  static double displayMedium() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallMobile:
          //   return 28.sp;
          // case DeviceSize.mediumMobile:
          //   return 32.sp;
          // case DeviceSize.largeMobile:
          //   return 36.sp;
          default:
            return 0.0125.sw;
        }
      case DeviceGroup.tablet:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTablet:
          //   return 40.sp;
          // case DeviceSize.mediumTablet:
          //   return 44.sp;
          case DeviceSize.largeTablet:
            return 0.03.sw;
          default:
            return 0.02.sw;
        }
      case DeviceGroup.laptop:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallLaptop:
          //   return 46.sp;
          // case DeviceSize.mediumLaptop:
          //   return 50.sp;
          // case DeviceSize.largeLaptop:
          //   return 56.sp;
          default:
            return 0.015.sw;
        }
      case DeviceGroup.tv:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTV:
          //   return 64.sp;
          // case DeviceSize.mediumTV:
          //   return 72.sp;
          // case DeviceSize.largeTV:
          //   return 80.sp;
          default:
            return 0.015.sw;
        }
    }
  }

  // ---------------- HEADLINE
  static double headlineLarge() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallMobile:
          //   return 20.sp;
          // case DeviceSize.mediumMobile:
          //   return 22.sp;
          // case DeviceSize.largeMobile:
          //   return 24.sp;
          default:
            return 5.sp;
        }
      case DeviceGroup.tablet:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTablet:
          //   return 26.sp;
          // case DeviceSize.mediumTablet:
          //   return 28.sp;
          case DeviceSize.largeTablet:
            return 10.sp;
          default:
            return 8.sp;
        }
      case DeviceGroup.laptop:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallLaptop:
          //   return 28.sp;
          // case DeviceSize.mediumLaptop:
          //   return 30.sp;
          // case DeviceSize.largeLaptop:
          //   return 32.sp;
          default:
            return 7.sp;
        }
      case DeviceGroup.tv:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTV:
          //   return 36.sp;
          // case DeviceSize.mediumTV:
          //   return 40.sp;
          // case DeviceSize.largeTV:
          //   return 44.sp;
          default:
            return 7.sp;
        }
    }
  }

  static double headlineMedium() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallMobile:
          //   return 20.sp;
          // case DeviceSize.mediumMobile:
          //   return 22.sp;
          // case DeviceSize.largeMobile:
          //   return 24.sp;
          default:
            return 4.sp;
        }
      case DeviceGroup.tablet:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTablet:
          //   return 26.sp;
          // case DeviceSize.mediumTablet:
          //   return 28.sp;
          case DeviceSize.largeTablet:
            return 9.sp;
          default:
            return 7.sp;
        }
      case DeviceGroup.laptop:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallLaptop:
          //   return 28.sp;
          // case DeviceSize.mediumLaptop:
          //   return 30.sp;
          // case DeviceSize.largeLaptop:
          //   return 32.sp;
          default:
            return 5.sp;
        }
      case DeviceGroup.tv:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTV:
          //   return 36.sp;
          // case DeviceSize.mediumTV:
          //   return 40.sp;
          // case DeviceSize.largeTV:
          //   return 44.sp;
          default:
            return 5.sp;
        }
    }
  }

  // ---------------- TITLE
  // static double titleMedium() {
  //   switch (AppConstants.deviceGroup) {
  //     case DeviceGroup.mobile:
  //       switch (AppConstants.deviceSize) {
  //         case DeviceSize.smallMobile:
  //           return 16.sp;
  //         case DeviceSize.mediumMobile:
  //           return 18.sp;
  //         case DeviceSize.largeMobile:
  //           return 20.sp;
  //         default:
  //           return 18.sp;
  //       }
  //     case DeviceGroup.tablet:
  //       switch (AppConstants.deviceSize) {
  //         case DeviceSize.smallTablet:
  //           return 20.sp;
  //         case DeviceSize.mediumTablet:
  //           return 22.sp;
  //         case DeviceSize.largeTablet:
  //           return 24.sp;
  //         default:
  //           return 22.sp;
  //       }
  //     case DeviceGroup.laptop:
  //       switch (AppConstants.deviceSize) {
  //         case DeviceSize.smallLaptop:
  //           return 22.sp;
  //         case DeviceSize.mediumLaptop:
  //           return 24.sp;
  //         case DeviceSize.largeLaptop:
  //           return 26.sp;
  //         default:
  //           return 24.sp;
  //       }
  //     case DeviceGroup.tv:
  //       switch (AppConstants.deviceSize) {
  //         case DeviceSize.smallTV:
  //           return 28.sp;
  //         case DeviceSize.mediumTV:
  //           return 32.sp;
  //         case DeviceSize.largeTV:
  //           return 36.sp;
  //         default:
  //           return 32.sp;
  //       }
  //     default:
  //       return 18.sp;
  //   }
  // }

  // ---------------- BODY
  static double bodyMedium() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallMobile:
          //   return 12.sp;
          // case DeviceSize.mediumMobile:
          //   return 14.sp;
          // case DeviceSize.largeMobile:
          //   return 16.sp;
          default:
            return 3.sp;
        }
      case DeviceGroup.tablet:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTablet:
          //   return 16.sp;
          // case DeviceSize.mediumTablet:
          //   return 18.sp;
          case DeviceSize.largeTablet:
            return 6.sp;
          default:
            return 4.5.sp;
        }
      case DeviceGroup.laptop:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallLaptop:
          //   return 18.sp;
          // case DeviceSize.mediumLaptop:
          //   return 20.sp;
          // case DeviceSize.largeLaptop:
          //   return 22.sp;
          default:
            return 3.5.sp;
        }
      case DeviceGroup.tv:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTV:
          //   return 24.sp;
          // case DeviceSize.mediumTV:
          //   return 28.sp;
          // case DeviceSize.largeTV:
          //   return 32.sp;
          default:
            return 3.5.sp;
        }
    }
  }

  // ---------------- LABEL
  static double labelLarge() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        switch (AppConstants.deviceSize) {
          case DeviceSize.smallMobile:
            return 10.sp;
          case DeviceSize.mediumMobile:
            return 12.sp;
          case DeviceSize.largeMobile:
            return 13.sp;
          default:
            return 12.sp;
        }
      case DeviceGroup.tablet:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTablet:
          //   return 12.sp;
          // case DeviceSize.mediumTablet:
          //   return 14.sp;
          // case DeviceSize.largeTablet:
          //   return 15.sp;
          default:
            return 3.sp;
        }
      case DeviceGroup.laptop:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallLaptop:
          //   return 14.sp;
          // case DeviceSize.mediumLaptop:
          //   return 15.sp;
          // case DeviceSize.largeLaptop:
          //   return 16.sp;
          default:
            return 6.3.sp;
        }
      case DeviceGroup.tv:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTV:
          //   return 16.sp;
          // case DeviceSize.mediumTV:
          //   return 18.sp;
          // case DeviceSize.largeTV:
          //   return 20.sp;
          default:
            return 4.sp;
        }
    }
  }

  static double labelMedium() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallMobile:
          //   return 10.sp;
          // case DeviceSize.mediumMobile:
          //   return 12.sp;
          // case DeviceSize.largeMobile:
          //   return 13.sp;
          default:
            return 2.5.w;
        }
      case DeviceGroup.tablet:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTablet:
          //   return 12.sp;
          // case DeviceSize.mediumTablet:
          //   return 14.sp;
          case DeviceSize.largeTablet:
            return 5.sp;
          default:
            return 3.7.sp;
        }
      case DeviceGroup.laptop:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallLaptop:
          //   return 14.sp;
          // case DeviceSize.mediumLaptop:
          //   return 15.sp;
          // case DeviceSize.largeLaptop:
          //   return 16.sp;
          default:
            return 4.sp;
        }
      case DeviceGroup.tv:
        switch (AppConstants.deviceSize) {
          // case DeviceSize.smallTV:
          //   return 16.sp;
          // case DeviceSize.mediumTV:
          //   return 18.sp;
          // case DeviceSize.largeTV:
          //   return 20.sp;
          default:
            return 3.sp;
        }
    }
  }

  //-------------------------------------------------------------------------- spacing

  static double paddingSmall() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 1.w;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet ? 2.w : 1.5.w;
      case DeviceGroup.laptop:
        return 1.w;
      case DeviceGroup.tv:
        return 1.w;
    }
  }

  static double appBarPadding() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.2.w;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet ? 4.w : 1.5.w;
      // case DeviceGroup.laptop:
      //   return 60.verticalSpace;
      // case DeviceGroup.tv:
      //   return 60.verticalSpace;
      default:
        return 1.4.w;
    }
  }

  //-------------------------------------------------------------------------- Sizes (w,h)
  static SizedBox verticalSpaceMedium() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 20.verticalSpace;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet
            ? 40.verticalSpace
            : 40.verticalSpace;
      case DeviceGroup.laptop:
        return 30.verticalSpace;
      case DeviceGroup.tv:
        return 30.verticalSpace;
    }
  }

  static double signInPageFrameWidth() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.2.sw;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet
            ? 0.5.sw
            : 0.35.sw;
      case DeviceGroup.laptop:
        return 0.3.sw;
      case DeviceGroup.tv:
        return 0.3.sw;
    }
  }

  //-------------------------------------------------------------------------- assets
  static double animationWidthWidthLarge() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.05.sw;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet
            ? 0.13.sw
            : 0.07.sw;
      case DeviceGroup.laptop:
        return 0.09.sw;
      case DeviceGroup.tv:
        return 0.1.sw;
    }
  }

  //-------------------------------------------------------------------------- widgets
  static double appBarHeight() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.06.sh;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet
            ? 0.13.sh
            : 0.09.sh;
      default:
        return 0.07.sh;
    }
  }

  static Size elevatedButtonSizeLarge() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return Size(0.3.sw, 6.sp);
      case DeviceGroup.tablet:
        return Size(0.5.sw, 9.sp);
      default:
        return Size(0.3.sw, 6.sp);
    }
  }

  static double iconSize() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 5.sp;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet ? 11.sp : 9.sp;
      case DeviceGroup.tv:
        return 6.sp;
      default:
        return 5.sp;
    }
  }

  static Size themeSelecterDialogSize() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return Size(0.7.sw, 0.29.sw);
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.smallTablet
            ? Size(0.3.sw, 0.43.sw)
            : AppConstants.deviceSize == DeviceSize.mediumTablet
            ? Size(0.4.sw, 0.44.sw)
            : Size(0.5.sw, 0.43.sw);
      default:
        return Size(0.45.sw, 0.3.sh);
    }
  }

  static double colorPickerWidth() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.2.sw;
      case DeviceGroup.tablet:
        return 0.3.sw;
      default:
        return 0.2.sw;
    }
  }

  static double drawerWidth() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.3.sh;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet
            ? 0.6.sh
            : 0.45.sh;
      default:
        return 0.3.sh;
    }
  }

  static double drawerHeaderHeight() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.14.sw;
      case DeviceGroup.tablet:
        return 0.2.sw;
      default:
        return 0.2.sw;
    }
  }

  static double bottomBarHeight() {
    switch (AppConstants.deviceGroup) {
      case DeviceGroup.mobile:
        return 0.06.sh;
      case DeviceGroup.tablet:
        return AppConstants.deviceSize == DeviceSize.largeTablet
            ? 0.13.sh
            : 0.09.sh;
      default:
        return 0.07.sh;
    }
  }
}
