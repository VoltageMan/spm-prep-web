-- ============================================================
-- SPM Mathematics seed data
-- 3 topics, 8 subtopics, ~40 questions with BM explanations
-- ============================================================

-- Topics
INSERT INTO topics (id, subject, name, order_index) VALUES
(1, 'Matematik', 'Nombor dan Operasi',   1),
(2, 'Matematik', 'Algebra',              2),
(3, 'Matematik', 'Geometri dan Ukuran',  3);

-- Subtopics
INSERT INTO subtopics (id, topic_id, name, order_index) VALUES
(1, 1, 'Nombor Bulat dan Operasi Asas',     1),
(2, 1, 'Pecahan dan Perpuluhan',             2),
(3, 1, 'Peratusan',                          3),
(4, 2, 'Ungkapan Algebra',                   4),
(5, 2, 'Persamaan Linear',                   5),
(6, 2, 'Ketaksamaan Linear',                 6),
(7, 3, 'Perimeter dan Luas',                 7),
(8, 3, 'Isi Padu dan Luas Permukaan',        8);

-- ===================
-- Subtopic 1: Nombor Bulat dan Operasi Asas
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(1, 'mcq',
 'Berapakah nilai bagi -8 + 15?',
 '["A. -23", "B. -7", "C. 7", "D. 23"]',
 'C',
 'Langkah 1: Kenal pasti operasi — tambah nombor negatif dengan positif.\nLangkah 2: 15 - 8 = 7.\nLangkah 3: Oleh kerana |15| > |-8|, jawapan positif.\nJawapan: 7',
 1),

(1, 'mcq',
 'Hitung: (-6) × (-4)',
 '["A. -24", "B. -10", "C. 10", "D. 24"]',
 'D',
 'Langkah 1: Negatif × Negatif = Positif.\nLangkah 2: 6 × 4 = 24.\nJawapan: 24',
 1),

(1, 'short',
 'Hitung: 144 ÷ (-12)',
 NULL,
 '-12',
 'Langkah 1: 144 ÷ 12 = 12.\nLangkah 2: Positif ÷ Negatif = Negatif.\nJawapan: -12',
 2),

(1, 'mcq',
 'Apakah nilai bagi 3² + 4²?',
 '["A. 7", "B. 14", "C. 25", "D. 49"]',
 'C',
 'Langkah 1: 3² = 9.\nLangkah 2: 4² = 16.\nLangkah 3: 9 + 16 = 25.\nJawapan: 25',
 2),

(1, 'short',
 'Cari nilai √196.',
 NULL,
 '14',
 'Langkah 1: 14 × 14 = 196.\nJawapan: √196 = 14',
 2);

-- ===================
-- Subtopic 2: Pecahan dan Perpuluhan
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(2, 'mcq',
 'Ringkaskan: 2/3 + 1/4',
 '["A. 3/7", "B. 8/12", "C. 11/12", "D. 1"]',
 'C',
 'Langkah 1: PSTK bagi 3 dan 4 ialah 12.\nLangkah 2: 2/3 = 8/12, 1/4 = 3/12.\nLangkah 3: 8/12 + 3/12 = 11/12.\nJawapan: 11/12',
 1),

(2, 'short',
 'Tukarkan 3/8 kepada perpuluhan.',
 NULL,
 '0.375',
 'Langkah 1: 3 ÷ 8 = 0.375.\nJawapan: 0.375',
 1),

(2, 'mcq',
 'Hitung: 5/6 - 1/3',
 '["A. 4/6", "B. 1/2", "C. 4/3", "D. 2/3"]',
 'B',
 'Langkah 1: Samakan penyebut. 1/3 = 2/6.\nLangkah 2: 5/6 - 2/6 = 3/6 = 1/2.\nJawapan: 1/2',
 2),

(2, 'mcq',
 'Hitung: 2.4 × 0.5',
 '["A. 0.12", "B. 1.2", "C. 2.9", "D. 12"]',
 'B',
 'Langkah 1: 2.4 × 0.5 = 2.4 ÷ 2 = 1.2.\nJawapan: 1.2',
 1),

