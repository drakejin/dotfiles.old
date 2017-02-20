# drake-jin의 파이썬 환경설정.
그냥  pyenv와 virtualenv, autoenv를 설치하는것..

# 위 세개는 뭐할 때 쓰는건가?

1. pyenv: "Simple Python Version Management", 로컬에 다양한 파이썬 버전을 설치하고 사용할 수 있도록 한다. pyenv를 사용함으로 써 파이썬 버전에 대한 의존성을 해결할 수 있다. 

2. virtualenv: "Virtual Python Environment Builder", 로컬에 다양한 파이선 환경을 구축하고 사용할 수 있도록 한다. 일반적으로 Python Packages 라고 부르는 (pip install을 통해 설치하는) 패키지들에 대한 의존성을 해결할 수 있다. 

3. autoenv: 만약 pyenv와 virtualenv를 통해 의존성을 해결한다고 하더라도 작업할 때 마다 설정해주는 것은 귀찮은 작업이다. 특정 프로젝트 폴더로 들어가면 자동으로 개발 환경을 설정해주는 autoenv라는 스크립트를 활용하도록 하자. 

# 1줄 요약
파이썬 개발할 때 위 세개 도구를 사용하니까 나도 따라서 설치해보고 써보자.(오픈소스 사랑해요.)


# 설치
pyenv, virtualenv, autoenv 순으로 설치할 예정.

  0. requirements
    기본으로 설치해야할 녀석들 from yyuu/pyenv's wiki 
      ``` bash
        sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
      ```


  1. pyenv
yyuu님의 [pyenv](https://github.com/yyuu/pyenv) 오픈소스. 요즘 핫하게 이슈가 달린다. 

  
    - 참조 
      - [pyenv-installer](https://github.com/yyuu/pyenv-installer)
      - pyenv를 설치해야 virtualenv를 설치할 수 있다. 유틸 상호관의 의존성 존재

    - 설치

      ``` bash
#나는 zsh유저니까 bash를 지우고 zsh 로 설치하였다.
$ curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | zsh
      ```

  2. virtualenv 
    - pyenv의 플러그인 으로 설치하기. virtualenv는 pyenv로 설치되기 때문. 
  
    - 참조
      - [pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv)

    - 설치 
    
      1. 기본 설치 
      
        ``` bash
$ echo $(pyenv root) #출력이/home/{user}/.pyenv 가 나오면 성공.
$ git clone https://github.com/yyuu/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv 
        ```

      2. (선택사항) pyenv virtualenv-init 이것을 추가하면 매우 유용하게 쓰일 수 있습니다. [참고](https://github.com/yyuu/pyenv-virtualenv) 에서 Activate virtualenv를 참조하세요. 

        ``` bash
$ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.dotfiles/zshrcCustomValues
$ echo 'eval "$(pyenv init -)"' >> ~/.dotfiles/zshrcCustomValues
$ exec "$SHELL"
        ```
    
    - 사용

      1. Basic Create Virtualenv from Version

        ``` bash
$ pyenv virtualenv 2.7.10 my-virtual-env-2.7.10
$ pyenv version
$ pyenv virtualenv venv34  
        ```

      2. List Existing Virtualenvs    

        ``` bash
$ pyenv shell venv34
$ pyenv virtualenvs  
  miniconda3-3.9.1 (created from /home/yyuu/.pyenv/versions/miniconda3-3.9.1)
  miniconda3-3.9.1/envs/myenv (created from /home/yyuu/.pyenv/versions/miniconda3-3.9.1)  
  2.7.10/envs/my-virtual-env-2.7.10 (created from /home/yyuu/.pyenv/versions/2.7.10)  
  3.4.3/envs/venv34 (created from /home/yyuu/.pyenv/versions/3.4.3)  
  my-virtual-env-2.7.10 (created from /home/yyuu/.pyenv/versions/2.7.10)
* venv34 (created from /home/yyuu/.pyenv/versions/3.4.3)        
         ```
      3. Activate Virtualenv(conda(minoconda,anaconda)환경도 만들어 줄 수 있다.) 
        

  3. autoenv 

    - 참조
      - [autoenv](https://github.com/kennethreitz/autoenv)

    - 설치
      1. git 으로 설치

      ``` bash
$ git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv 
$ echo 'source ~/.autoenv/activate.sh' >> ~/.dotfiles/zshrcCustomValues
$ exec "$SHELL"
      ```

    - 사용

      ``` bash 
$ echo "echo 'whoa'" > project/.env 
$ cd project
whoa
      ```


