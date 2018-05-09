#!/bin/bash




#参数读取
while [ -n "$1" ]; do
    case "$1" in
        -t)
            debdir="$2"
            shift
            ;;
        -c)
            control="$2"
            shift
            ;;
        *)
            echo "unknow pramater".
            exit 0
            ;;
    esac
    shift
done


mydir=`pwd`
#accuritydir=/simm/home/kaihui/sunset/purity
accuritydir=/home/ukaihui/purity
allexecfile='accurity normalize plot_coverage_after_normalization.py recall_precision segment_mean_var GADA plotCPandMCP.py plot_GC_normalization.py plot_snp_maf_exp.py bicseq infer main.py plot_snp_maf_peak.py regression.R snp_calling binary_to_bicseq plot.all.R plot.tre.autocor.R regression_safe2.R plot_autocor_diff.py plot_tre.py regression_safe.R'






#制作目录树
mkdir -p $debdir
cd $debdir
rm accurity.deb
mkdir -p usr/share/accurity
mkdir -p usr/share/doc/accurity
mkdir -p usr/bin
mkdir DEBIAN



#编译源码
cd $accuritydir &&make
cd $debdir



#复制deb包所需文件
cd $accuritydir/Accurity &&  cp $allexecfile -t $debdir/usr/share/accurity
cd ../ && cp LICENSE -t $debdir/usr/share/doc/accurity
cd $debdir/usr/bin && ln -s  ../share/accurity/main.py accurity
cp $control -t $debdir/DEBIAN

#打包
cd $debdir
dpkg-deb -b ./  $debdir.deb


#清除过程文件
rm -r usr
rm -r DEBIAN

#整理文件
mv $debdir.deb ../
rm -r $debdir

#返回原目录
cd $mydir





