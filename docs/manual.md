# Manual / Direct Install

Homebrew / MAS / Setapp 어디에도 안 들어가는 것들

## Company / Security
- Company VPN Client — 링크: ...
- SSO Agent — 링크: ...

## 기타
- ...

03 Cloud & Remote
- C1 iCloud Drive (blue)
- C2 Dropbox (green)
- C3 Git mirrors (optional)
- C4 Prod – main (red, later)
- C5 Stage – sandbox (orange, later)
- C6 Utility server (later)

## ForkLift Sidebar / Favorites

맥 새로 세팅할 때 ForkLift 사이드바는 아래 스펙으로 맞춘다.
즐겨찾기(Favorites)는 항상 다음 세 그룹 구조를 유지한다.

- 01 Core – 로컬 파일 시스템 골격
- 02 Dev – 현재 개발/프로젝트 루트
- 03 Cloud & Remote – 클라우드 스토리지 + 원격 서버
- Tags – 파일/폴더 단위 작업 큐 (Now / Later / ArchiveSoon / Experiment)

Color Label은 ForkLift 기본 8색을 사용한다.

- Gray / Red / Orange / Yellow / Green / Blue / Purple / (None)

### 01 Core (local filesystem skeleton)

Slots (항상 9개, 모든 맥 공통)

- C1 **Home**        → `~/`             (Gray)
- C2 **Desktop**     → `~/Desktop`      (Gray)
- C3 **Dev (root)**  → `~/dev`          (Purple)
- C4 **Documents**   → `~/Documents`    (Green)
- C5 **Downloads**   → `~/Downloads`    (Blue)
- C6 **Pictures**    → `~/Pictures`     (Yellow)
- C7 **Movies**      → `~/Movies`       (Yellow)
- C8 **Music**       → `~/Music`        (Yellow)
- C9 **Applications**→ `/Applications`  (Gray)

Rules

- 01 Core는 **모든 맥에서 100% 동일한 경로만** 사용.
- 새 폴더를 만들어도 Core에는 추가하지 않는다. (커스텀은 Dev/Cloud/Tags에서 해결)

---

### 02 Dev (current workspaces)

Slots (최대 6개)

- D1 **mac-setup**   → `~/dev/mac-setup`   (Purple)
- D2 **infra**       → `~/dev/infra`       (Purple)
- D3 **playground**  → `~/dev/playground`  (Purple)
- D4 **Project – A** → `~/dev/<active-project-1>` (Purple)
- D5 **Project – B** → `~/dev/<active-project-2>` (Purple)
- D6 **Project – C** → `~/dev/<active-project-3>` (Purple)

Rules

- D4–D6은 **현재 활성 프로젝트만** 올린다. 동시에 3개를 넘지 않게 유지.
- 프로젝트가 끝나면:
  - Favorite에서는 제거
  - repo는 `~/dev` 안에 그대로 유지
- Dev 그룹의 Color Label은 **무조건 Purple**만 사용  
  → “보라색이면 코드/프로젝트”라는 규칙 유지.

---

### 03 Cloud & Remote

Slots (최대 6개)

- C1 **iCloud Drive**   → iCloud root              (Blue)
- C2 **Dropbox**        → `~/Dropbox`              (Green)
- C3 **Git mirrors**    → `~/dev/_mirrors` (optional, Gray)
- C4 **Prod – main**    → SFTP prod server (Red, *later*)
- C5 **Stage – sandbox**→ SFTP staging server (Orange, *later*)
- C6 **Utility server** → 기타 SFTP/NAS 등 (Yellow, *later*)

Rules

- C1–C3: 로컬에 sync된 클라우드 루트/저장소.
- C4–C6: 실제 SFTP/NAS 등 **원격 서버**. 서버가 생기기 전까지는 빈 슬롯으로 두거나 만들지 않는다.
- Color conventions:
  - Blue/Green = 클라우드 스토리지
  - Red = Prod (주의)
  - Orange = Stage/Test
  - Yellow = 기타 유틸리티

---

### Tags (Working Sets)

macOS Tag를 작업 큐처럼 사용한다. Finder에서 Tag 이름/색을 아래와 같이 맞춘다.

- **Now**         (Red)   – 이번 주 안에 반드시 처리할 아이템
- **Later**       (Blue)  – 1–4주 안에 처리할 아이템
- **ArchiveSoon** (Yellow)– 정리/삭제 예정
- **Experiment**  (Purple)– 실험/임시, 언제든 삭제 가능

Rules

- 하루에 한 번 정도 ForkLift에서 Tag별로 열어보고 정리:
  - 처리 완료 → Tag 제거, 또는 ArchiveSoon으로 이동
  - Now에 오래 머문 아이템 → Later/ArchiveSoon으로 재분류
- 다른 Tag는 되도록 사용하지 않고, 작업 관리 용도는 이 4개로 통일.

---

### 03 Cloud & Remote

Slots (max 6)

- C1 **iCloud Drive**   → `~/Library/Mobile Documents/com~apple~CloudDocs` (Blue)
- C2 **Dropbox**        → `~/Dropbox`                                (Green)
- C3 **Git mirrors**    → `~/dev/_mirrors` (optional, Gray)
- C4 **Prod – main**    → SFTP prod server (Red, later)
- C5 **Stage – sandbox**→ SFTP staging server (Orange, later)
- C6 **Utility server** → 기타 SFTP/NAS 등 (Yellow, later)

Rules

- C1–C2: 로컬에 sync된 클라우드 스토리지 루트만 올린다.
- C3: git bare repo / mirror 저장소용 (필요할 때만 사용).
- C4–C6: 실제 원격 서버. 서버 정보가 생기기 전에는 슬롯만 예약해 두고 즐겨찾기는 만들지 않는다.
- Color conventions:
  - Blue/Green = 클라우드 스토리지
  - Red = Prod (주의)
  - Orange = Stage/Test
  - Yellow = Utility/기타

  ForkLift 설정은 `~/Library/Preferences/<FORKLIFT_PLIST_NAME>` 파일로 백업/복원한다.
...
예: `~/Library/Preferences//Applications/Visual Studio Code.app`

- ForkLift (Setapp) 설정 복원  
  - `config/ForkLift/com.binarynights.forklift-setapp.plist` 가 존재할 경우에만 동작  
  - 해당 파일을 `~/Library/Preferences/com.binarynights.forklift-setapp.plist` 로 복사해 사이드바 / 즐겨찾기 레이아웃을 복원

### setup-mac.sh가 자동으로 해주는 것

- Homebrew 설치 (없을 경우)
- Brewfile 기반 brew/mas 앱 설치
- ForkLift (Setapp) 설정 복원  
  - `config/ForkLift/com.binarynights.forklift-setapp.plist` 가 존재할 경우에만 동작  
  - 해당 파일을 `~/Library/Preferences/com.binarynights.forklift-setapp.plist` 로 복사해 사이드바 / 즐겨찾기 레이아웃을 복원

### 운영 메모

- ForkLift 설정은 `~/Library/Preferences/com.binarynights.ForkLift4.plist` 파일로 백업/복원한다.
  - 이 파일을 `mac-setup/config/ForkLift/` 아래에 보관.
  - 새 맥 세팅 시 `setup-mac.sh`에서 이 plist를 복사해 Favorites/설정을 복원한다.
- 사이드바 구조를 바꿀 때는:
  1. 여기 스펙를 먼저 수정하고
  2. ForkLift에서 수동으로 맞춘 다음
  3. plist를 다시 백업한다.

  Finder Sidebar / Locations
- iCloud Drive
- suhyunji (Home)
- Macintosh HD
...