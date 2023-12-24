# 실행법

1. `terraform.example.tfvars`를 `terraform.tfvars`로 수정 후 내용을 채운다.
2. `ssh-keygen.example`, `ssh-keygen.example.pub`을 `ssh-keygen`, `ssh-keygen.pub`으로 수정 후 내용을 채운다.
3. `init.bat` -> `apply.bat` 순으로 실행한다.
4. 생성된 `wg_url.txt`을 브라우저로 접근해 새로운 피어를 생성한다.
5. 생성한 인프라를 삭제하려면 `destroy.bat`을 실행한다.