(2, 'short',
 'Hitung: 7/5 - 0.6',
 NULL,
 '0.8',
 'Langkah 1: 7/5 = 1.4.\nLangkah 2: 1.4 - 0.6 = 0.8.\nJawapan: 0.8',
 2);

-- ===================
-- Subtopic 3: Peratusan
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(3, 'mcq',
 'Berapakah 25% daripada 200?',
 '["A. 25", "B. 50", "C. 75", "D. 100"]',
 'B',
 'Langkah 1: 25% = 25/100 = 0.25.\nLangkah 2: 0.25 × 200 = 50.\nJawapan: 50',
 1),

(3, 'short',
 'Tukarkan 3/5 kepada peratusan.',
 NULL,
 '60',
 'Langkah 1: 3/5 × 100 = 60.\nJawapan: 60%',
 1),

(3, 'mcq',
 'Harga asal baju ialah RM80. Diskaun 15%. Berapakah harga selepas diskaun?',
 '["A. RM65", "B. RM68", "C. RM70", "D. RM12"]',
 'B',
 'Langkah 1: Diskaun = 15% × 80 = RM12.\nLangkah 2: Harga baru = 80 - 12 = RM68.\nJawapan: RM68',
 2),

(3, 'mcq',
 'Penduduk sebuah kampung meningkat dari 500 ke 600. Berapakah peratusan peningkatan?',
 '["A. 10%", "B. 15%", "C. 20%", "D. 25%"]',
 'C',
 'Langkah 1: Peningkatan = 600 - 500 = 100.\nLangkah 2: Peratusan = (100/500) × 100 = 20%.\nJawapan: 20%',
 2),

(3, 'short',
 'Ali mendapat 45 daripada 60 markah. Berapakah peratusannya?',
 NULL,
 '75',
 'Langkah 1: 45/60 × 100 = 75.\nJawapan: 75%',
 2);

-- ===================
-- Subtopic 4: Ungkapan Algebra
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(4, 'mcq',
 'Ringkaskan: 3x + 5x - 2x',
 '["A. 4x", "B. 6x", "C. 8x", "D. 10x"]',
 'B',
 'Langkah 1: Kumpul sebutan serupa: 3x + 5x - 2x.\nLangkah 2: (3 + 5 - 2)x = 6x.\nJawapan: 6x',
 1),

(4, 'mcq',
 'Kembangkan: 2(3a + 4)',
 '["A. 6a + 4", "B. 5a + 6", "C. 6a + 8", "D. 3a + 8"]',
 'C',
 'Langkah 1: 2 × 3a = 6a.\nLangkah 2: 2 × 4 = 8.\nJawapan: 6a + 8',
 1),

(4, 'mcq',
 'Faktorkan: 6x + 9',
 '["A. 2(3x + 9)", "B. 3(2x + 3)", "C. 6(x + 3)", "D. 3(x + 3)"]',
 'B',
 'Langkah 1: FSTB bagi 6 dan 9 ialah 3.\nLangkah 2: 6x ÷ 3 = 2x, 9 ÷ 3 = 3.\nLangkah 3: 3(2x + 3).\nJawapan: 3(2x + 3)',
 2),

(4, 'short',
 'Jika x = 3, cari nilai bagi 2x² - 5.',
 NULL,
 '13',
 'Langkah 1: 2(3)² - 5.\nLangkah 2: 2(9) - 5 = 18 - 5 = 13.\nJawapan: 13',
 2),

(4, 'mcq',
 'Ringkaskan: (x + 2)(x + 3)',
 '["A. x² + 5x + 5", "B. x² + 5x + 6", "C. x² + 6x + 5", "D. x² + 6x + 6"]',
 'B',
 'Langkah 1: x×x = x².\nLangkah 2: x×3 + 2×x = 5x.\nLangkah 3: 2×3 = 6.\nLangkah 4: x² + 5x + 6.\nJawapan: x² + 5x + 6',
 3);

