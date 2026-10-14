# Chunk, embed, store

End-to-end ingestion: split `movies.txt` with LangChain (size 250, overlap 35), embed each chunk, and insert all chunks into a Supabase `movies` table.

## Run

```bash
npm install
npm start
```

Needs `OPENAI_API_KEY`, `SUPABASE_URL`, `SUPABASE_API_KEY` in the repository-root `.env` (see `../.env.example`).

Run `movies.sql` in Supabase first. It creates the table and the `match_movies` function that demo 08 uses.

From the Scrimba AI Engineer Path: https://scrimba.com/the-ai-engineer-path-c02v/~01u
