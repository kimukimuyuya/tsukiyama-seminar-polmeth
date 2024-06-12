utasv <- read.csv("utasv.csv", na.strings = c("99", "999"), fileEncoding = "SJIS")

utasv$vote <- NA
utasv$vote[utasv$W1Q2 == 66 | utasv$W1Q2 == 90 ] <- 0
utasv$vote[utasv$W1Q2 == 1 | utasv$W1Q2 == 4] <- 1 #与党
utasv$vote[utasv$W1Q2 == 2 | utasv$W1Q2 == 3 | (utasv$W1Q2 >= 5 & utasv$W1Q2 <= 9)] <- 2 #野党

library(mlogit)
mutasv <- utasv[, c("vote", "W1Q7", "W1Q14_1", "W1F2", "W1F1")]
mutasv2 <- na.omit(mutasv) # 欠損値のある行を除外
mutasv3 <- mlogit.data(mutasv2, choice="vote", shape="wide")

results_m <- mlogit(vote ~ 0 | W1Q7 + W1Q14_1 + W1F2 + W1F1, data=mutasv3, probit = TRUE)
summary(results_m)
