jgss <- read.table("37874-0001-Data.tsv", sep="\t", header=TRUE)
## 従属変数
## 最終学校（本人）
jgss$edu <- NA
jgss$edu[jgss$XXLSTSCH == 8] <- 0 # 新制中学校
jgss$edu[jgss$XXLSTSCH == 9] <- 1 # 新制高校 # 新制高専・短大
jgss$edu[jgss$XXLSTSCH == 10 | jgss$XXLSTSCH == 11] <- 2
jgss$edu[jgss$XXLSTSCH == 12] <- 3 # 新制大学
jgss$edu[jgss$XXLSTSCH == 13] <- 4 # 新制大学院
# 順序変数として扱う
jgss$edu <- as.ordered(jgss$edu)

## 独立変数
## 年齢
jgss$age <- jgss$AGEB
## 性別
jgss$sex <- jgss$SEXA
jgss$sex[jgss$SEXA == 2] <- 0 # 男性＝１、女性＝０
## 15歳の頃の世帯収入レベル
jgss$income15 <- jgss$OPFFIX15
jgss$income15[jgss$OPFFIX15 == 9] <- NA # 無回答＝９⇒NA

library(ordinal)
results <- clm(edu ~ age + sex + income15, data=jgss)
summary(results)

## 従属変数
## 職業（本人）
jgss$job <- NA
jgss$job[jgss$XJOB1WK == 3] <- 0 # 無職
jgss$job[jgss$TPJB >= 2 & jgss$TPJB <= 5] <- 1 # 自営業・自由業
jgss$job[jgss$TPJB == 1] <- 2 # 雇用者

library(mlogit)
mjgss <- jgss[, c("job", "sex", "age", "income15")] # 使用変数のみ
mjgss2 <- na.omit(mjgss) # 欠損値のある行を除外
mjgss3 <- mlogit.data(mjgss2, choice="job", shape="wide")

results_m <- mlogit(job ~ 0 | sex + age + income15, data=mjgss3)
summary(results_m)




