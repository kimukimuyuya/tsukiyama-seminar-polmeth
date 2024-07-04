df <- read.csv("utasv.csv", na.strings = c(99, 999), fileEncoding = "SJIS")
df1 <- df[, c("W1Q20_1", "W1Q20_2", "W1Q20_3", "W1Q20_4", "W1Q20_5", "W1Q20_6", "W1Q20_7")]
df2 <- na.omit(df1)
res <- kmeans(df2, centers = 3)
df2$cluster <- res$cluster
tapply(df2$W1Q20_1, df2$cluster, mean, na.rm = TRUE)#自由〔個人が意のままに行動したり考えたりできること〕
tapply(df2$W1Q20_2, df2$cluster, mean, na.rm = TRUE)#平等〔成功する機会をすべての人々が等しくもつこと〕
tapply(df2$W1Q20_3, df2$cluster, mean, na.rm = TRUE)#経済的安定〔安定した職や適正な収入が保障されること〕
tapply(df2$W1Q20_4, df2$cluster, mean, na.rm = TRUE)#道徳〔大多数の人々が同意するしきたりに従って生活すること〕
tapply(df2$W1Q20_5, df2$cluster, mean, na.rm = TRUE)#自助努力〔政府や他の団体の助けを借りずに，自分自身で成功をつかみとること〕
tapply(df2$W1Q20_6, df2$cluster, mean, na.rm = TRUE)#社会秩序〔法令が尊重された秩序ある平和な社会で暮らせること〕
tapply(df2$W1Q20_7, df2$cluster, mean, na.rm = TRUE)#愛国心〔個人的な利害を超え、わが国全体に敬意を払い、国のために行動すること〕
table(df2$cluster)
