# MOODLOG_APP 작업 가이드

## 1. 저장소 Clone 및 작업 디렉토리 이동

```bash

# 처음 시작할때
mkdir filename                   # 새 디렉토리 생성
cd filename                      # 디렉토리로 이동
git clone https://github.com/tskwon/MOODLOG_APP.git  # 저장소 Clone
cd MOODLOG_APP                   # Clone된 저장소로 이동

# GitHub에서 저장소를 Clone하고 작업 디렉토리로 이동

# 브랜치 이름은 원하는 대로 설정 가능 (여기서는 "ANG")
git checkout -b ANG # 새 브랜치 생성 및 이동


# 코드 작성 후, 수정된 모든 파일 상태 확인
git status # 수정된 파일 확인

# 수정된 파일을 스테이징 영역에 추가
git add . # 모든 수정 파일 추가 ('.'은 모든 파일을 의미)

# 변경 사항을 커밋
git commit -m "작업 내용 설명" # 변경 내용에 대한 커밋 메시지 작성

# Git Credential Manager 활성화
git config --global credential.helper store # 최초 한번만 username, password 작성

# 새 브랜치를 원격 저장소에 Push
git push origin ANG # 로컬 브랜치를 원격 저장소로 Push
```

## 2. 프로젝트 생성 후

```bash
git checkout main            # main 브랜치로 이동
git pull origin main         # 최신 변경 사항 가져오기

# 코드 작성 후, 수정된 모든 파일 상태 확인
git status # 수정된 파일 확인

# 수정된 파일을 스테이징 영역에 추가
git add . # 모든 수정 파일 추가 ('.'은 모든 파일을 의미)

# 변경 사항을 커밋
git commit -m "작업 내용 설명" # 변경 내용에 대한 커밋 메시지 작성

# Git Credential Manager 활성화
git config --global credential.helper store # 최초 한번만 username, password 작성

# 새 브랜치를 원격 저장소에 Push
git push origin ANG # 로컬 브랜치를 원격 저장소로 Push
```

## 3. 자신의 브랜치를 main 브랜치에 병합

```bash
git checkout {branch_name}   # {branch_name}  브랜치로 이동
git rebase main              # {branch_name}  브랜치를 main 브랜치 위로 재배치

# 충돌 발생시
git add 충돌_파일
git rebase --continue

# main branch 에 자신의 브랜치 병합
git checkout main            # main 브랜치로 이동
git merge {branch_name}      # Rebase된 {branch_name}를 main에 병합

# 깃허브 저장소에 main 브랜치 Push
git push origin main         # main 브랜치에 변경 사항 Push

```
