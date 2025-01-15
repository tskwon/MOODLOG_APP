# MOODLOG_APP

this is a MOOD_LOG_APP, which is an everyday diary app.

# GitHub에서 저장소를 Clone하고 작업 디렉토리로 이동
mkdir filename                   # 새 디렉토리 생성
cd filename                      # 디렉토리로 이동
git clone https://github.com/tskwon/MOODLOG_APP.git  # 저장소 Clone
cd MOODLOG_APP                   # Clone된 저장소로 이동

# 새로운 브랜치 생성 및 이동
git checkout -b ANG  # 새 브랜치 생성 및 이동
# 브랜치 이름은 원하는 대로 설정 가능 (여기서는 "ANG")

# 코드 작성 후, 수정된 모든 파일 상태 확인
git status                        # 수정된 파일 확인

# 수정된 파일을 스테이징 영역에 추가
git add .                         # 모든 수정 파일 추가 ('.'은 모든 파일을 의미)

# 변경 사항을 커밋
git commit -m "작업 내용 설명"     # 변경 내용에 대한 커밋 메시지 작성

# 새 브랜치를 원격 저장소에 Push
git push origin feature/new-feature  # 로컬 브랜치를 원격 저장소로 Push

# 이후 GitHub 페이지에서 Pull Request 생성 및 Merge 작업 수행
# 1. GitHub 저장소에서 Pull Request 버튼을 클릭하여 병합 요청
# 2. 기본 브랜치(main)로 Merge 후 작업 종료

# 병합이 완료된 후, 로컬 브랜치로 병합 내용 가져오기
git checkout main                # 기본 브랜치로 이동
git pull origin main             # 최신 병합 내용을 로컬에 가져오기

# 필요 시 작업 완료된 브랜치 삭제
git branch -d feature/new-feature  # 로컬 브랜치 삭제
git push origin --delete feature/new-feature  # 원격 브랜치 삭제 (선택 사항)
