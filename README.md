# 길가온
<img src="https://user-images.githubusercontent.com/66459715/212446413-9aa9e540-5d80-42b4-b32e-9501727ea4eb.png" width="800"></img>

> 되새김은 여행을 계획하고, 여행을 떠나서 일정과 지출을 관리하고 다이러리도 작성해 실용성과 추억관리 두마리 토끼를 모두 잡은 애플리케이션 입니다.

![Swift](https://img.shields.io/badge/swift-v5.7-orange?logo=swift) 
![Xcode](https://img.shields.io/badge/xcode-v14.0-blue?logo=xcode)
![SnapKit](https://img.shields.io/badge/SnapKit-v5.6.0-green)

#### 프로젝트기간 
- 12.19 ~ 12.23


## 주요 기능

### ✈️ 친구추가
- 내용작성

### 💰 일정추가 
- 내용작성 

### 일정 작성
- 제목 내용 사진 친구 위치 입력받는 내용

### 달력
- 언제 일정 추가해쓴ㄴ지 알수 잇따

## 동작화면

|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|
|:-:|:-:|:-:|:-:|
|`스플래시뷰`|`온보딩뷰`|`로그인 및 회원가입`|`친구추가`|
|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|<img src="https://github.com/APPSCHOOL1-REPO/mvp-20221216-lab03/blob/main/screenshot/13.png"></img>|
|`글 작성`|`달력 확인`|`서랍함 확인`|`로그아웃`|

## Test
|<img src="https://user-images.githubusercontent.com/66459715/212446413-9aa9e540-5d80-42b4-b32e-9501727ea4eb.png" width="800"></img>|<img src="https://user-images.githubusercontent.com/66459715/212446416-b0edc9c0-3b0c-41bb-829e-9ad17aa863b0.png" width="800"></img>|
|:-:|:-:|
|`프로토타입`|`UI Flow`|

## 프로젝트 구조

> 길가온에서 사용하고있는 프로젝트 구조입니다.

<!-- <img src="https://user-images.githubusercontent.com/76734067/207780104-3a489812-6340-46bd-8087-56a2bd7cb229.png"> -->

- 애플리케이션의 구조가 크기 않아 코디네이터 패턴이나 클린아키텍쳐의 필요성을 느끼지 못했습니다.
- `MVVM`만으로도 저희 애플리케이션을 충분히 유지보수할 수 있다고 생각하여 `MVVM` 디자인 패턴을 선택하였습니다.

## 기술 스택

### 💿 Firebase
- Auth: 회원가입 및 로그인
- FireStore: 유저 정보 및 게시글 데이터 저장
- FireStorage: 프로필 및 다이어리 사진 저장 

### 🧭 Lottie
- 온보딩 뷰와 로그인 뷰의 벚꽃 애니메이션
- 스플래시 뷰의 벚꽃나무 애니메이션

### 🙈 CoreLocation, MapKit
- 위치 권한 설정과 사용자의 현재위치 받아오기
- TMapAPI로부터 받은 정보로 Map Annotation을 사용하여 지도에 표시

### TMapAPI
- 사용자가 검색해 나온 위치정보를 받아옴

## 팀 소개

|김민호|정세훈|전준수|한주희|
|:-:|:-:|:-:|:-:|
|<img src="https://avatars.githubusercontent.com/u/66459715?v=4" width=100>|<img src="https://avatars.githubusercontent.com/u/108966759?v=4" width=100>|<img src="https://avatars.githubusercontent.com/u/114235515?v=4" width=100>|<img src="https://avatars.githubusercontent.com/u/107897929?v=4" width=100>|
|[@stealmh](https://github.com/stealmh)|[@NewHooon](https://github.com/NewHooon)|[@JIN-JJS](https://github.com/JIN-JJS)|[@Zooey-Han](https://github.com/Zooey-Han)|
