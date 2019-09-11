# flutter_amap

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

1. 导入 amap apikey

    - 修改路径地址
    android -> app -> src -> main -> AndroidMainifest.xml

    ```android
        <application
            <meta-data
                android:name="com.amap.api.v2.apikey"
                android:value="9c3873533669054652b609c1ff9b9f30" />
            ...
        </application>
    ```