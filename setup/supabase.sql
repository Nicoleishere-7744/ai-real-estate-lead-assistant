-- Real Estate AI Lead Assistant - Supabase setup
CREATE TABLE IF NOT EXISTS public.real_estate_leads (
  id BIGSERIAL PRIMARY KEY,
  session_id TEXT UNIQUE NOT NULL,
  name TEXT,
  phone TEXT,
  email TEXT,
  intent TEXT,
  property_type TEXT,
  location TEXT,
  budget TEXT,
  bedrooms TEXT,
  area_requirement TEXT,
  financing TEXT,
  property_details TEXT,
  preferred_date TEXT,
  preferred_time TEXT,
  status TEXT DEFAULT 'cold',
  notes TEXT,
  handoff BOOLEAN DEFAULT FALSE,
  lead_ready BOOLEAN DEFAULT FALSE,
  viewing_intent BOOLEAN DEFAULT FALSE,
  handoff_notified BOOLEAN DEFAULT FALSE,
  conversation TEXT,
  last_contact_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_real_estate_leads_session_id ON public.real_estate_leads(session_id);
CREATE INDEX IF NOT EXISTS idx_real_estate_leads_phone ON public.real_estate_leads(phone);
CREATE INDEX IF NOT EXISTS idx_real_estate_leads_status ON public.real_estate_leads(status);
CREATE INDEX IF NOT EXISTS idx_real_estate_leads_created_at ON public.real_estate_leads(created_at);
