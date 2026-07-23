-- Create Lab Synthesis Table with AI Future-Proofing Columns
CREATE TABLE public.lab_synthesis (
    id SERIAL PRIMARY KEY,
    adhesive_id VARCHAR(50),
    worker VARCHAR(50),
    category VARCHAR(50),
    description TEXT,
    solid_content_theoretical DOUBLE PRECISION,
    solid_content_measured DOUBLE PRECISION,
    yield_percent DOUBLE PRECISION,
    conversion_rate DOUBLE PRECISION,
    coagulum_percent DOUBLE PRECISION,
    ph DOUBLE PRECISION,
    tg DOUBLE PRECISION,
    viscosity_cp DOUBLE PRECISION,
    initial_emulsifier_conc DOUBLE PRECISION,
    particle_size_nm DOUBLE PRECISION,
    scale VARCHAR(50),
    monomers TEXT,
    solvents TEXT,
    initiators TEXT,
    emulsifiers_additives TEXT,
    reaction_time VARCHAR(50),
    temperature VARCHAR(50),
    -- AI Future Schemas
    molecular_weight_mw DOUBLE PRECISION,
    molecular_weight_mn DOUBLE PRECISION,
    pdi DOUBLE PRECISION,
    ft_ir_spectrum_id INTEGER REFERENCES public.ft_ir_spectra(id)
);

-- Create Lab Coating Table with AI Future-Proofing Columns
CREATE TABLE public.lab_coating (
    id SERIAL PRIMARY KEY,
    lab_serial TEXT,
    category TEXT,
    coating_date TEXT,
    backing TEXT,
    adhesive_id TEXT,
    curing_agent TEXT,
    additives TEXT,
    coating_weight_um DOUBLE PRECISION,
    bar_coater_num INTEGER,
    worker TEXT,
    adhesion TEXT,
    heat_pressing TEXT,
    heat_resistance TEXT,
    weather_resistance TEXT,
    moisture_resistance TEXT,
    outdoor_exposure TEXT,
    holding_power_processing TEXT,
    bending TEXT,
    laser_cutting TEXT,
    impact_resistance TEXT,
    note TEXT,
    -- AI Future Schemas
    initial_tack DOUBLE PRECISION,
    holding_power_quant DOUBLE PRECISION,
    transmittance DOUBLE PRECISION,
    haze DOUBLE PRECISION
);

ALTER TABLE public.lab_synthesis OWNER TO sg_user;
ALTER TABLE public.lab_coating OWNER TO sg_user;
