# 길가온

<img src="https://user-images.githubusercontent.com/66459715/212460340-fb19a7c5-2ce2-430b-85c5-dc29a4e01fc8.png" width=600px height=600px></img>

> 길가온은 방문했던 장소와 경로를 기록으로 남길 수 있습니다. <br>
> 하루 일정을 기록하는 방법을 고민하다 방문한 장소, 함께한 친구와 사진을 통해 기록을 남겨 그날의 일정을 보관할 수 있도록 도와주는 앱입니다.

<br>
<br>

## ⭐️ 주요 기능

### 👫 친구추가 및 삭제
- 일정에 함께 할 친구를 추가합니다.
- 추가된 친구와 일정을 공유할 수 있습니다. (현재진행중)

### 📌 일정추가 
- 일정의 이름을 추가해 이후 세부 일정작성이 가능합니다.

### 📝 일정 작성
- 위치, 사진 및 함께한 친구를 일정에 기록할 수 있습니다.
- 방문한 장소마다 일정 작성이 가능합니다.

### 📆 달력
- 일정을 추가한 일자를 확인할 수 있습니다.
- 일자에 세부내용을 확인할 수 있습니다.(현재진행중)

### 📬 서랍함 확인
- 사용자가 완료한 일정을 볼 수 있는 기능입니다.
- 지도상에서 그날의 기록한 일정을 한눈에 확인할 수 있습니다.
- 마커 별 상세 내용 확인 및 그날의 장소이동을 볼 수 있습니다.
<br>
<br>

## 동작화면

|<img src="https://user-images.githubusercontent.com/66459715/212461058-7d826c1c-ede1-424f-a085-e3dae9d0e4d6.gif"></img>|<img src="https://user-images.githubusercontent.com/66459715/212460978-00bc7002-5789-4701-8097-8128eec6d8a7.gif"></img>|<img src="https://user-images.githubusercontent.com/66459715/212460853-c9a157b1-c503-44dc-8002-599982494fc7.gif"></img>|<img src="https://user-images.githubusercontent.com/66459715/212460873-6b7650a4-7e58-49dc-8a5f-0d700c68a8ec.gif"></img>|
|:-:|:-:|:-:|:-:|
|`스플래시뷰`|`온보딩뷰`|`로그인 및 회원가입`|`친구추가`|
|<img src="https://user-images.githubusercontent.com/66459715/212461203-b4fa4d81-e076-4d3d-ac3d-e574af8f6bc9.gif"></img>|<img src="https://user-images.githubusercontent.com/66459715/212461149-1886063d-cec2-43fc-84d1-9d794ae453a1.gif"></img>|<img src="https://user-images.githubusercontent.com/66459715/212461214-386da816-a8cd-48e6-aeaf-dad153d6d6d8.gif"></img>|<img src="https://user-images.githubusercontent.com/66459715/212460674-c05845fd-3a28-4dda-9adc-e75af4ab57e3.gif"></img>|
|`글 작성`|`달력 확인`|`서랍함 확인`|`로그아웃`|

<br>
<br>
<br>

## 사용자 시나리오 및 UI 흐름도
|<img src="https://user-images.githubusercontent.com/66459715/212446413-9aa9e540-5d80-42b4-b32e-9501727ea4eb.png" width="800"></img>|<img src="https://user-images.githubusercontent.com/66459715/212446416-b0edc9c0-3b0c-41bb-829e-9ad17aa863b0.png" width="800"></img>|
|:-:|:-:|
|`프로토타입`|`UI Flow`|

<br>
<br>

## 기술 스택

![Swift](https://img.shields.io/badge/swift-v5.7-orange?logo=swift) 
![Xcode](https://img.shields.io/badge/xcode-v14.2-blue?logo=xcode)

### 💿 Firebase
- Auth: 회원가입 및 로그인
- FireStore: 유저 정보 및 게시글 데이터 저장
- FireStorage: 프로필 및 다이어리 사진 저장 

### 🧭 Lottie
- 온보딩 뷰와 로그인 뷰의 벚꽃 애니메이션
- 스플래시 뷰의 벚꽃나무 애니메이션

### 🗺 CoreLocation, MapKit
- 위치 권한 설정과 사용자의 현재위치 받아오기
- TMapAPI로부터 받은 정보로 Map Annotation을 사용하여 지도에 표시

### TMapAPI
- 사용자가 검색해 나온 위치정보를 받아옴

<br>
<br>

## 트러블 슈팅

- 추후 이슈를 해결하면서 작성 예정

<br>
<br>


## 🌸 팀 소개

|김민호|정세훈|전준수|한주희|
|:-:|:-:|:-:|:-:|
|<img src="https://avatars.githubusercontent.com/u/66459715?v=4" width=100>|<img src="https://avatars.githubusercontent.com/u/108966759?v=4" width=100>|<img src="https://avatars.githubusercontent.com/u/114235515?v=4" width=100>|<img src="https://avatars.githubusercontent.com/u/107897929?v=4" width=100>|
|[@stealmh](https://github.com/stealmh)|[@NewHooon](https://github.com/NewHooon)|[@JIN-JJS](https://github.com/JIN-JJS)|[@Zooey-Han](https://github.com/Zooey-Han)|

<br>

## 🛠 프로젝트기간 
- 12.19 ~ 12.23

