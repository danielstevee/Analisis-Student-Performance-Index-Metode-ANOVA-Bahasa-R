# Analisis Student Performance Menggunakan Metode ANOVA dan R

## Deskripsi Project
Project ini bertujuan untuk menganalisis pengaruh beberapa faktor terhadap **Performance Index** siswa menggunakan metode statistik pada software R. Dataset yang digunakan berasal dari Kaggle dan berisi data performa akademik siswa.

Dataset:
https://www.kaggle.com/datasets/nikhil7280/student-performance-multiple-linear-regression

---

# Metode yang Digunakan

## 1. One-Way ANOVA
Digunakan untuk mengetahui apakah terdapat perbedaan rata-rata Performance Index berdasarkan kelompok tertentu.

Variabel yang diuji:
- Hours Studied
- Previous Scores
- Sleep Hours

Kelompok dibagi menjadi:
- Rendah
- Sedang
- Tinggi

---

## 2. Bartlett Test
Digunakan untuk menguji homogenitas varians sebelum melakukan ANOVA.

Hipotesis:
- H0 : Varians antar kelompok homogen
- H1 : Varians antar kelompok tidak homogen

---

## 3. Shapiro-Wilk Test
Digunakan untuk menguji normalitas data.

Hipotesis:
- H0 : Data berdistribusi normal
- H1 : Data tidak berdistribusi normal

---

## 4. Tukey HSD (Post-hoc Test)
Digunakan setelah ANOVA signifikan untuk mengetahui pasangan kelompok mana yang memiliki perbedaan signifikan.

---

## 5. Two-Way ANOVA
Digunakan sebagai analisis tambahan untuk melihat:
- Pengaruh Previous Scores terhadap Performance Index
- Pengaruh Hours Studied terhadap Performance Index
- Interaksi antara Previous Scores dan Hours Studied

---

# Struktur Analisis

## One-Way ANOVA

```r
# Uji ANOVA
anova_model <- aov(
  Performance.Index ~ Kelompok,
  data = data
)

summary(anova_model)
```

---

## Bartlett Test

```r
bartlett.test(
  Performance.Index ~ Kelompok,
  data = data
)
```

---

## Shapiro-Wilk Test

```r
shapiro.test(data$Performance.Index)
```

---

## Tukey HSD

```r
TukeyHSD(anova_model)
```

---

## Two-Way ANOVA

```r
anova_two_way <- aov(
  Performance.Index ~ Previous.Group * Hours.Group,
  data = data
)

summary(anova_two_way)
```

---

# Hasil Analisis

## One-Way ANOVA
Hasil menunjukkan bahwa:
- Previous Scores memiliki pengaruh signifikan terhadap Performance Index.
- Hours Studied juga berpengaruh terhadap Performance Index.

---

## Two-Way ANOVA
Hasil menunjukkan bahwa:
- Previous Scores berpengaruh signifikan terhadap Performance Index.
- Hours Studied berpengaruh signifikan terhadap Performance Index.
- Tidak terdapat interaksi signifikan antara Previous Scores dan Hours Studied.

---

# Kesimpulan
Berdasarkan hasil pengujian menggunakan metode ANOVA pada software R, dapat disimpulkan bahwa beberapa faktor seperti Previous Scores dan Hours Studied memiliki pengaruh terhadap Performance Index siswa.

Metode One-Way ANOVA digunakan sebagai metode utama sesuai materi perkuliahan, sedangkan Two-Way ANOVA digunakan sebagai pengembangan analisis tambahan.

---

# Software dan Library
- R
- VSCode

---

# Referensi
1. Materi PDF Uji Hipotesis dan ANOVA
2. Dataset Kaggle Student Performance
3. Dokumentasi resmi R