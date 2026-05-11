data <- read.csv("Student_Performance.csv")

data <- data[1:30, ]

cat("\n====================================\n")
cat("         TABEL DATA\n")
cat("====================================\n\n")

tabel <- data[, c(
  "Previous.Scores",
  "Hours.Studied",
  "Performance.Index"
)]

print(tabel)

data$Previous.Group <- cut(
  data$Previous.Scores,
  breaks = c(0,59,79,100),
  labels = c("Rendah","Sedang","Tinggi")
)

data$Hours.Group <- cut(
  data$Hours.Studied,
  breaks = c(0,3,6,10),
  labels = c("Rendah","Sedang","Tinggi")
)

cat("\n====================================\n")
cat("     KELOMPOK PREVIOUS SCORES\n")
cat("====================================\n\n")

print(table(data$Previous.Group))

cat("\n====================================\n")
cat("      KELOMPOK HOURS STUDIED\n")
cat("====================================\n\n")

print(table(data$Hours.Group))

cat("\n====================================\n")
cat("         UJI NORMALITAS\n")
cat("====================================\n\n")

print(shapiro.test(data$Performance.Index))

cat("\n====================================\n")
cat("         TWO-WAY ANOVA\n")
cat("====================================\n\n")

anova_two_way <- aov(
  Performance.Index ~
    Previous.Group * Hours.Group,
  data = data
)

hasil <- summary(anova_two_way)

print(hasil)

cat("\n====================================\n")
cat("           TUKEY HSD\n")
cat("====================================\n\n")

print(TukeyHSD(anova_two_way))

cat("\n====================================\n")
cat("           KESIMPULAN\n")
cat("====================================\n\n")

p_previous <- hasil[[1]][["Pr(>F)"]][1]
p_hours <- hasil[[1]][["Pr(>F)"]][2]
p_interaksi <- hasil[[1]][["Pr(>F)"]][3]

cat("P-Value Previous Scores :", p_previous, "\n")
cat("P-Value Hours Studied   :", p_hours, "\n")
cat("P-Value Interaksi       :", p_interaksi, "\n\n")

if (p_previous < 0.05) {

  cat("Previous Scores berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n\n")

} else {

  cat("Previous Scores tidak berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n\n")

}

if (p_hours < 0.05) {

  cat("Hours Studied berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n\n")

} else {

  cat("Hours Studied tidak berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n\n")

}

if (p_interaksi < 0.05) {

  cat("Terdapat interaksi signifikan antara\n")
  cat("Previous Scores dan Hours Studied\n")
  cat("terhadap Performance Index.\n")

} else {

  cat("Tidak terdapat interaksi signifikan antara\n")
  cat("Previous Scores dan Hours Studied\n")
  cat("terhadap Performance Index.\n")

}
