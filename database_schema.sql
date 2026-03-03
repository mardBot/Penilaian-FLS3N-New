-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- 1. Table: master_schools
-- Menyimpan daftar nama sekolah
-- ==========================================
CREATE TABLE IF NOT EXISTS master_schools (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2. Table: master_categories
-- Menyimpan daftar cabang lomba
-- ==========================================
CREATE TABLE IF NOT EXISTS master_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. Table: peserta
-- Menyimpan data peserta lomba
-- ==========================================
CREATE TABLE IF NOT EXISTS peserta (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    school TEXT NOT NULL,
    birth_info TEXT,
    category TEXT NOT NULL,
    status TEXT DEFAULT 'Pending',
    display_number TEXT,
    scores JSONB DEFAULT '["", "", ""]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 4. Table: settings
-- Menyimpan pengaturan aplikasi (hanya 1 baris)
-- ==========================================
CREATE TABLE IF NOT EXISTS settings (
    id INTEGER PRIMARY KEY DEFAULT 1,
    judge_name TEXT,
    judge_nip TEXT,
    place TEXT,
    date TEXT,
    kkks_chairman_name TEXT,
    kkks_chairman_nip TEXT,
    coordinator_name TEXT,
    coordinator_nip TEXT,
    head_of_department_name TEXT,
    head_of_department_nip TEXT,
    category_judges JSONB DEFAULT '{}'::jsonb,
    logo_kabupaten TEXT,
    logo_fls3n TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- Matikan RLS (Row Level Security) agar aplikasi bisa baca/tulis tanpa login
-- ==========================================
ALTER TABLE master_schools DISABLE ROW LEVEL SECURITY;
ALTER TABLE master_categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE peserta DISABLE ROW LEVEL SECURITY;
ALTER TABLE settings DISABLE ROW LEVEL SECURITY;

-- ==========================================
-- Aktifkan Realtime (Supabase Realtime)
-- ==========================================
-- Hapus publication lama jika ada, lalu buat ulang dan tambahkan tabel
BEGIN;
  DROP PUBLICATION IF EXISTS supabase_realtime;
  CREATE PUBLICATION supabase_realtime;
COMMIT;

ALTER PUBLICATION supabase_realtime ADD TABLE master_schools;
ALTER PUBLICATION supabase_realtime ADD TABLE master_categories;
ALTER PUBLICATION supabase_realtime ADD TABLE peserta;
ALTER PUBLICATION supabase_realtime ADD TABLE settings;

-- ==========================================
-- Insert Default Data
-- ==========================================

-- Insert default settings
INSERT INTO settings (id, head_of_department_name, head_of_department_nip) 
VALUES (1, 'TRI KRISNI ASTUTI, S.Sos, MM.', '197004241997032007')
ON CONFLICT (id) DO NOTHING;

-- Insert default categories (Cabang Lomba)
INSERT INTO master_categories (name) VALUES 
('Menyanyi Solo'),
('Seni Tari'),
('Pantomim'),
('Gambar Bercerita'),
('Kriya Anyam')
ON CONFLICT (name) DO NOTHING;

-- Insert default schools (Sekolah)
INSERT INTO master_schools (name) VALUES 
('SDN BAUJENG I'),
('SDN BAUJENG II'),
('SDN BEJI I'),
('SDN BEJI II'),
('SDN BEJI IV'),
('SDN CANGKRINGMALANG I'),
('SDN CANGKRINGMALANG II'),
('SDN CANGKRINGMALANG III'),
('SDN GAJAHBENDO'),
('SDN GLANGGANG I'),
('SDN GLANGGANG II'),
('SDN GUNUNGGANGSIR I'),
('SDN GUNUNGGANGSIR II'),
('SDN GUNUNGGANGSIR III'),
('SDN GUNUNGGANGSIR IV'),
('SDN KEDUNGBOTO'),
('SDN KEDUNGRINGIN I'),
('SDN KEDUNGRINGIN II'),
('SDN KENEP'),
('SDN NGINGAS'),
('SDN PAGAR'),
('SDN SIDOWAYAH I'),
('SDN SIDOWAYAH II'),
('SDN SIDOWAYAH III'),
('SDN WONOKOYO I'),
('SDN WONOKOYO II'),
('SDN WONOKOYO III'),
('SDI AL-MAARIF'),
('SDI AL-YASINI'),
('SDI DARUL MUKMININ'),
('SDI MASYITHOH'),
('SDI MIFTAHUL ULUM'),
('SDI SUNAN AMPEL'),
('SDI WAHID HASYIM')
ON CONFLICT (name) DO NOTHING;
