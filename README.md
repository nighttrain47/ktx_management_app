# KTX Management App

Ứng dụng di động quản lý ký túc xá được xây dựng bằng Flutter.

## Mục lục

- [Giới thiệu](#giới-thiệu)
- [Tính năng](#tính-năng)
- [Bắt đầu](#bắt-đầu)
  - [Yêu cầu](#yêu-cầu)
  - [Cài đặt](#cài-đặt)
- [Cấu trúc thư mục](#cấu-trúc-thư-mục)
- [Các gói phụ thuộc](#các-gói-phụ-thuộc)
- [Đóng góp](#đóng-góp)
- [Bản quyền](#bản-quyền)

## Giới thiệu

**KTX Management App** là một dự án ứng dụng di động được phát triển bằng framework Flutter, nhằm mục đích đơn giản hóa và tự động hóa các quy trình quản lý trong ký túc xá. Ứng dụng cung cấp các chức năng cho cả người quản lý và sinh viên, từ việc quản lý thông tin sinh viên, phòng ở, đến các vấn đề an ninh và tiện ích.

## Tính năng

- **Quản lý sinh viên:** Thêm, sửa, xóa và tìm kiếm thông tin sinh viên.
- **Quản lý phòng:** Quản lý trạng thái phòng, sắp xếp sinh viên vào phòng.
- **An ninh:** Ghi nhận lượt ra vào của sinh viên (sử dụng QR code).
- **Thống kê:** Hiển thị các biểu đồ, thống kê về tình hình ký túc xá.
- **Đăng nhập:** Xác thực người dùng (quản lý).

## Bắt đầu

Hướng dẫn cài đặt và chạy dự án trên môi trường Windows 11.

### Yêu cầu

- **Flutter SDK:** Đảm bảo bạn đã cài đặt Flutter SDK. Hướng dẫn cài đặt có thể tìm thấy tại [trang chủ của Flutter](https://flutter.dev/docs/get-started/install/windows).
- **IDE:** Một trình soạn thảo mã nguồn như [Visual Studio Code](https://code.visualstudio.com/) hoặc [Android Studio](https://developer.android.com/studio).
- **Git:** Cần có Git để clone dự án.

### Cài đặt

1.  **Clone a repository**

    ```sh
    git clone https://github.com/your-username/ktx_management_app.git
    cd ktx_management_app
    ```

2.  **Lấy các gói phụ thuộc**

    Mở terminal trong thư mục gốc của dự án và chạy lệnh sau:

    ```sh
    flutter pub get
    ```

3.  **Chạy ứng dụng**

    Kết nối một thiết bị (hoặc sử dụng máy ảo) và chạy lệnh sau:

    ```sh
    flutter run
    ```

## Cấu trúc thư mục

Dưới đây là cấu trúc thư mục chính của dự án:

```
ktx_management_app/
├── android/            # Cấu hình cho nền tảng Android
├── ios/                # Cấu hình cho nền tảng iOS
├── lib/                # Mã nguồn Dart của ứng dụng
│   ├── core/
│   │   ├── models/     # Các lớp mô hình dữ liệu (e.g., Student, Room)
│   │   ├── services/   # Các dịch vụ (e.g., API client, database)
│   │   └── utils/      # Các hàm tiện ích
│   ├── features/       # Các tính năng chính của ứng dụng
│   │   ├── auth/       # Chức năng đăng nhập
│   │   ├── management/ # Chức năng quản lý (sinh viên, phòng)
│   │   ├── security/   # Chức năng an ninh (QR scan)
│   │   └── student/    # Chức năng liên quan đến sinh viên
│   ├── shared/
│   │   └── widgets/    # Các widget có thể tái sử dụng
│   └── main.dart       # Điểm khởi đầu của ứng dụng
├── test/               # Chứa các file test
├── pubspec.yaml        # Quản lý các gói phụ thuộc và tài sản
└── README.md           # Tài liệu mô tả dự án
```

## Các gói phụ thuộc

Dự án sử dụng các gói phụ thuộc chính sau:

- `flutter`: Framework chính.
- `provider`: Quản lý trạng thái.
- `shared_preferences`: Lưu trữ dữ liệu cục bộ đơn giản.
- `fl_chart`: Vẽ biểu đồ và thống kê.
- `mobile_scanner`: Quét mã QR.
- `image_picker`: Chọn ảnh từ thư viện hoặc máy ảnh.

Chi tiết xem tại file `pubspec.yaml`.

## Đóng góp

Mọi đóng góp đều được chào đón! Vui lòng tạo một `Pull Request` để đóng góp.

1.  Fork dự án.
2.  Tạo một nhánh mới (`git checkout -b feature/AmazingFeature`).
3.  Commit các thay đổi của bạn (`git commit -m 'Add some AmazingFeature'`).
4.  Push lên nhánh (`git push origin feature/AmazingFeature`).
5.  Mở một Pull Request.

## Bản quyền

Dự án này được cấp phép theo Giấy phép MIT. Xem file `LICENSE` để biết thêm chi tiết.

