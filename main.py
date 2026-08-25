import socket
import threading
import time

import uvicorn
import webview

from app import app as fastapi_app


def _start_server():
    uvicorn.run(fastapi_app, host="127.0.0.1", port=8000, log_level="error")


def _wait_for_server(timeout=10):
    deadline = time.time() + timeout
    while time.time() < deadline:
        try:
            with socket.create_connection(("127.0.0.1", 8000), timeout=0.5):
                return
        except (ConnectionRefusedError, OSError):
            time.sleep(0.1)


if __name__ == "__main__":
    threading.Thread(target=_start_server, daemon=True).start()
    _wait_for_server()

    webview.create_window(
        title="제안요청서 분석기",
        url="http://127.0.0.1:8000",
        width=960,
        height=820,
        min_size=(720, 600),
        resizable=True,
    )
    webview.start()
