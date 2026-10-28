#!/usr/bin/env python3
"""Serve the Godot HTML5 export from ./dist, plus the backup-code API (api/backup)."""
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import json, mimetypes, os, re, secrets, time

BASE = Path(__file__).resolve().parent
ROOT = BASE / "dist"
BACKUPS = BASE / "backups"
PORT = int(os.environ.get("PORT", "4173"))
ABC = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"
MAX_BYTES = 512 * 1024

mimetypes.add_type("application/wasm", ".wasm")
mimetypes.add_type("application/octet-stream", ".pck")

def new_code() -> str:
    while True:
        code = "".join(secrets.choice(ABC) for _ in range(7))
        if re.search(r"[A-Z]", code) and re.search(r"[0-9]", code) and not (BACKUPS / f"{code}.json").exists():
            return code

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT), **kwargs)

    def _send(self, status: int, body: bytes, ctype: str = "application/json") -> None:
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if self.path.rstrip("/").endswith("/api/backup"):
            length = int(self.headers.get("Content-Length", "0"))
            if length <= 0 or length > MAX_BYTES:
                return self._send(413, b'{"error":"size"}')
            data = self.rfile.read(length)
            try:
                json.loads(data)
            except ValueError:
                return self._send(400, b'{"error":"json"}')
            BACKUPS.mkdir(exist_ok=True)
            code = new_code()
            (BACKUPS / f"{code}.json").write_bytes(data)
            return self._send(200, json.dumps({"code": code, "at": int(time.time())}).encode())
        return self._send(404, b'{"error":"not_found"}')

    def do_GET(self):
        m = re.search(r"/api/backup/([A-Za-z0-9]{7})$", self.path)
        if m:
            f = BACKUPS / f"{m.group(1).upper()}.json"
            if not f.is_file():
                return self._send(404, b'{"error":"not_found"}')
            return self._send(200, f.read_bytes())
        return super().do_GET()

if not (ROOT / "index.html").is_file():
    raise SystemExit(f"Không tìm thấy bản export: {ROOT / 'index.html'}")

server = ThreadingHTTPServer(("0.0.0.0", PORT), Handler)
print(f"Tiên Môn Linh Vận đang phục vụ tại http://0.0.0.0:{PORT}/index.html")
print(f"Mã sao lưu được lưu trong: {BACKUPS}")
try:
    server.serve_forever()
except KeyboardInterrupt:
    print("\nĐã dừng server.")
finally:
    server.server_close()
