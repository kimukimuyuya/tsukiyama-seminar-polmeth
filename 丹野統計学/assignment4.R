# データの読み込み
data <- read_excel("test_data.xlsx", col_names = TRUE)

# 遅延時間と平均値の計算
delay_times <- as.numeric(names(data))
mean_values <- colMeans(data)

# 遅延時間と対応する平均値をデータフレームにまとめる
data_model <- data.frame(delay = delay_times, value = mean_values)
plot(delay_times, mean_values, main = "Value Decay Over Time",
     xlab = "Delay Time (Months)", ylab = "Value",
     pch = 16, col = "black")

# 列ごとの標準偏差を計算
std_dev <- apply(data, 2, sd)

# 標準誤差を計算（n = サンプルサイズ = 行数）
n <- nrow(data)
std_err <- std_dev / sqrt(n)

# 平均値をプロット
plot(delay_times, mean_values, 
     pch = 16, col = "black", ylim = c(min(mean_values - std_err), max(mean_values + std_err)))

# エラーバーを追加
arrows(x0 = delay_times, y0 = mean_values - std_err, 
       x1 = delay_times, y1 = mean_values + std_err, 
       angle = 90, code = 3, length = 0.05, col = "gray")
