## cses <- read.csv("cses5.csv")
## レベル１の独立変数
cses$gender <- cses$E2002
cses$gender[cses$E2002 >= 3] <- NA

cses$age <- cses$E1008 - cses$E2001_Y
cses$age[cses$E2001_Y > 3000] <- NA

cses$education <- cses$E2003
cses$education[cses$E2003 >= 10] <- NA

cses$income <- cses$E2010
cses$income[cses$E2010 >= 6] <- NA

## レベル２の独立変数：人間開発指数
cses$HDI <- cses$E5097_1
cses$HDI[cses$E5097_1 == 999] <- NA
cses$HDI

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
res1 <- lmer(swd ~ gender + age + education + income + (1 | id_year), data = cses)
res2 <- lmer(swd ~ gender + age + education + income + (1 + income | id_year), data = cses)
res3 <- lmer(swd ~ gender + age + education + income * HDI + (1 + income | id_year), data = cses)
library(texreg)
screenreg(list(res1, res2, res3), digits = 4)

library(car)
# モデル2: 多重共線性の確認のための線形モデルを作成
lm_model2 <- lm(swd ~ gender + age + education + income + HDI, data = cses)
vif(lm_model2)


