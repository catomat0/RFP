#!/bin/bash
cd "$(dirname "$0")"

if [ -f .server.pid ]; then
    PID=$(cat .server.pid)
    if kill "$PID" 2>/dev/null; then
        echo "서버가 종료되었습니다. (PID: $PID)"
    else
        echo "프로세스를 찾지 못했습니다. 포트로 재시도합니다..."
        lsof -ti:8000 | xargs kill -9 2>/dev/null && echo "종료 완료."
    fi
    rm .server.pid
else
    PIDS=$(lsof -ti:8000)
    if [ -n "$PIDS" ]; then
        echo "$PIDS" | xargs kill -9
        echo "서버가 종료되었습니다."
    else
        echo "실행 중인 서버가 없습니다."
    fi
fi
