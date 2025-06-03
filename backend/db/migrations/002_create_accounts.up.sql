CREATE TYPE account_type AS ENUM (
    'savings',
    'current',
    'fixed'
);

CREATE TYPE account_status AS ENUM (
    'active',
    'inactive',
    'frozen'
    'closed'
);

CREATE TYPE currency AS ENUM (
    'INR',
    'USD',
    'EUR',
    'GBP',
    'AUD',
    'CAD',
    'SGD',
    'JPY',
    'CNY'
);

CREATE TABLE accounts (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    account_number VARCHAR(15) NOT NULL UNIQUE,
    account_type account_type NOT NULL, -- 'savings', 'current', 'fixed'
    balance BIGINT NOT NULL DEFAULT 0,
    currency currency NOT NULL DEFAULT 'INR',
    status account_status NOT NULL DEFAULT 'active', -- 'active', 'inactive', 'c losed'

    is_frozen BOOLEAN NOT NULL DEFAULT FALSE,
    frozen_at TIMESTAMP with time zone,

    created_at TIMESTAMP with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone DEFAULT CURRENT_TIMESTAMP

);

CREATE INDEX idx_accounts_owner_id ON accounts (owner_id);
CREATE INDEX idx_accounts_account_number ON accounts (account_number);
CREATE INDEX idx_accounts_account_type ON accounts (account_type);
CREATE INDEX idx_accounts_status ON accounts (status);