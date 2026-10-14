# OpenAI fine-tuning

Fine-tuning workflow for `gpt-3.5-turbo` on `motivationalBotData.jsonl` (chat-format JSONL). The upload, create-job and check-status steps are kept as commented code; the live code queries the fine-tuned model.

## Run

```bash
npm install
npm start
```

Needs `OPENAI_API_KEY` in the repository-root `.env` (see `../.env.example`).

The model id in `index.js` belongs to the course's OpenAI organisation. To run it yourself, uncomment the steps, run your own job, and use your own `ft:` model id.
