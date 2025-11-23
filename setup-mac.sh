#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="${SCRIPT_DIR}/Brewfile"  # repo 안이면 상대 경로로 바꿔도 됨
echo "[setup-mac] Starting…"

########################################
# 1. Homebrew 설치
########################################
if ! command -v brew >/dev/null 2>&1; then
  echo "[setup-mac] Homebrew not found. Installing…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -d "/opt/homebrew/bin" ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "${HOME}/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -d "/usr/local/bin" ]; then
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "${HOME}/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

########################################
# 2. Brewfile 적용
########################################
if [ ! -f "${BREWFILE}" ]; then
  echo "[setup-mac] Brewfile not found at ${BREWFILE}"
  echo "[setup-mac] Create or move your Brewfile there and re-run."
  exit 1
fi

echo "[setup-mac] brew update…"
brew update

echo "[setup-mac] brew bundle --file=${BREWFILE}…"
brew bundle --file="${BREWFILE}"

########################################
# 3. Post steps 안내 (Setapp / Manual)
########################################
cat <<EOF

[setup-mac] ✅ Brew/mas apps 설치 완료.

다음 단계 수동 체크리스트:

1) Setapp
   - Setapp.app 설치/로그인
   - docs/setapp.md 또는 Brewfile의 [Setapp] 섹션 참고해서 앱 설치/활성화

2) App Store
   - mas로 안 들어간 앱은 docs/appstore.md 참고해서 수동 설치

3) Manual / Direct Install
   - docs/manual.md 참고해서 DMG/PKG, 회사 전용 툴 설치

EOF

echo "[setup-mac] Done."