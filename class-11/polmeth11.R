#cses <- read.csv("cses5.csv")
## レベル１の独立変数
cses$gender <- cses$E2002
cses$gender[cses$E2002 >= 3] <- NA
cses$age <- cses$E1008 - cses$E2001_Y
cses$age[cses$E2001_Y > 3000] <- NA
cses$education <- cses$E2003
cses$education[cses$E2003 >= 10] <- NA
cses$income <- cses$E2010
cses$income[cses$E2010 >= 6] <- NA
## レベル２の独立変数：各国の腐敗認識指数（Corruption Perception Index: CPI）
cses$corruption <- cses$E5102
cses$corruption[cses$E5102 > 100] <- NA

## 従属変数：民主主義に対する満足度
cses$swd <- cses$E3023
cses$swd[cses$E3023 == 1] <- 5
cses$swd[cses$E3023 == 2] <- 4
cses$swd[cses$E3023 == 4] <- 2
cses$swd[cses$E3023 == 5] <- 1
cses$swd[cses$E3023 == 6] <- 3
cses$swd[cses$E3023 >= 7] <- NA
## グループレベルの設定変数（各国・各年の選挙を識別する変数）
cses$id_year <- cses$E1004
library(lme4)
## ランダム切片モデル
res1 <- lmer(swd ~ gender + age + education + income + (1 | id_year), data = cses)
summary(res1)
## ランダム切片・係数モデル
res2 <- lmer(swd ~ gender + age + education + income
             + (1 + education | id_year), data = cses)
summary(res2)
## (0 + education | id_year)⇒ランダム係数モデル
## ランダム切片・係数モデル（レベル2）
res3 <- lmer(swd ~ gender + age + education * corruption
             + income + (1 + education | id_year), data = cses)
summary(res3)
