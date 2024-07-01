df <- read.csv("utasp.csv", na.strings = c(99, 999), fileEncoding = "SJIS")
df1 <- subset(df, PARTY == 1 & SEX == 2)
# クラスター分析に用いる変数列のみを抽出
df2 <- df1[, c("NAME", "Q4_1", "Q4_5", "Q4_6", "Q4_9", "Q4_12", "Q4_14", "Q4_15")]
df2 <- na.omit(df2) # 欠損値を含む行は削除
df3 <- df2[, -1] # 氏名を一旦削除
## 距離行列を計算する
df4 <- dist(df3)

res1 <- hclust(df4, method = "ward.D2")
plot(res1, hang = -1, labels = df2$NAME)
cutree(res1, k = 3)
df2$cluster <- cutree(res1, k = 3)

df5 <- subset(df, PARTY == 1)
df6 <- df5[, c("Q4_1", "Q4_5", "Q4_6", "Q4_9", "Q4_12", "Q4_14", "Q4_15")]
df7 <- na.omit(df6)
## kmeansではデータフレームをそのまま第一引数に投入する
res2 <- kmeans(df7, centers = 3)
## 分類結果はclusterに格納されている
df7$CLUSTER <- res2$cluster
df7$CLUSTER
tapply(df7$Q4_1, df7$CLUSTER, mean, na.rm = TRUE)
