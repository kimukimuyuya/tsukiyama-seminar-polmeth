sightseeing <- read.csv("visit_avg.csv", na.strings = "")

# 平均回数と、観光地点数の散布図を描く
plot(sightseeing$平均回数, sightseeing$観光地点数, xlab = "平均回数", ylab = "観光地点数", main = "都道府県ごとの平均回数と観光地点数")
# 都道府県名をプロットした位置に表示する
text(sightseeing$平均回数, sightseeing$観光地点数, labels = sightseeing$都道府県, pos = 3, cex = 0.7)

#　平均回数と、自然の散布図を描く
plot(sightseeing$平均回数, sightseeing$自然, xlab = "平均回数", ylab = "自然", main = "都道府県ごとの平均回数と自然")
text(sightseeing$平均回数, sightseeing$自然, labels = sightseeing$都道府県, pos = 3, cex = 0.7)

# 平均回数と、歴史・文化の散布図を描く
plot(sightseeing$平均回数, sightseeing$歴史.文化, xlab = "平均回数", ylab = "歴史・文化", main = "都道府県ごとの平均回数と歴史文化")
text(sightseeing$平均回数, sightseeing$歴史.文化, labels = sightseeing$都道府県, pos = 3, cex = 0.7)

# 平均回数と、温泉.文化の散布図を描く
plot(sightseeing$平均回数, sightseeing$温泉.文化, xlab = "平均回数", ylab = "温泉・文化", main = "都道府県ごとの平均回数と温泉文化")
text(sightseeing$平均回数, sightseeing$温泉.文化, labels = sightseeing$都道府県, pos = 3, cex = 0.7)