utasp <- read.csv("utasp.csv", na.strings = c("99", "999"), fileEncoding = "SJIS")

utasp <- subset(utasp, utasp$PR == 0)

utasp$WIN <- 0
utasp$WIN[utasp$RESULT == 2 | utasp$RESULT == 3] <- 1

utasp$LDP <- 0
utasp$LDP[utasp$PARTY == 1] <- 1

# 二項ロジット分析
result <- glm(WIN ~ TERM + LDP, data = utasp, family = binomial(link = "logit"))
summary(result)