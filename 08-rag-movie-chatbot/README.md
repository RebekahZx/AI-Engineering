# RAG movie chatbot

A chat UI over the movie data from demo 06. It retrieves the top 4 chunks with `match_movies`, keeps the conversation history so follow-up questions work, and answers with GPT-4.

## Run

```bash
npm install
npm start
```

Needs `OPENAI_API_KEY`, `SUPABASE_URL`, `SUPABASE_API_KEY` in the repository-root `.env` (see `../.env.example`).

Needs the `movies` table filled by demo 06.

From the Scrimba AI Engineer Path: https://scrimba.com/the-ai-engineer-path-c02v/~021
