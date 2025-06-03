CREATE TYPE transaction_type AS ENUM (
    'transfer',
    'withdrawal',
    'deposit',
    'tax',
    'refund'
);

CREATE TYPE transaction_status AS ENUM (
    'pending',
    'completed',
    'failed'
);

CREATE TABLE transactions (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    from_account_id uuid NOT NULL REFERENCES accounts(id) ON DELETE SET NULL,
    to_account_id uuid NOT NULL REFERENCES accounts(id) ON DELETE SET NULL,

    transaction_type transaction_type NOT NULL, -- 'transfer', 'withdrawal', 'deposit', 'tax', 'refund'
    transaction_status transaction_status NOT NULL DEFAULT 'pending', -- 'pending', 'completed', 'failed'

    amount BIGINT NOT NULL,
    currency currency NOT NULL DEFAULT 'INR',

    reference_id TEXT,
    description TEXT,

    created_at TIMESTAMP with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_transactions_from_account_id ON transactions (from_account_id);
CREATE INDEX idx_transactions_to_account_id ON transactions (to_account_id);
CREATE INDEX idx_transactions_transaction_type ON transactions (transaction_type);
CREATE INDEX idx_transactions_transaction_status ON transactions (transaction_status);
