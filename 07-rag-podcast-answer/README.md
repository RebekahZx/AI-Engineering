# RAG: answer from retrieved context

Embed a question, retrieve the closest podcast chunk with `match_documents` (cosine similarity, threshold 0.5), and have GPT-4 answer only from that context, or say it doesn't know.

## Run

```bash
npm install
npm start
```

Needs `OPENAI_API_KEY`, `SUPABASE_URL`, `SUPABASE_API_KEY` in the repository-root `.env` (see `../.env.example`).

Needs the `documents` table filled by demo 05.

From the Scrimba AI Engineer Path: https://scrimba.com/the-ai-engineer-path-c02v/~01s
