# Release Notes — Tiên Môn Linh Vận — 2026-10-09

Theo tài liệu yêu cầu: [Google Docs](https://docs.google.com/document/d/1YVHdLuleS3ec_vBD_GFybauKKtcjHZYkaTOKQgE1PhU/edit)

## Đã cập nhật
- Xóa nhãn hướng dẫn `Linh các · LV1 mở 6 kệ · Linh các 7 mở sau ngày bán với giá 12000 LT` khỏi màn hình cửa hàng.
- Xóa nhãn mặc định `Hôm nay tiếp tối đa ... VIP · đã tiếp ...` khi không có VIP chờ.
- Ẩn khung VIP khi không có khách VIP chờ; vẫn giữ thông tin trạng thái VIP đang chờ khi khách VIP thực sự xuất hiện.
- Giữ nguyên các quy tắc game VIP và mở kệ; không xóa tính năng hoặc tài nguyên không liên quan.

## Kiểm thử
- Godot 4.7.2 headless project parse/smoke test: đạt.
- Web HTML5 release export: đạt.
- Server HTTP sau cập nhật: kiểm tra GET trang HTML và các tệp WebAssembly/PCK.
