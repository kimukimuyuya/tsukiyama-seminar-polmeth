utasv <- read.csv("utasv.csv", na.strings=c("", "NA", "66", "99", "999"), fileEncoding = "SJIS")
tab <- table(utasv$W1F1, utasv$W1Q1)
tab

tab.p <- prop.table(tab, margin = 1)
tab.p

tab <- addmargins(tab)

rownames(tab) <- c("男性", "女性", "合計")
colnames(tab) <- c("棄権", "投票", "合計")
tab

tab <- table(utasv$W1F1, utasv$W1Q1)
chisq.test(tab, correct = FALSE)

library("descr")
tab <- CrossTable(utasv$W1F1, utasv$W1Q1,
                  prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE,
                  chisq = TRUE)
tab

#消費税増税に賛成する理由を分析
tax <- utasv$W1Q16_8
tax[utasv$W1Q16_8 == 1 | utasv$W1Q16_8 == 2] <- 1
tax[utasv$W1Q16_8 == 4 | utasv$W1Q16_8 == 5] <- 0
tax[utasv$W1Q16_8 == 3] <- NA

values <- utasv$W1Q17_2
values[utasv$W1Q17_2 == 1 | utasv$W1Q17_2 == 2] <- 0
values[utasv$W1Q17_2 == 4 | utasv$W1Q17_2 == 5] <- 1
values[utasv$W1Q17_2 == 3] <- NA

tab <- table(values, tax)
chisq.test(tab, correct = FALSE)

tab <- CrossTable(values, tax,
                   prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE,
                   chisq = TRUE)
tab
write.csv(descr:::CreateNewTab(tab2), "polmeth3.csv")