-- ===================
-- Subtopic 5: Persamaan Linear
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(5, 'mcq',
 'Selesaikan: 2x + 3 = 11',
 '["A. x = 3", "B. x = 4", "C. x = 5", "D. x = 7"]',
 'B',
 'Langkah 1: 2x = 11 - 3 = 8.\nLangkah 2: x = 8 ÷ 2 = 4.\nJawapan: x = 4',
 1),

(5, 'short',
 'Selesaikan: 5x - 7 = 18',
 NULL,
 '5',
 'Langkah 1: 5x = 18 + 7 = 25.\nLangkah 2: x = 25 ÷ 5 = 5.\nJawapan: x = 5',
 1),

(5, 'mcq',
 'Selesaikan: 3(x - 2) = 12',
 '["A. x = 2", "B. x = 4", "C. x = 6", "D. x = 10"]',
 'C',
 'Langkah 1: 3x - 6 = 12.\nLangkah 2: 3x = 18.\nLangkah 3: x = 6.\nJawapan: x = 6',
 2),

(5, 'short',
 'Selesaikan: x/4 + 2 = 5',
 NULL,
 '12',
 'Langkah 1: x/4 = 5 - 2 = 3.\nLangkah 2: x = 3 × 4 = 12.\nJawapan: x = 12',
 2),

(5, 'mcq',
 'Jumlah dua nombor ialah 20. Satu nombor ialah 3 kali nombor yang lain. Cari nombor yang lebih besar.',
 '["A. 5", "B. 10", "C. 15", "D. 18"]',
 'C',
 'Langkah 1: Katakan x dan 3x. x + 3x = 20.\nLangkah 2: 4x = 20, x = 5.\nLangkah 3: Nombor besar = 3(5) = 15.\nJawapan: 15',
 3);

-- ===================
-- Subtopic 6: Ketaksamaan Linear
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(6, 'mcq',
 'Selesaikan: x + 3 > 7',
 '["A. x > 3", "B. x > 4", "C. x > 7", "D. x > 10"]',
 'B',
 'Langkah 1: x > 7 - 3.\nLangkah 2: x > 4.\nJawapan: x > 4',
 1),

(6, 'mcq',
 'Selesaikan: 2x - 1 ≤ 9',
 '["A. x ≤ 4", "B. x ≤ 5", "C. x ≤ 8", "D. x ≤ 10"]',
 'B',
 'Langkah 1: 2x ≤ 10.\nLangkah 2: x ≤ 5.\nJawapan: x ≤ 5',
 1),

(6, 'short',
 'Cari integer terbesar yang memenuhi: 3x < 20',
 NULL,
 '6',
 'Langkah 1: x < 20/3 = 6.67.\nLangkah 2: Integer terbesar < 6.67 ialah 6.\nJawapan: 6',
 2),

(6, 'mcq',
 'Jika -2x > 6, maka:',
 '["A. x > -3", "B. x < -3", "C. x > 3", "D. x < 3"]',
 'B',
 'Langkah 1: Bahagi kedua-dua belah dengan -2.\nLangkah 2: Terbalikkan tanda ketaksamaan: x < -3.\nJawapan: x < -3',
 3),

(6, 'short',
 'Berapa banyak integer yang memenuhi: -2 ≤ x < 3?',
 NULL,
 '5',
 'Langkah 1: Integer: -2, -1, 0, 1, 2.\nLangkah 2: Jumlah = 5.\nJawapan: 5',
 2);

-- ===================
-- Subtopic 7: Perimeter dan Luas
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(7, 'mcq',
 'Cari luas segi empat tepat dengan panjang 12 cm dan lebar 5 cm.',
 '["A. 17 cm²", "B. 34 cm²", "C. 60 cm²", "D. 120 cm²"]',
 'C',
 'Langkah 1: Luas = panjang × lebar.\nLangkah 2: Luas = 12 × 5 = 60 cm².\nJawapan: 60 cm²',
 1),

