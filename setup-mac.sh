#!/usr/bin/env bash
set -euo pipefail

# macOS clean install 후 기본 개발 환경을 한 번에 세팅하는 스크립트
# - 1) Homebrew 설치
# - 2) Brewfile 기반 앱 설치 (brew/mas)
# - 3) Setapp / App Store / Manual 설치 체크리스트 출력
# - 4) (옵션) ForkLift 설정 복원
#
# NOTE: 이 스크립트는 repo 루트에 있다고 가정한다.
#       SCRIPT_DIR / REPO_ROOT는 다른 스크립트에서 재사용 가능.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${SCRIPT_DIR}"         # 현재 repo 루트 (setup-mac.sh가 위치한 곳)
BREWFILE="${SCRIPT_DIR}/Brewfile" # repo 루트 기준 Brewfile 경로 (원하면 상대 경로로 바꿔도 됨)
echo "[setup-mac] Starting…"

########################################
# 1. Homebrew 설치
########################################
if ! command -v brew >/dev/null 2>&1; then
	echo "[setup-mac] Homebrew not found. Installing…"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if [ -d "/opt/homebrew/bin" ]; then
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"${HOME}/.zprofile"
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [ -d "/usr/local/bin" ]; then
		echo 'eval "$(/usr/local/bin/brew shellenv)"' >>"${HOME}/.zprofile"
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

########################################
# ForkLift (Setapp)
# - Setapp 버전 ForkLift의 설정(plist)을 repo에 백업해 두고
#   새 맥에서 setup-mac.sh 실행 시 자동으로 복원한다.
# - plist 파일 이름은 Setapp 기준: com.binarynights.forklift-setapp.plist
# - REPO_ROOT/config/ForkLift/ 아래에 백업된 파일이 있을 때만 동작한다.
########################################
FORKLIFT_PLIST_NAME="com.binarynights.forklift-setapp.plist"
FORKLIFT_PLIST_SRC="$REPO_ROOT/config/ForkLift/$FORKLIFT_PLIST_NAME"
FORKLIFT_PLIST_DST="$HOME/Library/Preferences/$FORKLIFT_PLIST_NAME"

# 백업된 plist가 존재하는 경우에만 덮어쓴다 (안전 가드)
if [ -f "$FORKLIFT_PLIST_SRC" ]; then
	echo "[setup-mac] Restoring ForkLift preferences from $FORKLIFT_PLIST_SRC → $FORKLIFT_PLIST_DST"
	cp "$FORKLIFT_PLIST_SRC" "$FORKLIFT_PLIST_DST"
fi
