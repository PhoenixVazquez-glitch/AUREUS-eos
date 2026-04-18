-- 1. EXTENDED PROFILES & LEGAL STATUS
CREATE TABLE profiles (
      id UUID REFERENCES auth.users PRIMARY KEY,
        license_signed BOOLEAN DEFAULT false,
          signed_at TIMESTAMPTZ,
            is_blacklisted BOOLEAN DEFAULT false,
              kill_switch_active BOOLEAN DEFAULT false,
                commercial_tier TEXT DEFAULT 'pro' -- 'pro', 'enterprise', 'sovereign'
);

-- 2. DYNAMIC APP CONTROL (The Easy Menu)
CREATE TABLE app_config (
      id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        slug TEXT UNIQUE NOT NULL,
          display_name TEXT NOT NULL,
            is_active BOOLEAN DEFAULT true,
              min_tier TEXT DEFAULT 'pro'
);

-- 3. ENABLE ROW LEVEL SECURITY (The Firewall)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Strict Sovereign Access" ON profiles FOR SELECT USING (auth.uid() = id);

-- 4. INSERT MENU ITEMS
INSERT INTO app_config (slug, display_name, min_tier) VALUES
('dashboard', 'Overview', 'pro'),
('architect', 'Project Engineer', 'pro'),
('vault', 'Forensic Verification', 'enterprise'),
('escrow', 'Capital Control', 'sovereign');

)
)