(7, 'short',
 'Cari perimeter segi empat sama dengan sisi 9 cm.',
 NULL,
 '36',
 'Langkah 1: Perimeter = 4 × sisi.\nLangkah 2: 4 × 9 = 36 cm.\nJawapan: 36',
 1),

(7, 'mcq',
 'Cari luas segitiga dengan tapak 10 cm dan tinggi 6 cm.',
 '["A. 16 cm²", "B. 30 cm²", "C. 60 cm²", "D. 80 cm²"]',
 'B',
 'Langkah 1: Luas = ½ × tapak × tinggi.\nLangkah 2: ½ × 10 × 6 = 30 cm².\nJawapan: 30 cm²',
 1),

(7, 'short',
 'Cari luas bulatan dengan jejari 7 cm. (Guna π = 22/7)',
 NULL,
 '154',
 'Langkah 1: Luas = πr².\nLangkah 2: (22/7) × 7² = (22/7) × 49 = 154 cm².\nJawapan: 154',
 2),

(7, 'mcq',
 'Sebuah padang berbentuk segi empat tepat berukuran 50 m × 30 m. Cari kos memagari padang itu jika kos pagar RM8 per meter.',
 '["A. RM640", "B. RM960", "C. RM1280", "D. RM12000"]',
 'C',
 'Langkah 1: Perimeter = 2(50 + 30) = 160 m.\nLangkah 2: Kos = 160 × 8 = RM1280.\nJawapan: RM1280',
 3);

-- ===================
-- Subtopic 8: Isi Padu dan Luas Permukaan
-- ===================
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
(8, 'mcq',
 'Cari isi padu kubus dengan sisi 4 cm.',
 '["A. 12 cm³", "B. 16 cm³", "C. 48 cm³", "D. 64 cm³"]',
 'D',
 'Langkah 1: Isi padu = sisi³.\nLangkah 2: 4³ = 64 cm³.\nJawapan: 64 cm³',
 1),

(8, 'short',
 'Cari isi padu kuboid dengan panjang 5 cm, lebar 3 cm, dan tinggi 4 cm.',
 NULL,
 '60',
 'Langkah 1: Isi padu = p × l × t.\nLangkah 2: 5 × 3 × 4 = 60 cm³.\nJawapan: 60',
 1),

(8, 'mcq',
 'Cari luas permukaan kubus dengan sisi 3 cm.',
 '["A. 9 cm²", "B. 27 cm²", "C. 36 cm²", "D. 54 cm²"]',
 'D',
 'Langkah 1: Luas permukaan = 6 × sisi².\nLangkah 2: 6 × 9 = 54 cm².\nJawapan: 54 cm²',
 2),

(8, 'mcq',
 'Sebuah silinder mempunyai jejari 7 cm dan tinggi 10 cm. Cari isi padunya. (Guna π = 22/7)',
 '["A. 440 cm³", "B. 1540 cm³", "C. 2200 cm³", "D. 3080 cm³"]',
 'B',
 'Langkah 1: Isi padu = πr²h.\nLangkah 2: (22/7) × 49 × 10 = 1540 cm³.\nJawapan: 1540 cm³',
 3),

(8, 'short',
 'Sebuah tangki air berbentuk kuboid berukuran 2 m × 1 m × 0.5 m. Berapa liter air yang boleh diisi? (1 m³ = 1000 liter)',
 NULL,
 '1000',
 'Langkah 1: Isi padu = 2 × 1 × 0.5 = 1 m³.\nLangkah 2: 1 × 1000 = 1000 liter.\nJawapan: 1000',
 2);

-- Reset sequences to avoid conflicts
SELECT setval('topics_id_seq', (SELECT MAX(id) FROM topics));
SELECT setval('subtopics_id_seq', (SELECT MAX(id) FROM subtopics));
