# 제안요청서 분석기

RFP(제안요청서) / 과업지시서를 업로드하면 Gemini AI가 분석해 Excel 부록 설계서를 자동으로 생성하는 데스크탑 앱입니다.

## 주요 기능

- PDF · DOCX · HWPX 등 다양한 형식의 제안요청서 업로드 지원
- Gemini API를 통한 심층 분석 (사업개요 · 발주처정보 · 목차설계 등)
- 분석 결과를 Excel 템플릿(`부록설계_양식.xlsx`)에 자동 채워 다운로드
- PyWebView 기반 네이티브 데스크탑 창 (브라우저 불필요)
- 창 닫으면 서버 포함 프로세스 전체 종료

## 사용 방법

### 개발 환경에서 실행

1. 의존성 설치

```bash
pip install -r requirements.txt
```

2. 앱 실행

| 플랫폼 | 방법 |
|--------|------|
| Mac | `시작.command` 더블클릭 |
| Windows | `시작.bat` 더블클릭 |
| 터미널 | `python3 main.py` |

3. 앱이 실행되면 Gemini API 키를 입력하고 제안요청서 파일을 업로드합니다.

### Gemini API 키 발급

[Google AI Studio](https://aistudio.google.com/app/apikey)에서 무료로 발급할 수 있습니다.

## 빌드 (배포용 실행 파일)

Python 없이 실행 가능한 단일 앱으로 빌드합니다.

| 플랫폼 | 빌드 스크립트 | 결과물 |
|--------|--------------|--------|
| Mac | `build_mac.sh` 실행 | `dist/제안요청서분석기.app` |
| Windows | `build_win.bat` 실행 | `dist/제안요청서분석기.exe` |

빌드 후 결과물만 전달하면 상대방은 Python 설치 없이 바로 사용 가능합니다.

## 구조

```
excelkiller/
├── main.py                # 앱 진입점 (PyWebView + uvicorn 스레드)
├── app.py                 # FastAPI 백엔드 (/analyze, /export)
├── index.html             # 프론트엔드 UI
├── 부록설계_양식.xlsx      # Excel 템플릿 (정적 파일)
├── requirements.txt
├── build_mac.sh           # Mac 빌드 스크립트
├── build_win.bat          # Windows 빌드 스크립트
├── 시작.command           # Mac 실행 스크립트
├── 시작.bat               # Windows 실행 스크립트
├── 종료.command           # Mac 종료 스크립트
└── 종료.bat               # Windows 종료 스크립트
```

## 기술 스택

- **Backend**: FastAPI + uvicorn
- **AI**: Google Gemini API (`gemini-2.5-flash`)
- **Excel**: openpyxl
- **Desktop**: PyWebView
- **Build**: PyInstaller

