utasv_pca <- read.csv("utasv.csv", na.strings = c("66", "99", "NA"), fileEncoding = "SJIS")
df1 <- utasv_pca[, c("W1Q16_1", "W1Q16_2", "W1Q16_3", "W1Q16_4", "W1Q16_5", "W1Q16_6", "W1Q16_7", "W1Q16_8", "W1Q16_9"
, "W1Q16_10", "W1Q16_11", "W1Q16_12", "W1Q16_13", "W1Q16_14", "W1Q16_15", "W1Q16_16", "W1Q16_17")]
res1 <- cor(df1, use = "pairwise.complete.obs")
utasv_pca[58, 1] <- 99

df2 <- utasv_pca[, c("ID","W1Q16_12", "W1Q16_13", "W1Q16_17")]
df3 <- na.omit(df2)
df4 <- df3[, 2:4]

res2 <- princomp(df4, cor = TRUE)
res3 <- summary(res2)
res3

res2$loadings

df3$comp1 <- res2$scores[, 1]
utasv_pca <- merge(utasv_pca, df3, by = "ID", all.x = TRUE)

boxplot(utasv_pca$comp1 ~ utasv_pca$W2Q21, xlab = "左右イデオロギー", ylab ="排他-受容的価値観")