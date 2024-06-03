utasp <- read.csv("utasp.csv", na.strings = c("99", "999"), fileEncoding = "SJIS")

utasp <- subset(utasp, utasp$PR == 0)

utasp$WIN <- 0
utasp$WIN[utasp$RESULT == 2 | utasp$RESULT == 3] <- 1

utasp$LDP <- 0
utasp$LDP[utasp$PARTY == 1] <- 1

# 二項ロジット分析
# result <- glm(WIN ~ TERM + LDP, data = utasp, family = binomial(link = "logit"))
result <- glm(WIN ~ TERM + LDP + AGE + I(AGE^2), data = utasp, family = binomial(link = "logit"))
summary(result)

max(utasp$AGE)
min(utasp$AGE)


# 予測確立のプロット

b <- coef(result)
print(b)
print(utasp$TERM)
pr <- numeric()
for (i in 25:80) {
  prd <- exp(b[1] + b[2] * utasp$TERM + b[3] * utasp$LDP + b[4] * i + b[5] * I(i^2)) / (1 + exp(b[1] + b[2] * utasp$TERM + b[3] * utasp$LDP + b[4] * i + b[5] * I(i^2)))
  mprd <- mean(prd, na.rm = T)
  pr <- append(pr, mprd)
}

matplot(c(25:80), pr, type = "b", pch = 20, xlab = "年齢", ylab = "当選確率")


