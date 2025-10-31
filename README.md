# Ứng dụng Quản lý Ký túc xá (KTX Management App)

Đây là một dự án ứng dụng di động Flutter dùng để quản lý ký túc xá. Ứng dụng cung cấp các chức năng cơ bản để giúp ban quản lý và sinh viên tương tác một cách hiệu quả.

## Tính năng chính (Dự kiến)
- Đăng nhập, đăng ký tài khoản.
- Quản lý thông tin sinh viên.
- Quản lý phòng ở.
- Ghi nhận và xử lý các sự cố, yêu cầu từ sinh viên.
- Gửi thông báo chung.
- Quét mã QR để định danh (sử dụng `mobile_scanner`).

## Hướng dẫn Cài đặt và Chạy dự án

### Yêu cầu phần mềm
- **Flutter SDK**: Đảm bảo bạn đã cài đặt Flutter. Nếu chưa, hãy làm theo hướng dẫn tại [trang chủ của Flutter](https://flutter.dev/docs/get-started/install).
- **Android Studio** hoặc **Visual Studio Code**: Cần có một IDE đã được cài đặt plugin Flutter và Dart.
- **Git**: Để clone dự án.

### Các bước cài đặt
1. **Clone repository về máy của bạn:**
   ```shell
   git clone <URL_CUA_REPOSITORY>
   cd ktx_management_app
   ```

2. **Dọn dẹp dự án (Clean project):**
   Chạy lệnh sau để xóa các file build và cache cũ có thể gây lỗi.
   ```shell
   flutter clean
   ```

3. **Tải các thư viện cần thiết (Get dependencies):**
   Lệnh này sẽ tải về tất cả các package được định nghĩa trong file `pubspec.yaml`.
   ```shell
   flutter pub get
   ```

4. **Chạy ứng dụng:**
   Kết nối một thiết bị (thật hoặc ảo) và chạy lệnh sau:
   ```shell
   flutter run
   ```

## Cấu trúc thư mục quan trọng
```
ktx_management_app/
├── android/              # Cấu hình và mã nguồn cho Android
├── ios/                  # Cấu hình và mã nguồn cho iOS
├── lib/                  # Mã nguồn Dart của ứng dụng
│   ├── main.dart         # Điểm khởi đầu của ứng dụng
│   ├── models/           # Các data models
│   ├── screens/          # Các màn hình giao diện
│   ├── services/         # Các service (API, database,...)
│   └── widgets/          # Các widget có thể tái sử dụng
├── assets/               # Chứa các tài nguyên tĩnh như hình ảnh, fonts
├── pubspec.yaml          # File quản lý metadata và dependencies của dự án
└── README.md             # File bạn đang đọc
```

