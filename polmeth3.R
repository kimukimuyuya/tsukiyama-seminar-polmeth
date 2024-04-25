utasv <- read.csv("utasv.csv", na.strings=c("", "NA", "66", "99", "999"), fileEncoding = "SJIS")
tab <- table(utasv$W1F1, utasv$W1Q1)
tab

tab.p <- prop.table(tab, margin = 1)
tab.p

tab <- addmargins(tab)

rownames(tab) <- c("男性", "女性", "合計")
colnames(tab) <- c("棄権", "投票", "合計")

tab <- table(utasv$W1F1, utasv$W1Q1)
chisq.test(tab, correct = FALSE)

library("descr")
tab <- CrossTable(utasv$W1F1, utasv$W1Q1,
                  prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE,
                  chisq = TRUE)
tab
