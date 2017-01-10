# StudySimpleProject
This project is for  developer of first starter


# 작업을 위한 환경을 구축해봅시다.


1.  깃헙에서 새 프로젝트를 등록한다.
2.  내 로컬 컴퓨터에서 깃헙에 등록된 프로젝트를 불러온다.
3. 깃헙 프로젝트는 git bash 라는 프로그램을 열어서 콘솔창으로 불러오면 된다.
>git clone https://github.com/Likemilk/StudySimpleProject

4. 그리고 테스트 겸사echo.js 를 만들어서
``` nodejs
console.log("야호야호")
for(let i=0;i<10;i++){
    console.log(i);
}
```
이 소스코드를 실행해 봅시다.

터미널에서 node echo.js 를 하면 다음과 같이 실행을 해보고 잘 되는것을 확인했다면

>$ git add .      #현재 디렉토리 전부를 메모리에 로딩
>
>$ git commit -m "first commit" #메모리에 로딩된것을 현재 넘버의 커밋으로 이전

>$ git push origin master  #깃 리파짓토리 서버에 저장.

>
