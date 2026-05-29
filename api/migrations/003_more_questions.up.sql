-- ============================================================
-- SPM Mathematics additional questions – Migration 003
-- 4 new topics, 6 new subtopics, ~110 new questions
-- Covers difficulty 1 (easy), 2 (medium), 3 (hard)
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- ADDITIONAL QUESTIONS FOR EXISTING SUBTOPICS (1-8)
-- ────────────────────────────────────────────────────────────

-- ===================
-- Subtopic 1: Nombor Bulat dan Operasi Asas (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(1, 'mcq',
 'Hitung: 3 + 4 × 2 - 1',
 '["A. 14", "B. 10", "C. 6", "D. 13"]',
 'B',
 'Langkah 1: Guna peraturan BODMAS — darab dulu.\nLangkah 2: 4 × 2 = 8.\nLangkah 3: 3 + 8 - 1 = 10.\nJawapan: 10',
 1),

(1, 'mcq',
 'Apakah faktor perdana bagi 36?',
 '["A. 2 dan 3", "B. 4 dan 9", "C. 2 dan 6", "D. 3 dan 12"]',
 'A',
 'Langkah 1: Faktorkan 36 = 2 × 2 × 3 × 3 = 2² × 3².\nLangkah 2: Faktor perdana ialah nombor yang hanya boleh dibahagi 1 dan dirinya sendiri.\nJawapan: 2 dan 3',
 1),

(1, 'short',
 'Cari nilai PPKK (KPK) bagi 12 dan 18.',
 NULL,
 '36',
 'Langkah 1: 12 = 2² × 3, 18 = 2 × 3².\nLangkah 2: PPKK = 2² × 3² = 4 × 9 = 36.\nJawapan: 36',
 2),

(1, 'mcq',
 'Apakah FSTB (GCD) bagi 24 dan 36?',
 '["A. 4", "B. 6", "C. 12", "D. 72"]',
 'C',
 'Langkah 1: Faktor bagi 24: 1, 2, 3, 4, 6, 8, 12, 24.\nLangkah 2: Faktor bagi 36: 1, 2, 3, 4, 6, 9, 12, 18, 36.\nLangkah 3: FSTB terbesar = 12.\nJawapan: 12',
 2),

(1, 'mcq',
 'Hitung: 2³ × 2² ÷ 2⁴',
 '["A. 1", "B. 2", "C. 4", "D. 8"]',
 'B',
 'Langkah 1: Gunakan hukum eksponen: aᵐ × aⁿ ÷ aᵖ = aᵐ⁺ⁿ⁻ᵖ.\nLangkah 2: 2³⁺²⁻⁴ = 2¹ = 2.\nJawapan: 2',
 3);

-- ===================
-- Subtopic 2: Pecahan dan Perpuluhan (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(2, 'mcq',
 'Manakah pecahan yang terbesar?',
 '["A. 1/2", "B. 3/8", "C. 5/12", "D. 2/5"]',
 'A',
 'Langkah 1: Tukarkan semua kepada perpuluhan.\nLangkah 2: 1/2 = 0.5, 3/8 = 0.375, 5/12 ≈ 0.417, 2/5 = 0.4.\nLangkah 3: 0.5 adalah terbesar.\nJawapan: 1/2',
 1),

(2, 'mcq',
 'Hitung: 1½ × 2⅓',
 '["A. 2⅙", "B. 3½", "C. 4", "D. 4⅙"]',
 'B',
 'Langkah 1: Tukar kepada pecahan tak wajar: 1½ = 3/2, 2⅓ = 7/3.\nLangkah 2: 3/2 × 7/3 = 21/6 = 7/2 = 3½.\nJawapan: 3½',
 2),

(2, 'short',
 'Hitung: 3/4 ÷ 1/2',
 NULL,
 '1.5',
 'Langkah 1: Bahagi pecahan = darab dengan salingan: 3/4 × 2/1.\nLangkah 2: 6/4 = 3/2 = 1.5.\nJawapan: 1.5',
 2),

(2, 'mcq',
 'Hitung: (2/3 + 1/6) ÷ (3/4 - 1/2)',
 '["A. 3⅓", "B. 2½", "C. 5/24", "D. 10/9"]',
 'A',
 'Langkah 1: 2/3 + 1/6 = 4/6 + 1/6 = 5/6.\nLangkah 2: 3/4 - 1/2 = 3/4 - 2/4 = 1/4.\nLangkah 3: 5/6 ÷ 1/4 = 5/6 × 4 = 20/6 = 10/3 = 3⅓.\nJawapan: 3⅓',
 3),

(2, 'short',
 'Bundarkan 3.7654 kepada dua tempat perpuluhan.',
 NULL,
 '3.77',
 'Langkah 1: Lihat digit ketiga perpuluhan: 5 ≥ 5, jadi bundarkan naik.\nLangkah 2: 3.765... → 3.77.\nJawapan: 3.77',
 1);

-- ===================
-- Subtopic 3: Peratusan (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(3, 'mcq',
 'Berapakah 40% daripada 150?',
 '["A. 40", "B. 50", "C. 60", "D. 90"]',
 'C',
 'Langkah 1: 40% = 40/100 = 0.4.\nLangkah 2: 0.4 × 150 = 60.\nJawapan: 60',
 1),

(3, 'mcq',
 'Seorang peniaga membeli barang dengan harga RM120 dan menjualnya dengan harga RM150. Berapakah peratusan keuntungannya?',
 '["A. 20%", "B. 25%", "C. 30%", "D. 33%"]',
 'B',
 'Langkah 1: Keuntungan = 150 - 120 = RM30.\nLangkah 2: Peratusan keuntungan = (30 ÷ 120) × 100 = 25%.\nJawapan: 25%',
 2),

(3, 'mcq',
 'Harga sebuah barang meningkat 10% pada tahun pertama dan 10% lagi pada tahun kedua. Berapakah peratusan peningkatan keseluruhan?',
 '["A. 20%", "B. 21%", "C. 22%", "D. 10%"]',
 'B',
 'Langkah 1: Faktor peningkatan: 1.10 × 1.10 = 1.21.\nLangkah 2: Peningkatan keseluruhan = 21%.\nNota: Bukan 20% kerana peningkatan tahun kedua dikira atas harga yang sudah meningkat.\nJawapan: 21%',
 3),

(3, 'short',
 'Selepas diskaun 20%, harga sebuah barang ialah RM160. Berapakah harga asalnya (dalam RM)?',
 NULL,
 '200',
 'Langkah 1: Harga selepas diskaun = 80% × harga asal.\nLangkah 2: Harga asal = 160 ÷ 0.80 = RM200.\nJawapan: 200',
 2),

(3, 'mcq',
 'Bilangan pelajar berkurang dari 400 ke 340. Berapakah peratusan penurunan?',
 '["A. 10%", "B. 12%", "C. 15%", "D. 17.6%"]',
 'C',
 'Langkah 1: Penurunan = 400 - 340 = 60.\nLangkah 2: Peratusan penurunan = (60 ÷ 400) × 100 = 15%.\nJawapan: 15%',
 2);

-- ===================
-- Subtopic 4: Ungkapan Algebra (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(4, 'mcq',
 'Ringkaskan: 4a + 3b - 2a + b',
 '["A. 2a + 4b", "B. 5a + 2b", "C. 6a + 4b", "D. 2a + 2b"]',
 'A',
 'Langkah 1: Kumpul sebutan a: 4a - 2a = 2a.\nLangkah 2: Kumpul sebutan b: 3b + b = 4b.\nJawapan: 2a + 4b',
 1),

(4, 'short',
 'Jika a = 2 dan b = -3, cari nilai bagi 3a - 2b.',
 NULL,
 '12',
 'Langkah 1: Gantikan nilai: 3(2) - 2(-3).\nLangkah 2: 6 - (-6) = 6 + 6 = 12.\nJawapan: 12',
 2),

(4, 'mcq',
 'Ringkaskan: 12x²y ÷ 4xy',
 '["A. 3y", "B. 3x", "C. 8xy", "D. 3xy"]',
 'B',
 'Langkah 1: Bahagi pekali: 12 ÷ 4 = 3.\nLangkah 2: x²/x = x, y/y = 1.\nJawapan: 3x',
 2),

(4, 'mcq',
 'Faktorkan: x² + 7x + 12',
 '["A. (x + 3)(x + 4)", "B. (x + 2)(x + 6)", "C. (x + 1)(x + 12)", "D. (x + 6)(x + 2)"]',
 'A',
 'Langkah 1: Cari dua nombor yang hasil darab = 12 dan hasil tambah = 7.\nLangkah 2: 3 × 4 = 12 dan 3 + 4 = 7.\nLangkah 3: x² + 7x + 12 = (x + 3)(x + 4).\nJawapan: (x + 3)(x + 4)',
 3),

(4, 'mcq',
 'Faktorkan: 9x² - 16',
 '["A. (3x - 4)²", "B. (9x - 4)(x + 4)", "C. (3x + 4)(3x - 4)", "D. (3x - 8)(3x + 2)"]',
 'C',
 'Langkah 1: Ini adalah perbezaan dua kuasa dua: a² - b².\nLangkah 2: 9x² = (3x)², 16 = 4².\nLangkah 3: (3x)² - 4² = (3x + 4)(3x - 4).\nJawapan: (3x + 4)(3x - 4)',
 3);

-- ===================
-- Subtopic 5: Persamaan Linear (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(5, 'mcq',
 'Selesaikan: 4x = 24',
 '["A. x = 4", "B. x = 6", "C. x = 8", "D. x = 96"]',
 'B',
 'Langkah 1: Bahagi kedua-dua belah dengan 4.\nLangkah 2: x = 24 ÷ 4 = 6.\nJawapan: x = 6',
 1),

(5, 'mcq',
 'Selesaikan: x/3 - 4 = 2',
 '["A. x = 6", "B. x = 12", "C. x = 18", "D. x = 24"]',
 'C',
 'Langkah 1: x/3 = 2 + 4 = 6.\nLangkah 2: x = 6 × 3 = 18.\nJawapan: x = 18',
 2),

(5, 'short',
 'Diberi 2x + y = 10 dan x - y = 2. Cari nilai x.',
 NULL,
 '4',
 'Langkah 1: Tambah kedua-dua persamaan: (2x + y) + (x - y) = 10 + 2.\nLangkah 2: 3x = 12, x = 4.\nJawapan: 4',
 3),

(5, 'mcq',
 'Umur Amin adalah 3 tahun lebih daripada umur Ali. Jumlah umur mereka ialah 27 tahun. Berapakah umur Amin?',
 '["A. 12 tahun", "B. 13 tahun", "C. 14 tahun", "D. 15 tahun"]',
 'D',
 'Langkah 1: Katakan umur Ali = x, maka umur Amin = x + 3.\nLangkah 2: x + (x + 3) = 27 → 2x = 24 → x = 12.\nLangkah 3: Umur Amin = 12 + 3 = 15 tahun.\nJawapan: 15 tahun',
 2),

(5, 'mcq',
 'Selesaikan: 2(x + 3) = 3(x - 1)',
 '["A. x = 3", "B. x = 7", "C. x = 9", "D. x = 15"]',
 'C',
 'Langkah 1: Kembangkan: 2x + 6 = 3x - 3.\nLangkah 2: 6 + 3 = 3x - 2x.\nLangkah 3: x = 9.\nJawapan: x = 9',
 3);

-- ===================
-- Subtopic 6: Ketaksamaan Linear (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(6, 'mcq',
 'Selesaikan: x - 5 > 3',
 '["A. x > -2", "B. x > 8", "C. x < 8", "D. x > 2"]',
 'B',
 'Langkah 1: Tambah 5 pada kedua-dua belah: x > 3 + 5.\nLangkah 2: x > 8.\nJawapan: x > 8',
 1),

(6, 'short',
 'Berapa banyak integer yang memenuhi: 1 < x ≤ 5?',
 NULL,
 '4',
 'Langkah 1: Integer yang memenuhi: 2, 3, 4, 5.\nLangkah 2: Jumlah = 4 integer.\nNota: x = 1 tidak termasuk (>), tetapi x = 5 termasuk (≤).\nJawapan: 4',
 2),

(6, 'mcq',
 'Selesaikan: 4x ≥ 20',
 '["A. x ≥ 4", "B. x ≥ 5", "C. x ≥ 80", "D. x ≤ 5"]',
 'B',
 'Langkah 1: Bahagi kedua-dua belah dengan 4.\nLangkah 2: x ≥ 20 ÷ 4 = 5.\nJawapan: x ≥ 5',
 1),

(6, 'mcq',
 'Selesaikan: -1 < 2x + 3 ≤ 9',
 '["A. -2 < x ≤ 3", "B. -1 < x ≤ 6", "C. 1 < x ≤ 6", "D. -4 < x ≤ 6"]',
 'A',
 'Langkah 1: Tolak 3 pada semua bahagian: -1 - 3 < 2x ≤ 9 - 3 → -4 < 2x ≤ 6.\nLangkah 2: Bahagi dengan 2: -2 < x ≤ 3.\nJawapan: -2 < x ≤ 3',
 3),

(6, 'mcq',
 'Jika 5 - 2x > 1, maka:',
 '["A. x > 2", "B. x < 2", "C. x > -2", "D. x < -2"]',
 'B',
 'Langkah 1: -2x > 1 - 5 = -4.\nLangkah 2: Bahagi dengan -2 dan TERBALIKKAN tanda: x < 2.\nJawapan: x < 2',
 3);

-- ===================
-- Subtopic 7: Perimeter dan Luas (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(7, 'mcq',
 'Cari luas trapezium dengan dua sisi selari 8 cm dan 12 cm, dan tinggi 5 cm.',
 '["A. 25 cm²", "B. 40 cm²", "C. 50 cm²", "D. 100 cm²"]',
 'C',
 'Langkah 1: Luas trapezium = ½ × (a + b) × t.\nLangkah 2: ½ × (8 + 12) × 5 = ½ × 20 × 5 = 50 cm².\nJawapan: 50 cm²',
 1),

(7, 'mcq',
 'Sebuah bentuk terdiri daripada segi empat tepat (8 cm × 4 cm) dan segitiga (tapak 8 cm, tinggi 3 cm). Cari jumlah luas.',
 '["A. 32 cm²", "B. 36 cm²", "C. 44 cm²", "D. 56 cm²"]',
 'C',
 'Langkah 1: Luas segi empat tepat = 8 × 4 = 32 cm².\nLangkah 2: Luas segitiga = ½ × 8 × 3 = 12 cm².\nLangkah 3: Jumlah = 32 + 12 = 44 cm².\nJawapan: 44 cm²',
 2),

(7, 'short',
 'Cari lilitan bulatan dengan diameter 14 cm. (Guna π = 22/7)',
 NULL,
 '44',
 'Langkah 1: Lilitan = π × d.\nLangkah 2: 22/7 × 14 = 22 × 2 = 44 cm.\nJawapan: 44',
 2),

(7, 'mcq',
 'Sebuah segi empat tepat berukuran 20 cm × 18 cm. Di tengahnya terdapat bulatan berjejari 7 cm. Cari luas kawasan berlorek. (Guna π = 22/7)',
 '["A. 154 cm²", "B. 206 cm²", "C. 360 cm²", "D. 514 cm²"]',
 'B',
 'Langkah 1: Luas segi empat tepat = 20 × 18 = 360 cm².\nLangkah 2: Luas bulatan = (22/7) × 7² = 22 × 7 = 154 cm².\nLangkah 3: Luas berlorek = 360 - 154 = 206 cm².\nJawapan: 206 cm²',
 3),

(7, 'mcq',
 'Sebuah taman berbentuk segi empat sama dengan sisi 15 m. Di dalamnya terdapat laluan selebar 1 m di sepanjang sempadan. Cari luas bahagian dalam laluan.',
 '["A. 121 m²", "B. 144 m²", "C. 169 m²", "D. 225 m²"]',
 'C',
 'Langkah 1: Sisi bahagian dalam = 15 - 2(1) = 13 m.\nLangkah 2: Luas bahagian dalam = 13² = 169 m².\nJawapan: 169 m²',
 3);

-- ===================
-- Subtopic 8: Isi Padu dan Luas Permukaan (extra)
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(8, 'mcq',
 'Cari isi padu prisma segitiga dengan tapak segitiga (tapak 6 cm, tinggi 4 cm) dan panjang prisma 10 cm.',
 '["A. 24 cm³", "B. 60 cm³", "C. 120 cm³", "D. 240 cm³"]',
 'C',
 'Langkah 1: Luas tapak segitiga = ½ × 6 × 4 = 12 cm².\nLangkah 2: Isi padu = luas tapak × panjang = 12 × 10 = 120 cm³.\nJawapan: 120 cm³',
 1),

(8, 'short',
 'Cari luas permukaan kuboid dengan panjang 5 cm, lebar 4 cm, dan tinggi 3 cm.',
 NULL,
 '94',
 'Langkah 1: Luas permukaan = 2(pl + lt + pt).\nLangkah 2: 2(5×4 + 4×3 + 5×3) = 2(20 + 12 + 15) = 2(47) = 94 cm².\nJawapan: 94',
 2),

(8, 'mcq',
 'Cari isi padu kon dengan jejari tapak 7 cm dan tinggi 12 cm. (Guna π = 22/7)',
 '["A. 308 cm³", "B. 616 cm³", "C. 1232 cm³", "D. 1848 cm³"]',
 'B',
 'Langkah 1: Isi padu = ⅓ × π × r² × t.\nLangkah 2: ⅓ × (22/7) × 49 × 12 = ⅓ × 22 × 7 × 12 = ⅓ × 1848 = 616 cm³.\nJawapan: 616 cm³',
 2),

(8, 'mcq',
 'Sebuah piramid dengan tapak segi empat sama 9 cm × 9 cm dan tinggi 12 cm. Cari isi padunya.',
 '["A. 243 cm³", "B. 324 cm³", "C. 972 cm³", "D. 1296 cm³"]',
 'B',
 'Langkah 1: Luas tapak = 9 × 9 = 81 cm².\nLangkah 2: Isi padu = ⅓ × luas tapak × tinggi = ⅓ × 81 × 12 = 324 cm³.\nJawapan: 324 cm³',
 3),

(8, 'mcq',
 'Cari isi padu hemisfera dengan jejari 6 cm. (Guna π = 3.14)',
 '["A. 226.08 cm³", "B. 339.12 cm³", "C. 452.16 cm³", "D. 904.32 cm³"]',
 'C',
 'Langkah 1: Isi padu sfera penuh = (4/3)πr³ = (4/3) × 3.14 × 216 = 904.32 cm³.\nLangkah 2: Isi padu hemisfera = 904.32 ÷ 2 = 452.16 cm³.\nJawapan: 452.16 cm³',
 3);

-- ────────────────────────────────────────────────────────────
-- NEW TOPICS AND SUBTOPICS
-- ────────────────────────────────────────────────────────────

INSERT INTO topics (id, subject, name, order_index) VALUES
(4, 'Matematik', 'Statistik',         4),
(5, 'Matematik', 'Nisbah dan Kadar',  5),
(6, 'Matematik', 'Teorem Pythagoras', 6),
(7, 'Matematik', 'Trigonometri',      7);

INSERT INTO subtopics (id, topic_id, name, order_index) VALUES
(9,  4, 'Min, Median dan Mod',  9),
(10, 4, 'Graf Statistik',       10),
(11, 5, 'Nisbah',               11),
(12, 5, 'Kadar dan Kadaran',    12),
(13, 6, 'Teorem Pythagoras',    13),
(14, 7, 'Nisbah Trigonometri',  14);

-- ===================
-- Subtopic 9: Min, Median dan Mod
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(9, 'mcq',
 'Cari mod bagi data berikut: 3, 5, 7, 5, 2, 5, 3',
 '["A. 3", "B. 5", "C. 7", "D. 2"]',
 'B',
 'Langkah 1: Kira kekerapan: 2→1 kali, 3→2 kali, 5→3 kali, 7→1 kali.\nLangkah 2: Mod = nilai yang paling kerap muncul = 5.\nJawapan: 5',
 1),

(9, 'mcq',
 'Cari min bagi data berikut: 6, 8, 4, 10, 7',
 '["A. 6", "B. 7", "C. 8", "D. 9"]',
 'B',
 'Langkah 1: Jumlah = 6 + 8 + 4 + 10 + 7 = 35.\nLangkah 2: Min = 35 ÷ 5 = 7.\nJawapan: 7',
 1),

(9, 'short',
 'Cari median bagi data berikut: 9, 3, 7, 1, 5, 11, 6',
 NULL,
 '6',
 'Langkah 1: Susun dalam tertib menaik: 1, 3, 5, 6, 7, 9, 11.\nLangkah 2: n = 7 (ganjil), median = nilai ke-(7+1)/2 = nilai ke-4 = 6.\nJawapan: 6',
 2),

(9, 'mcq',
 'Min bagi 5 nombor ialah 8. Empat nombor ialah 6, 9, 7, dan 10. Cari nombor kelima.',
 '["A. 6", "B. 7", "C. 8", "D. 9"]',
 'C',
 'Langkah 1: Jumlah 5 nombor = 5 × 8 = 40.\nLangkah 2: Jumlah 4 nombor yang diketahui = 6 + 9 + 7 + 10 = 32.\nLangkah 3: Nombor kelima = 40 - 32 = 8.\nJawapan: 8',
 2),

(9, 'mcq',
 'Cari median bagi data berikut: 4, 6, 8, 6, 9, 7, 8, 5, 6, 7',
 '["A. 6", "B. 6.5", "C. 7", "D. 7.5"]',
 'B',
 'Langkah 1: Susun: 4, 5, 6, 6, 6, 7, 7, 8, 8, 9.\nLangkah 2: n = 10 (genap), median = (nilai ke-5 + nilai ke-6) ÷ 2 = (6 + 7) ÷ 2 = 6.5.\nJawapan: 6.5',
 3),

(9, 'short',
 'Data berikut menunjukkan skor ujian: 70, 80, 65, 80, 75, 90, 80. Cari mod.',
 NULL,
 '80',
 'Langkah 1: Kira kekerapan setiap nilai: 65→1, 70→1, 75→1, 80→3, 90→1.\nLangkah 2: Mod = 80 (muncul 3 kali).\nJawapan: 80',
 1),

(9, 'mcq',
 'Dalam satu kumpulan, min bagi 4 nombor pertama ialah 10 dan min bagi 6 nombor terakhir ialah 15. Cari min keseluruhan bagi 10 nombor.',
 '["A. 12", "B. 12.5", "C. 13", "D. 13.5"]',
 'C',
 'Langkah 1: Jumlah 4 nombor pertama = 4 × 10 = 40.\nLangkah 2: Jumlah 6 nombor terakhir = 6 × 15 = 90.\nLangkah 3: Jumlah keseluruhan = 40 + 90 = 130.\nLangkah 4: Min = 130 ÷ 10 = 13.\nJawapan: 13',
 3);

-- ===================
-- Subtopic 10: Graf Statistik
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(10, 'mcq',
 'Carta bar menunjukkan bilangan buku yang dibaca. Bar untuk Januari adalah 8 unit dan setiap unit mewakili 5 buku. Berapa buku dibaca pada Januari?',
 '["A. 8", "B. 13", "C. 40", "D. 58"]',
 'C',
 'Langkah 1: Bilangan buku = unit × nilai setiap unit.\nLangkah 2: 8 × 5 = 40 buku.\nJawapan: 40',
 1),

(10, 'mcq',
 'Dalam carta pai, satu sektor mewakili sudut 72°. Jika jumlah data ialah 200, berapa nilai yang diwakili sektor itu?',
 '["A. 20", "B. 36", "C. 40", "D. 72"]',
 'C',
 'Langkah 1: Nilai sektor = (sudut ÷ 360°) × jumlah data.\nLangkah 2: (72 ÷ 360) × 200 = 0.2 × 200 = 40.\nJawapan: 40',
 2),

(10, 'short',
 'Kekerapan relatif suatu data ialah 0.25 dan jumlah data ialah 80. Berapakah kekerapannya?',
 NULL,
 '20',
 'Langkah 1: Kekerapan = kekerapan relatif × jumlah data.\nLangkah 2: 0.25 × 80 = 20.\nJawapan: 20',
 2),

(10, 'mcq',
 'Satu piktogram menggunakan simbol yang mewakili 10 pelajar. Kelas A mempunyai 3½ simbol. Berapa pelajar di Kelas A?',
 '["A. 30", "B. 35", "C. 40", "D. 45"]',
 'B',
 'Langkah 1: Bilangan pelajar = bilangan simbol × nilai setiap simbol.\nLangkah 2: 3.5 × 10 = 35 pelajar.\nJawapan: 35',
 2),

(10, 'mcq',
 'Graf garis menunjukkan suhu pagi 8°C meningkat ke 20°C pada petang. Berapakah peratusan peningkatan suhu?',
 '["A. 60%", "B. 100%", "C. 150%", "D. 250%"]',
 'C',
 'Langkah 1: Peningkatan = 20 - 8 = 12°C.\nLangkah 2: Peratusan = (12 ÷ 8) × 100 = 150%.\nJawapan: 150%',
 3),

(10, 'mcq',
 'Carta pai menunjukkan perbelanjaan bulanan. Makanan mewakili 40%, sewa 30%, pengangkutan 15%, lain-lain 15%. Jika jumlah perbelanjaan ialah RM2000, berapakah perbelanjaan makanan?',
 '["A. RM400", "B. RM600", "C. RM800", "D. RM1000"]',
 'C',
 'Langkah 1: Perbelanjaan makanan = 40% × RM2000.\nLangkah 2: 40/100 × 2000 = RM800.\nJawapan: RM800',
 1),

(10, 'short',
 'Sebuah carta bar menunjukkan jualan: Isnin 120, Selasa 95, Rabu 110, Khamis 105, Jumaat 130. Cari min jualan harian.',
 NULL,
 '112',
 'Langkah 1: Jumlah = 120 + 95 + 110 + 105 + 130 = 560.\nLangkah 2: Min = 560 ÷ 5 = 112.\nJawapan: 112',
 2);

-- ===================
-- Subtopic 11: Nisbah
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(11, 'mcq',
 'Nisbah pelajar lelaki kepada perempuan ialah 3:2. Jika terdapat 30 pelajar, berapa pelajar lelaki?',
 '["A. 12", "B. 15", "C. 18", "D. 20"]',
 'C',
 'Langkah 1: Jumlah bahagian = 3 + 2 = 5.\nLangkah 2: Pelajar lelaki = (3 ÷ 5) × 30 = 18.\nJawapan: 18',
 1),

(11, 'mcq',
 'Ringkaskan nisbah 24 : 36.',
 '["A. 2 : 3", "B. 3 : 4", "C. 4 : 6", "D. 6 : 9"]',
 'A',
 'Langkah 1: FSTB bagi 24 dan 36 = 12.\nLangkah 2: 24 ÷ 12 : 36 ÷ 12 = 2 : 3.\nJawapan: 2 : 3',
 1),

(11, 'short',
 'RM60 dibahagikan antara Ali dan Abu dalam nisbah 2 : 3. Berapa RM yang Ali dapat?',
 NULL,
 '24',
 'Langkah 1: Jumlah bahagian = 2 + 3 = 5.\nLangkah 2: Bahagian Ali = (2 ÷ 5) × 60 = RM24.\nJawapan: 24',
 2),

(11, 'mcq',
 'Jika 5 buku berharga RM30, berapakah harga 8 buku?',
 '["A. RM38", "B. RM40", "C. RM48", "D. RM56"]',
 'C',
 'Langkah 1: Harga 1 buku = RM30 ÷ 5 = RM6.\nLangkah 2: Harga 8 buku = 8 × RM6 = RM48.\nJawapan: RM48',
 2),

(11, 'mcq',
 'Nisbah umur Amin kepada Bala ialah 3 : 4. Dalam 5 tahun, nisbah mereka akan jadi 4 : 5. Berapakah umur Amin sekarang?',
 '["A. 12 tahun", "B. 15 tahun", "C. 20 tahun", "D. 24 tahun"]',
 'B',
 'Langkah 1: Katakan umur Amin = 3x dan umur Bala = 4x.\nLangkah 2: (3x + 5) / (4x + 5) = 4/5.\nLangkah 3: 5(3x + 5) = 4(4x + 5) → 15x + 25 = 16x + 20 → x = 5.\nLangkah 4: Umur Amin = 3 × 5 = 15 tahun.\nJawapan: 15 tahun',
 3),

(11, 'mcq',
 'Campurkan cat biru dan putih dalam nisbah 2 : 5. Jika digunakan 14 liter cat biru, berapa liter cat putih diperlukan?',
 '["A. 28 liter", "B. 35 liter", "C. 40 liter", "D. 70 liter"]',
 'B',
 'Langkah 1: Jika biru = 2 bahagian → 14 liter, maka 1 bahagian = 7 liter.\nLangkah 2: Putih = 5 bahagian = 5 × 7 = 35 liter.\nJawapan: 35 liter',
 2),

(11, 'short',
 'Tiga orang berkongsi keuntungan dalam nisbah 1 : 2 : 3. Jika jumlah keuntungan ialah RM720, berapa bahagian orang kedua?',
 NULL,
 '240',
 'Langkah 1: Jumlah bahagian = 1 + 2 + 3 = 6.\nLangkah 2: Bahagian orang kedua = (2 ÷ 6) × 720 = RM240.\nJawapan: 240',
 2);

-- ===================
-- Subtopic 12: Kadar dan Kadaran
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(12, 'mcq',
 'Sebuah kereta bergerak pada kelajuan 80 km/j. Berapa jauh yang dilalui dalam 3 jam?',
 '["A. 83 km", "B. 160 km", "C. 240 km", "D. 320 km"]',
 'C',
 'Langkah 1: Jarak = Kelajuan × Masa.\nLangkah 2: 80 × 3 = 240 km.\nJawapan: 240 km',
 1),

(12, 'mcq',
 'Seorang pekerja boleh siapkan kerja dalam 6 jam. Pekerja lain boleh siapkan kerja yang sama dalam 3 jam. Jika mereka bekerja bersama, berapa jam untuk siap?',
 '["A. 1 jam", "B. 1.5 jam", "C. 2 jam", "D. 4.5 jam"]',
 'C',
 'Langkah 1: Kadar pekerja A = 1/6 kerja/jam, pekerja B = 1/3 kerja/jam.\nLangkah 2: Kadar bersama = 1/6 + 1/3 = 1/6 + 2/6 = 3/6 = 1/2 kerja/jam.\nLangkah 3: Masa = 1 ÷ (1/2) = 2 jam.\nJawapan: 2 jam',
 3),

(12, 'short',
 'y berkadar terus dengan x. Jika y = 12 apabila x = 4, cari y apabila x = 7.',
 NULL,
 '21',
 'Langkah 1: Kadar k = y ÷ x = 12 ÷ 4 = 3.\nLangkah 2: y = k × x = 3 × 7 = 21.\nJawapan: 21',
 2),

(12, 'mcq',
 'y berkadar songsang dengan x. Jika y = 8 apabila x = 3, cari y apabila x = 6.',
 '["A. 2", "B. 4", "C. 12", "D. 16"]',
 'B',
 'Langkah 1: y berkadar songsang: y × x = pemalar k.\nLangkah 2: k = 8 × 3 = 24.\nLangkah 3: y = 24 ÷ 6 = 4.\nJawapan: 4',
 2),

(12, 'mcq',
 'Paip A boleh mengisi tangki dalam 4 jam. Paip B boleh mengosongkan tangki dalam 6 jam. Jika kedua-dua paip dibuka serentak apabila tangki kosong, berapa jam tangki akan penuh?',
 '["A. 6 jam", "B. 8 jam", "C. 10 jam", "D. 12 jam"]',
 'D',
 'Langkah 1: Kadar isi A = 1/4 tangki/jam (masuk), kadar kosong B = 1/6 tangki/jam (keluar).\nLangkah 2: Kadar bersih = 1/4 - 1/6 = 3/12 - 2/12 = 1/12 tangki/jam.\nLangkah 3: Masa = 1 ÷ (1/12) = 12 jam.\nJawapan: 12 jam',
 3),

(12, 'mcq',
 'Sebuah kereta menempuh 180 km dalam 2.5 jam. Berapakah kelajuan puratanya?',
 '["A. 60 km/j", "B. 72 km/j", "C. 80 km/j", "D. 90 km/j"]',
 'B',
 'Langkah 1: Kelajuan = Jarak ÷ Masa.\nLangkah 2: 180 ÷ 2.5 = 72 km/j.\nJawapan: 72 km/j',
 1),

(12, 'short',
 'Jika 8 pekerja boleh siapkan projek dalam 15 hari, berapa hari yang diperlukan jika hanya ada 6 pekerja? (kadar songsang)',
 NULL,
 '20',
 'Langkah 1: Kadar songsang: pekerja × hari = pemalar.\nLangkah 2: 8 × 15 = 120.\nLangkah 3: 6 × hari = 120 → hari = 120 ÷ 6 = 20 hari.\nJawapan: 20',
 3);

-- ===================
-- Subtopic 13: Teorem Pythagoras
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(13, 'mcq',
 'Sebuah segitiga bersudut tegak mempunyai kateti 3 cm dan 4 cm. Cari hipotenus.',
 '["A. 5 cm", "B. 7 cm", "C. 9 cm", "D. 25 cm"]',
 'A',
 'Langkah 1: Guna Teorem Pythagoras: c² = a² + b².\nLangkah 2: c² = 3² + 4² = 9 + 16 = 25.\nLangkah 3: c = √25 = 5 cm.\nJawapan: 5 cm',
 1),

(13, 'mcq',
 'Adakah segitiga dengan sisi 5 cm, 12 cm, dan 13 cm merupakan segitiga bersudut tegak?',
 '["A. Ya, kerana 5² + 12² = 13²", "B. Tidak, kerana 5 + 12 ≠ 13", "C. Ya, kerana semua sisi berbeza", "D. Tidak, kerana 5² + 12² ≠ 13²"]',
 'A',
 'Langkah 1: Semak: 5² + 12² = 25 + 144 = 169.\nLangkah 2: 13² = 169.\nLangkah 3: Oleh kerana 5² + 12² = 13², ia adalah segitiga bersudut tegak.\nJawapan: Ya, kerana 5² + 12² = 13²',
 1),

(13, 'short',
 'Sebuah segitiga bersudut tegak mempunyai hipotenus 10 cm dan satu kateti 6 cm. Cari kateti yang lain.',
 NULL,
 '8',
 'Langkah 1: a² + b² = c² → b² = c² - a².\nLangkah 2: b² = 10² - 6² = 100 - 36 = 64.\nLangkah 3: b = √64 = 8 cm.\nJawapan: 8',
 2),

(13, 'mcq',
 'Sebuah tangga 13 m disandarkan pada dinding. Kaki tangga berjarak 5 m dari dinding. Setinggi manakah tangga menyentuh dinding?',
 '["A. 8 m", "B. 10 m", "C. 12 m", "D. 18 m"]',
 'C',
 'Langkah 1: Guna Teorem Pythagoras: tinggi² + 5² = 13².\nLangkah 2: tinggi² = 169 - 25 = 144.\nLangkah 3: tinggi = √144 = 12 m.\nJawapan: 12 m',
 2),

(13, 'mcq',
 'Cari panjang pepenjuru segi empat tepat dengan panjang 24 cm dan lebar 10 cm.',
 '["A. 17 cm", "B. 20 cm", "C. 26 cm", "D. 34 cm"]',
 'C',
 'Langkah 1: Pepenjuru² = panjang² + lebar².\nLangkah 2: d² = 24² + 10² = 576 + 100 = 676.\nLangkah 3: d = √676 = 26 cm.\nJawapan: 26 cm',
 3),

(13, 'short',
 'Sebuah kawasan padang berbentuk segi empat tepat dengan panjang 40 m dan lebar 30 m. Cari jarak pepenjuru merentasi padang.',
 NULL,
 '50',
 'Langkah 1: d² = 40² + 30² = 1600 + 900 = 2500.\nLangkah 2: d = √2500 = 50 m.\nJawapan: 50',
 2),

(13, 'mcq',
 'Titik P berada pada koordinat (0, 0) dan titik Q pada (6, 8). Cari jarak PQ.',
 '["A. 7 unit", "B. 10 unit", "C. 12 unit", "D. 14 unit"]',
 'B',
 'Langkah 1: Guna jarak: PQ² = (6-0)² + (8-0)² = 36 + 64 = 100.\nLangkah 2: PQ = √100 = 10 unit.\nJawapan: 10 unit',
 3);

-- ===================
-- Subtopic 14: Nisbah Trigonometri
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES

(14, 'mcq',
 'Dalam segitiga bersudut tegak, sin θ sama dengan:',
 '["A. sisi bertentangan ÷ hipotenus", "B. sisi bersebelahan ÷ hipotenus", "C. sisi bertentangan ÷ sisi bersebelahan", "D. hipotenus ÷ sisi bertentangan"]',
 'A',
 'Langkah 1: Ingat mnemonik SOH-CAH-TOA.\nLangkah 2: SOH → Sin = Opposite (bertentangan) / Hypotenuse (hipotenus).\nJawapan: sisi bertentangan ÷ hipotenus',
 1),

(14, 'mcq',
 'Jika kos θ = 5/13 dalam segitiga bersudut tegak, cari sin θ.',
 '["A. 5/13", "B. 12/13", "C. 13/12", "D. 13/5"]',
 'B',
 'Langkah 1: kos θ = sisi bersebelahan/hipotenus = 5/13.\nLangkah 2: Sisi bertentangan = √(13² - 5²) = √(169 - 25) = √144 = 12.\nLangkah 3: sin θ = 12/13.\nJawapan: 12/13',
 2),

(14, 'short',
 'Dalam segitiga bersudut tegak, sisi bertentangan = 5 cm dan sisi bersebelahan = 5 cm. Cari nilai tan θ.',
 NULL,
 '1',
 'Langkah 1: tan θ = sisi bertentangan ÷ sisi bersebelahan.\nLangkah 2: tan θ = 5 ÷ 5 = 1.\nJawapan: 1',
 1),

(14, 'mcq',
 'Dalam segitiga bersudut tegak, hipotenus = 10 cm dan sudut = 30°. Cari panjang sisi bertentangan. (sin 30° = 0.5)',
 '["A. 3 cm", "B. 5 cm", "C. 7 cm", "D. 10 cm"]',
 'B',
 'Langkah 1: sin θ = sisi bertentangan / hipotenus.\nLangkah 2: sisi bertentangan = hipotenus × sin 30° = 10 × 0.5 = 5 cm.\nJawapan: 5 cm',
 2),

(14, 'mcq',
 'Sebuah menara tinggi 30 m. Dari titik di tanah, sudut dongakan ke puncak ialah 60°. Cari jarak mendatar dari titik itu ke kaki menara. (tan 60° = √3 ≈ 1.732)',
 '["A. 10 m", "B. 17.3 m", "C. 30 m", "D. 51.96 m"]',
 'B',
 'Langkah 1: tan 60° = tinggi / jarak mendatar.\nLangkah 2: jarak mendatar = tinggi ÷ tan 60° = 30 ÷ 1.732 ≈ 17.3 m.\nJawapan: 17.3 m',
 3),

(14, 'mcq',
 'Cari nilai kos 0° dan sin 90°.',
 '["A. kos 0° = 0 dan sin 90° = 0", "B. kos 0° = 1 dan sin 90° = 0", "C. kos 0° = 1 dan sin 90° = 1", "D. kos 0° = 0 dan sin 90° = 1"]',
 'C',
 'Langkah 1: Nilai sudut istimewa: kos 0° = 1 (apabila sudut = 0°, sisi bersebelahan = hipotenus).\nLangkah 2: sin 90° = 1 (apabila sudut = 90°, sisi bertentangan = hipotenus).\nJawapan: kos 0° = 1 dan sin 90° = 1',
 2),

(14, 'short',
 'Dalam segitiga bersudut tegak ABC dengan sudut tegak di C, jika AB = 13 cm dan BC = 5 cm, cari tan A.',
 NULL,
 '5/12',
 'Langkah 1: AC = √(AB² - BC²) = √(169 - 25) = √144 = 12 cm.\nLangkah 2: tan A = sisi bertentangan / sisi bersebelahan = BC / AC = 5/12.\nJawapan: 5/12',
 3);

-- Reset sequences
SELECT setval('topics_id_seq', (SELECT MAX(id) FROM topics));
SELECT setval('subtopics_id_seq', (SELECT MAX(id) FROM subtopics));
