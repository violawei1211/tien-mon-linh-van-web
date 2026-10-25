# Tiên Môn Linh Vận — bản cập nhật 2026-10-09

## Thay đổi theo tài liệu yêu cầu
- Gỡ dòng chú thích trạng thái mở kệ khỏi khu vực cửa hàng.
- Gỡ dòng thông báo giới hạn/lượt VIP khỏi khung vàng; khung VIP chỉ xuất hiện khi có khách VIP đang chờ.
- Không thay đổi cơ chế mở kệ, giới hạn VIP, tiếp khách hoặc các tính năng chơi khác.

## Chạy bản web
1. Giải nén ZIP server.
2. Chạy `python3 start_server.py` trong thư mục `server_package`.
3. Mở `http://127.0.0.1:4173/index.html`.

Có thể đổi cổng bằng biến môi trường `PORT`, ví dụ `PORT=8080 python3 start_server.py`.

## Build lại từ source
Dự án dùng Godot 4.7.2 và export preset `Web`.

```bash
godot --headless --path . --editor --quit
godot --headless --path . --export-release Web dist/index.html
```

Source được phục hồi từ gói Godot export có trong bản server trước và chứa chỉnh sửa theo tài liệu; ZIP source riêng đi kèm bản phát hành.