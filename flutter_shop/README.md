# flutter_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

# json to dart
[jsontodart](https://javiercbk.github.io/json_to_dart/)

# 用到的组件

- dio:用于向后端接口作HTTP请求数据
- flutter_swiper: 轮播插件，制作了商城首页的轮播效果
- flutter_screenutil:用于不同屏幕的适配，一次设计，适配所有屏幕
- url_launcher:用于打开网页和实现原生电话的拨打
- flutter_easyrefresh：下拉刷新或者上拉加载插件。
- provide：谷歌最新推出的Flutter状态管理插件。
- fluttertoast：Toast轻提示插件

1. 解决容器溢出的bug

    代码

        '''dart
            Expanded(
                child: Container(
                    ...
                )
            )
        '''

2. 上拉刷新加载切换时回顶部

    代码

        """ flutter
            var scrollController = new ScrollController();

            scrollController.jumpTo(0.0);

            child: ListView.builder(
                controller: scrollController,
                ...
            )
        """