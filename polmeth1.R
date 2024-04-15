wages <- read.csv("wages2017.csv", fileEncoding = "SJIS")
mean(wages$Ｄ建設業, na.rm = TRUE)

var(wages$Ｄ建設業, na.rm = TRUE)
sd(wages$Ｄ建設業, na.rm = TRUE)
sd(wages$Ｇ情報通信業, na.rm = TRUE)

library(psych)

describe(wages[, -1])

res <- describe(wages[, -1])
write.csv(res, "res.csv", fileEncoding = "SJIS")