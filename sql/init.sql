CREATE TABLE "user" (
  "username" text PRIMARY KEY,
  "pwd" text,
  "is_active" boolean
);

CREATE TABLE "roles" (
  "description" text PRIMARY KEY
);

CREATE TABLE "user_role_bridge" (
  "description" text,
  "username" text,
  PRIMARY KEY ("description", "username")
);

CREATE TABLE "pegawai" (
  "uuid" text PRIMARY KEY,
  "fullname" text,
  "fullname_with_title" text,
  "nickname" text,
  "nip" text,
  "old_nip" text,
  "phone_number" text,
  "username" text UNIQUE,
  "status_pegawai" integer,
  "jabatan" integer
);

CREATE TABLE "jabatan" (
  "id" integer PRIMARY KEY,
  "desc" text NOT NULL
);

CREATE TABLE "status_pegawai" (
  "id" integer PRIMARY KEY,
  "desc" text NOT NULL
);

CREATE TABLE "tim" (
  "uuid" text PRIMARY KEY,
  "title" text NOT NULL,
  "desc" text
);

CREATE TABLE "tim_role" (
  "id" integer PRIMARY KEY,
  "desc" text NOT NULL
);

CREATE TABLE "pegawai_tim" (
  "uuid" text PRIMARY KEY,
  "pegawai" text NOT NULL,
  "tim" text NOT NULL,
  "tim_role" integer NOT NULL
);

CREATE TABLE "eom_penilaian" (
  "uuid" text PRIMARY KEY,
  "desc" text,
  "periode" text UNIQUE NOT NULL,
  "start_date" text NOT NULL,
  "end_date" text NOT NULL,
  "status" integer NOT NULL,
  "created_at" text,
  "last_updated" text
);

CREATE TABLE "eom_status" (
  "id" integer PRIMARY KEY,
  "desc" text
);

CREATE TABLE "eom_candidate" (
  "uuid" text PRIMARY KEY,
  "penilaian" text NOT NULL,
  "order" integer NOT NULL,
  "tim" text,
  "pegawai" text NOT NULL
);

CREATE TABLE "eom_data" (
  "uuid" text PRIMARY KEY,
  "candidate" text,
  "kjk" double precision NOT NULL DEFAULT 0,
  "vote" integer NOT NULL DEFAULT 0,
  "ckp" double precision NOT NULL DEFAULT 0,
  "created_at" text,
  "last_updated" text
);

CREATE TABLE "eom_vote" (
  "uuid" text PRIMARY KEY,
  "penilaian" text NOT NULL,
  "voter" text NOT NULL,
  "choice1" text,
  "choice2" text,
  "created_at" text NOT NULL,
  "last_updated" text NOT NULL,
  "is_complete" boolean
);

CREATE TABLE "eom_penilaian360" (
  "uuid" text PRIMARY KEY,
  "penilaian" text NOT NULL,
  "voter" text NOT NULL,
  "candidate" text NOT NULL,
  "value" double precision NOT NULL DEFAULT 0,
  "is_complete" boolean NOT NULL DEFAULT false,
  "created_at" text NOT NULL,
  "last_updated" text NOT NULL
);

CREATE TABLE "penilaian360_questions" (
  "uuid" text PRIMARY KEY,
  "title" text NOT NULL,
  "desc" text NOT NULL,
  "order" integer NOT NULL,
  "tag" text,
  "is_active" boolean NOT NULL
);

CREATE TABLE "penilaian360_answers" (
  "uuid" text PRIMARY KEY,
  "penilaian360" text NOT NULL,
  "question" text,
  "value" integer NOT NULL DEFAULT 0
);

ALTER TABLE "user_role_bridge" ADD FOREIGN KEY ("description") REFERENCES "roles" ("description");

ALTER TABLE "user_role_bridge" ADD FOREIGN KEY ("username") REFERENCES "user" ("username");

ALTER TABLE "pegawai" ADD FOREIGN KEY ("username") REFERENCES "user" ("username") ON UPDATE CASCADE;

ALTER TABLE "pegawai" ADD FOREIGN KEY ("status_pegawai") REFERENCES "status_pegawai" ("id") ON UPDATE CASCADE;

ALTER TABLE "pegawai" ADD FOREIGN KEY ("jabatan") REFERENCES "jabatan" ("id") ON UPDATE CASCADE;

ALTER TABLE "pegawai_tim" ADD FOREIGN KEY ("pegawai") REFERENCES "pegawai" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "pegawai_tim" ADD FOREIGN KEY ("tim") REFERENCES "tim" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "pegawai_tim" ADD FOREIGN KEY ("tim_role") REFERENCES "tim_role" ("id") ON UPDATE CASCADE;

ALTER TABLE "eom_penilaian" ADD FOREIGN KEY ("status") REFERENCES "eom_status" ("id") ON UPDATE CASCADE;

ALTER TABLE "eom_candidate" ADD FOREIGN KEY ("penilaian") REFERENCES "eom_penilaian" ("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "eom_candidate" ADD FOREIGN KEY ("tim") REFERENCES "tim" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "eom_candidate" ADD FOREIGN KEY ("pegawai") REFERENCES "pegawai" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "eom_data" ADD FOREIGN KEY ("candidate") REFERENCES "eom_candidate" ("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "eom_vote" ADD FOREIGN KEY ("penilaian") REFERENCES "eom_penilaian" ("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "eom_vote" ADD FOREIGN KEY ("choice1") REFERENCES "pegawai" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "eom_vote" ADD FOREIGN KEY ("choice2") REFERENCES "pegawai" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "eom_vote" ADD FOREIGN KEY ("voter") REFERENCES "pegawai" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "eom_penilaian360" ADD FOREIGN KEY ("penilaian") REFERENCES "eom_penilaian" ("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "eom_penilaian360" ADD FOREIGN KEY ("voter") REFERENCES "pegawai" ("uuid");

ALTER TABLE "eom_penilaian360" ADD FOREIGN KEY ("candidate") REFERENCES "eom_candidate" ("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "penilaian360_answers" ADD FOREIGN KEY ("penilaian360") REFERENCES "eom_penilaian360" ("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "penilaian360_answers" ADD FOREIGN KEY ("question") REFERENCES "penilaian360_questions" ("uuid") ON UPDATE CASCADE;

ALTER TABLE "pegawai_tim" ADD UNIQUE("pegawai","tim");

ALTER TABLE "eom_penilaian360" ADD UNIQUE("penilaian","voter","candidate");

ALTER TABLE "eom_vote" ADD UNIQUE("penilaian","voter");

ALTER TABLE "eom_candidate" ADD UNIQUE ("penilaian","pegawai");

ALTER TABLE "penilaian360_answers" ADD UNIQUE ("penilaian360","question");

ALTER TABLE "eom_data" ADD UNIQUE ("candidate");