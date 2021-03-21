#!/bin/bash

cd /public1/home/sc60357/practice/rrbs/rawdata

icutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o ../cutadapt/SRR3225601_cuta_1.fq.gz -p ../cutadapt/SRR3225601_cuta_2.fq.gz  SRR3225601_1.fastq.gz SRR3225601_2.fastq.gz

cat config.txt |while read i;do arr=($i)
    fq1=${arr[1]}
    fq2=${arr[2]}
    sample=${arr[0]}
    if [[ $fq2 != "SRR3225601.1_2.fastq.gz" ]] ;
        then
            echo 'no means'
            ## -threads调用线程数
            trimmomatic PE -threads 2 -phred33 ../cutadapt/$sample"_cuta_1.fq.gz"  ../cutadapt/$sample"_cuta_2.fq.gz" ../trim/$sample"_trim_1.fq.gz" ../trim/$sample"_unpair_1.fq.gz"  ../trim/$sample"_trim_2.fq.gz" ../trim/$sample"_unpair_2.fq.gz"  CROP:50
        fi
    ## -t 指定线程数
    fastqc -t 2 $fq1 $fq2 -o ../fastqc
    ## -j 指定调用核心数
    cutadapt -j 2 -a AGATCGGAAGAG -A AGATCGGAAGAG -o ../cutadapt/$sample"_cuta_1.fq.gz" -p .cutadapt/$sample"_cuta_2.fq.gz" $fq1 $fq2

done
