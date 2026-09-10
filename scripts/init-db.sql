CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS customer (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(255),
    phone VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS vehicle (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customer(id) ON DELETE RESTRICT,
    plate VARCHAR(10) NOT NULL UNIQUE,
    model VARCHAR(100) NOT NULL,
    manufacture_year INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS work_order (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customer(id) ON DELETE RESTRICT,
    vehicle_id UUID NOT NULL REFERENCES vehicle(id) ON DELETE RESTRICT,
    status VARCHAR(30) NOT NULL DEFAULT 'OPEN',
    opened_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    closed_at TIMESTAMPTZ,
    observation TEXT
);

CREATE TABLE IF NOT EXISTS work_order_status_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    work_order_id UUID NOT NULL REFERENCES work_order(id) ON DELETE CASCADE,
    from_status VARCHAR(30) NOT NULL,
    to_status VARCHAR(30) NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS service_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    work_order_id UUID NOT NULL REFERENCES work_order(id) ON DELETE CASCADE,
    description VARCHAR(255) NOT NULL,
    price NUMERIC(10,2) NOT NULL DEFAULT 0,
    execution_status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_vehicle_customer_id ON vehicle(customer_id);
CREATE INDEX IF NOT EXISTS idx_work_order_customer_id ON work_order(customer_id);
CREATE INDEX IF NOT EXISTS idx_work_order_vehicle_id ON work_order(vehicle_id);
CREATE INDEX IF NOT EXISTS idx_service_item_work_order_id ON service_item(work_order_id);
CREATE INDEX IF NOT EXISTS idx_status_history_work_order_id ON work_order_status_history(work_order_id);
