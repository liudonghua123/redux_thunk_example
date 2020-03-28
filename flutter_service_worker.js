'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "14abd6d9adb1629898386c63fdae5d82",
"assets/assets/demo.gif": "1f6b16596c2bdb959526dd875f6d5f85",
"assets/assets/langs/en-US.json": "7596ae7ffc45b5370a5a22867ea32e24",
"assets/assets/langs/zh-CN.json": "e98388b0881faa2396ee7ed7f334f26a",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "0a939d0088e6ba1990466c9d4e481477",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/easy_localization/i18n/ar-DZ.json": "d7bfa13f9a386d7a5384f427589606e1",
"assets/packages/easy_localization/i18n/ar.json": "d7bfa13f9a386d7a5384f427589606e1",
"assets/packages/easy_localization/i18n/en-US.json": "a12aacc63370299cbba2d3d26443ed49",
"assets/packages/easy_localization/i18n/en.json": "22c4a70dccdb4f00acce24acd7483d02",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "3e4fc916e233bc9d263bd08e460f5be7",
"main.dart.js": "27dfb1683747d32b531f880c06f5b3f7",
"manifest.json": "e24b81ddc48c0b388f6d0ebc5cceccac"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
