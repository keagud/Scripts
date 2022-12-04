#/usr/bin/bash


includes=(stdio stdlib stdbool)

mainargs=void




target="$1.c"
if [[ -f "$target" ]]; then
  echo "$target already exists!";
  exit 1
fi

touch $target

fileadd(){
  echo "$@" >> $target
}

blankline(){

  for (( i=0; i<$1; i++ )); do
    echo "" >> $target;
  done

}

fileadd "/* $(date -I) */ "
blankline 2

for line in "${includes[@]}"; do
  fileadd "#include <$line.h>" 
done

blankline 2

fileadd "int main($mainargs){ return 0; }"
indent $target -linux -nut -i2 -ss





