library(readxl)
library(psych)

data <- read_excel("test_data.xlsx", col_names = FALSE)
colnames(data) <- c("国語", "社会", "数学", "理科", "英語")
data <- data[-1, ]
data <- data.frame(lapply(data, as.numeric))

# 因子分析
cor_matrix <- cor(data)
factor_result <- fa(cor_matrix, nfactors = 2, rotate = "varimax")
factor_result$loadings

library(cluster)

dist_matrix <- dist(data)
hclust_result <- hclust(dist_matrix, method = "ward.D2")

clusters <- cutree(hclust_result, k = 2)
by(data, clusters, apply, 2, mean)