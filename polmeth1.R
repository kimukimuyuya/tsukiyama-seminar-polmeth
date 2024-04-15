wages <- read.csv("wages2017.csv", fileEncoding = "SJIS")
mean(wages$Ｄ建設業, na.rm = TRUE)

#分散の計算
var(wages$Ｄ建設業, na.rm = TRUE)

#標準偏差の計算
sd(wages$Ｄ建設業, na.rm = TRUE)
sd(wages$Ｇ情報通信業, na.rm = TRUE)

library(psych)

describe(wages[, -1])

res <- describe(wages[, -1])
write.csv(res, "res.csv", fileEncoding = "SJIS", row.names = FALSE)

wages2022 <- read.csv("wages2022.csv", fileEncoding = "SJIS")
res2 <- describe(wages2022[, -1])
write.csv(res2, "res2.csv", fileEncoding = "SJIS")