

library(reshape2);
library(ggplot2);


#数据读入
data <- read.table("example.bf.txt", sep=";", header=T, row.names=1, quote="");
data<-as.matrix(data);
data<-as.data.frame(data);
#is.matrix(data);

# 增加行的名字
rownames(data)<- c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20","chr21","chr22")

# 增加列的名字
colnames(data) <- paste("ID1","ID2","ID3","ID4","ID5","ID6","ID7","ID8","ID9","ID10","ID11","ID12","ID13","ID14","ID15","ID16","ID17","ID18","ID19","ID20")

#增加一列ID列，保存行名字
data$ID <- rownames(data)

# melt：把正常矩阵转换为长表格模式的函数。工作原理是把全部的非id列的数值列转为1列，命名为value；所有字符列转为variable列。
# id.vars 列用于指定哪些列为id列；这些列不会被merge，会保留为完整一列。
data_m <- melt(data, id.vars=c("ID"))
head(data_m)

p <- ggplot(data_m, aes(x=variable,y=ID)) + xlab("samples") + theme_bw() + theme(panel.grid.major = element_blank()) + theme(legend.key=element_blank())  + theme(axis.text.x=element_text(angle=45,hjust=1, vjust=1)) + theme(legend.position="top") +  geom_tile(aes(fill=value)) + scale_fill_gradient(low = "white", high = "red")

# 可以跟输出文件不同的后缀，以获得不同的输出格式
# colormode支持srgb （屏幕）和cmyk （打印，部分杂志需要，看上去有点褪色的感觉）格式
ggsave(p, filename="heatmap.pdf", width=10, height=15, units=c("cm"),colormodel="srgb")


