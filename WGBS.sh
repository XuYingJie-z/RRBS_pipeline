#!/usr/bin/bash

help() {
    echo "Usage:"
    echo "test.sh [-f forward_fq] [-r reverse_fq] [-g reference]"
    echo "Description:"
    echo "-f forward_fq,the path of forward_fq,fq.gz also can be use."
    echo "-r reverse_fq,the path of reverse_fq,fq.gz also can be use."
    echo "-g the path of reference genome"
    exit -1
}

while getopts 'f:r:g:' OPT; do
    case $OPT in
        f) forward_fq="$OPTARG";;
        r) reverse_fq="$OPTARG";;
        g) reference="$OPTARG";;
        h) help;;
        ?) help;;
    esac
done

if [ -z $forward_fq ] || [ -z $reverse_fq ] || [ -z $reference ]; then
  echo 'error,need args'
  help
  exit
fi

## creat folder

#folder=(rawdata fastqc cutadapt trim mapping call_site)
for  i in ${folder[*]} ; do
  if [ ! -d ../$i ]; then
    mkdir ../$i
    echo creat $i
  fi
done

sample=$(basename $forward_fq)
echo $sample


fastqc -o ../fastqc $forward_fq $reverse_fq

icutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o ../cutadapt/SRR3225601_cuta_1.fq.gz -p ../cutadapt/SRR3225601_cuta_2.fq.gz  SRR3225601_1.fastq.gz SRR3225601_2.fastq.gz
