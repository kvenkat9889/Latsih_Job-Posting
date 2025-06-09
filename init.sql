CREATE TABLE IF NOT EXISTS jobs (
    id SERIAL PRIMARY KEY,
    title TEXT,
    department TEXT,
    company TEXT,
    website TEXT,
    job_type TEXT,
    experience_level TEXT,
    work_mode TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    currency TEXT,
    salary_from NUMERIC,
    salary_to NUMERIC,
    salary_period TEXT,
    start_date DATE,
    deadline DATE,
    job_summary TEXT,
    responsibilities TEXT,
    requirements TEXT,
    skills TEXT,
    benefits TEXT,
    contact_email TEXT,
    contact_phone TEXT,
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create applications table
CREATE TABLE applications (
    id SERIAL PRIMARY KEY,
    job_id INTEGER REFERENCES jobs(id) ON DELETE CASCADE,
    applicant_name VARCHAR(255) NOT NULL,
    applicant_email VARCHAR(255) NOT NULL,
    resume TEXT,
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create favorites table
CREATE TABLE favorites (
    id SERIAL PRIMARY KEY,
    job_id INTEGER REFERENCES jobs(id) ON DELETE CASCADE,
    user_id VARCHAR(255) NOT NULL,
    saved_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(job_id, user_id)
);

-- Create indexes for better query performance
CREATE INDEX idx_jobs_deadline ON jobs(deadline);
CREATE INDEX idx_jobs_search ON jobs USING GIN (
    to_tsvector('english', title || ' ' || company || ' ' || city || ' ' || skills)
);
CREATE INDEX idx_applications_job_id ON applications(job_id);
CREATE INDEX idx_favorites_job_id ON favorites(job_id);
