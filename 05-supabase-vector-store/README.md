# Store embeddings in Supabase (pgvector)

Embed ten podcast descriptions and insert `{content, embedding}` rows into a Supabase `documents` table.

## Run

```bash
npm install
npm start
```

Needs `OPENAI_API_KEY`, `SUPABASE_URL`, `SUPABASE_API_KEY` in the repository-root `.env` (see `../.env.example`).

Run `documents.sql` in the Supabase SQL editor first. It creates the table and the `match_documents` search function that demo 07 uses.

From the Scrimba AI Engineer Path: https://scrimba.com/the-ai-engineer-path-c02v/~01p/s06aj7du9r
