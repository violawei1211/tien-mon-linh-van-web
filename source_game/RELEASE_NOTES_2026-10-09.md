# Release Notes — Tiên Môn Linh Vận — 2026-10-09

Theo tài liệu yêu cầu: [Google Docs](https://docs.google.com/document/d/1YVHdLuleS3ec_vBD_GFybauKKtcjHZYkaTOKQgE1PhU/edit)

## Đã cập nhật
- Xóa nhãn hướng dẫn `Linh các · LV1 mở 6 kệ · Linh các 7 mở sau ngày bán với giá 12000 LT` khỏi màn hình cửa hàng.
- Xóa hoàn toàn khung/banner VIP màu vàng khỏi UI, không chỉ ẩn khi không có VIP.
- Giữ nguyên logic VIP trong gameplay (loại khách, đơn VIP, thời gian chờ và giới hạn lượt); nhãn VIP trên thẻ khách hiện tại vẫn giữ nguyên.
- Mở rộng khung cuộn `main_scroll` sát hai mép viewport (`x=0`, rộng 540 px), giữ y=460 và cao 535 px.
- Lưới `main_scroll` hiện có 3 kệ mỗi hàng, khe ngang 2 px và card rộng 170 px. Giữ nguyên kích thước/tỷ lệ khung sản phẩm 120×120 px và texture 114×114 px (đệm 3 px mỗi cạnh); nền ô sản phẩm và ô trống trong suốt, viền vàng ở mọi trạng thái. Các hàng sau vẫn cuộn; panel Bố trí Tiên Môn không đổi.
- Viewport tăng lên 540 × 995 để khung vừa màn hình; quy đổi 10 px logic/cm. Panel Bố trí tiên môn giữ kích thước ban đầu.
- Gỡ khung vàng giải phóng khoảng trống để thẻ khách không còn dính/chồng lên khung cuộn kệ.
- Tăng font UI ngoài bảng HUD minh họa thêm 3 px (labels, nút và trường nhập); toàn bộ chữ trong bảng HUD giữ cỡ hiện tại.

## Kiểm thử
- Godot 4.7.2 headless project parse/smoke test: đạt.
- Web HTML5 release export: đạt.
- Server HTTP sau cập nhật: kiểm tra GET trang HTML và các tệp WebAssembly/PCK.
