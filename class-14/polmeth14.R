utasv_cor <- read.csv("utasv.csv", na.strings=c("999"), fileEncoding = "SJIS")
cor.test(utasv_cor$W1Q15_1, utasv_cor$W1Q15_9)
# 事前分析として、多重共線性の確認として用いる
df1 <- utasv_cor[, c("W1Q15_1", "W1Q15_2", "W1Q15_3", "W1Q15_9", "W1Q15_10", "W1Q15_11")]
res1 <- cor(df1, use = "pairwise.complete.obs")