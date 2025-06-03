CREATE TYPE kyc_status AS ENUM (
    'pending',
    'verified',
    'rejected'
);

CREATE TYPE user_role AS ENUM (
    'customer',
    'admin',
    'employee'
);

CREATE TABLE users (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    profile_img_url TEXT,
    date_of_birth DATE NOT NULL,

    aadhar_number VARCHAR(12) NOT NULL UNIQUE,
    pan_number VARCHAR(10) NOT NULL UNIQUE,
    kyc_status kyc_status NOT NULL DEFAULT 'pending',
    kyc_verified_at TIMESTAMP,
    role user_role NOT NULL DEFAULT 'customer',

    created_at TIMESTAMP with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP with time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_phone_number ON users (phone_number);
CREATE INDEX idx_users_aadhar_number ON users (aadhar_number);
CREATE INDEX idx_users_pan_number ON users (pan_number);
CREATE INDEX idx_users_kyc_status ON users (kyc_status);
CREATE INDEX idx_users_role ON users (role);