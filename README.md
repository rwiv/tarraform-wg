## Indroduction

vutlr 인스턴스 생성 후 docker로 wireguard server를 실행시키는 terraform configuration files


## Getting Started

1. `terraform.example.tfvars`를 `terraform.tfvars`로 수정 후 내용을 채운다.
2. `vutlr-ssh-key` terraform resource 설정을 위해 `ssh-keygen.example`, `ssh-keygen.example.pub`을 `ssh-keygen`, `ssh-keygen.pub`으로 수정 후 내용을 채운다.
3. `scripts` 폴더에서 `init.bat` -> `apply.bat` 순으로 실행한다.
4. 생성된 `wg_url.txt`에 적힌 주소를 브라우저로 접근해 새로운 wireguard peer를 생성한다.
5. 생성한 인프라를 삭제하려면  `scripts` 폴더 내부의 `destroy.bat`을 실행한다.

