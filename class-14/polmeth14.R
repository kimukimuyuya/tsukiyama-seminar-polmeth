utasv_cor <- read.csv("utasv.csv", na.strings=c("999"), fileEncoding = "SJIS")
cor.test(utasv_cor$W1Q15_1, utasv_cor$W1Q15_9)
# 事前分析として、多重共線性の確認として用いる
df1 <- utasv_cor[, c("W1Q15_1", "W1Q15_2", "W1Q15_3", "W1Q15_9", "W1Q15_10", "W1Q15_11")]
res1 <- cor(df1, use = "pairwise.complete.obs")
# 主成分分析
utasv_pca <-read.csv("utasv.csv", na.strings=c("999"), fileEncoding = "SJIS")
utasv_pca[58, 1] <- 99

df2 <- utasv_pca[, c("ID", "W1Q16_1", "W1Q16_2", "W1Q16_3")]
df3 <- na.omit(df2) # 欠損値を除外する
df4 <- df3[, 2:4] # ID列は主成分分析に用いないので一旦除外する
res2 <- princomp(df4, cor = TRUE)
res3 <- summary(res2)
res3
res2$loadings
res3[["sdev"]]^2 / sum(res3[["sdev"]]^2)
df3$comp1 <- res2$scores[, 1] # 第１主成分得点をID含むdf3へ追加
## 元のデータに主成分分析の結果を結合する
## merge()関数でall.x = TRUEとして、第一引数のデータを残して結合
utasv_pca <- merge(utasv_pca, df3, by = "ID", all.x = TRUE)