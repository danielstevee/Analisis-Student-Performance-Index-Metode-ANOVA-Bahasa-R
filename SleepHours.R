# ======================================
# ANOVA SLEEP HOURS
# ======================================

data <- read.csv("Student_Performance.csv")
data <- data[1:30, ]

tabel <- data[, c("Sleep.Hours", "Performance.Index")]

cat("\n====================================\n")
cat("        SLEEP HOURS DATA\n")
cat("====================================\n\n")

print(tabel)

# Kelompok Sleep Hours
data$Sleep.Group <- cut(
  data$Sleep.Hours,
  breaks = c(0,4,7,10),
  labels = c("Kurang","Normal","Tinggi")
)

cat("\n====================================\n")
cat("      JUMLAH KELOMPOK\n")
cat("====================================\n\n")

print(table(data$Sleep.Group))

# Normalitas
cat("\n====================================\n")
cat("       UJI NORMALITAS\n")
cat("====================================\n\n")

print(shapiro.test(data$Performance.Index))

# ANOVA
cat("\n====================================\n")
cat("         HASIL ANOVA\n")
cat("====================================\n\n")

anova_sleep <- aov(
  Performance.Index ~ Sleep.Group,
  data = data
)

hasil_sleep <- summary(anova_sleep)

print(hasil_sleep)

# Tukey
cat("\n====================================\n")
cat("         TUKEY HSD\n")
cat("====================================\n\n")

print(TukeyHSD(anova_sleep))

# ======================================
# KESIMPULAN
# ======================================

p_sleep <- hasil_sleep[[1]][["Pr(>F)"]][1]

cat("\n====================================\n")
cat("          KESIMPULAN\n")
cat("====================================\n\n")

cat("P-Value :", p_sleep, "\n\n")

if (p_sleep < 0.05) {

  cat("Karena p-value < 0.05\n")
  cat("Maka H0 ditolak.\n")
  cat("Sleep Hours berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n")

} else {

  cat("Karena p-value > 0.05\n")
  cat("Maka H0 gagal ditolak.\n")
  cat("Sleep Hours tidak berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n")

}