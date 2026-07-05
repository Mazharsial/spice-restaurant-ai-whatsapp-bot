-- Spice Garden WhatsApp chatbot schema

CREATE TABLE IF NOT EXISTS chat_logs (
  id          BIGSERIAL PRIMARY KEY,
  wa_from     TEXT        NOT NULL,
  customer    TEXT,
  user_text   TEXT,
  bot_reply   TEXT,
  message_id  TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_chat_logs_from ON chat_logs (wa_from);
CREATE INDEX IF NOT EXISTS idx_chat_logs_created ON chat_logs (created_at);

-- Optional: structured orders (filled later when you add order-extraction)
CREATE TABLE IF NOT EXISTS orders (
  id           BIGSERIAL PRIMARY KEY,
  wa_from      TEXT NOT NULL,
  customer     TEXT,
  items        JSONB,
  total_pkr    NUMERIC(10,2),
  order_type   TEXT,            -- delivery / takeaway / dine-in
  address      TEXT,
  status       TEXT DEFAULT 'pending',  -- pending / confirmed / cancelled
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_orders_from ON orders (wa_from);
