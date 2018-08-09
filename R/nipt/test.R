##========  Read samples' data in our format  =========##

x0=read.table("example_sampledata.txt",T); ## the last three samples in the file are T21, T18 and T13.

## Format specification: each line stands for a 100 kb bin; each column stands for an individual (except for the first 5 columns).
## First 5 columns: 1st column is the chromosome of bin; 2nd column is the start position of bin; 3rd column is the end position of bin; 4th column is the GC content of bin; 5th column is the number of non-N bases of bin. 
## The other columns: the number of uniquely mapped reads in each bin. 


##==  Remove bins with populational or maternal CNV ===##

i1=scan('selected.index.of.100kbin.txt'); ## this selection of 100kb bins is specific for Chinese population

chrz=x0[i1,1];
posz=x0[i1,2];
gcz=x0[i1,4];



##================= Normalization =====================##

## The remaining bins were normalized by their mean coverage.

normalize_coverage= function(m) {
	cx=apply(m, 2, mean); 
	mr=apply(m,1,function(x) {x=x/cx;});
    return(t(mr)); 
}

zz=normalize_coverage(x0[i1,6:dim(x0)[2]]); ## zz is the normalized data

zm=apply(zz,1,mean); 
zv=apply(zz,1,sd); 



##===== Control for GC bias and chromosomal bias ======##

smoother=function(x,g) {
	ord=order(g); 
	dro=c(1:length(g))[order(ord)] ##reverse order;  
	t=smooth.spline(x[ord]); 
	t$y[dro]; 
}

za=zz[chrz<23,]
ga=gcz[chrz<23]
zs=sapply(c(1:dim(za)[2]), function(i) {za[,i]-smoother(za[,i], ga);}); ## control GC bias by smoothing spline method 


## regress out the mean
zsm=apply(zs,1,mean)
zsv=apply(zs,1,sd)
zs2=apply(zs,2, function(x) {fit=lm(x~zsm, weights=1/zsv); fit$residuals;}) ## control chromosomal bias by weighted linear regression.



##====  Compute chromosome dosage using bin dosage =====##

ch=chrz[chrz<23];
hh=apply(zs2,2,function(x){sapply(c(1:22), function(i){kk=which(i==ch); mean(x[kk]); })})



##================  Compute Z score   ==================##

zd1=apply(hh,1, mean); 
zd2=apply(hh,1, sd); 
zscore=apply(hh,2, function(x){(x-zd1)/zd2})



##================ Compute Bayes Factor ================##
 
 bf_beta2=function(z,h) {
 	s1 = h/z;
	if(s1< 0.002) {
		s1=0.002;
	}
	a0=44.6;b0=4628.4;  
	a1=1.1;b1=20.8;   
	f0=function(x) {dnorm(x,h,s1) * dbeta(x,a0,b0,0);} ## The priors for the null model are Beta(x; 44:6; 4628:4)
	f1=function(x) {dnorm(x,h,s1) * dbeta(x,a1,b1,0);} ## The priors for the alternative model are Beta(x; 1:1; 20:8)
	bf0= integrate(f0,lower=0.0,upper=0.1);
	bf1= integrate(f1,lower=0.0,upper=0.6);
	return((log10(bf1$value)-log10(bf0$value)));
}


bf=hh-hh; 
for(i in c(1:22)) {
	for(j in c(1:dim(zscore)[2])) {
		h2=ifelse(abs(hh[i,j])<0.005, 0.01, abs(hh[i,j])*2);
		bf[i,j]=bf_beta2(abs(zscore[i,j]),h2);
}}

      
write.table(bf,"example.bf.txt",col.names=F,row.names=F);
write.table(zscore,"example.zscore.txt",col.names=F,row.names=F);
write.table(hh,"example.hh.txt",col.names=F,row.names=F);


