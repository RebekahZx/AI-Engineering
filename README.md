# AI Engineering snippets

Fourteen small JavaScript projects that call AI models from a web app. They cover:

- the OpenAI API: images, fine-tuning and embeddings;
- retrieval-augmented generation (RAG) with Supabase pgvector;
- Hugging Face inference;
- in-browser models with Transformers.js;
- a local LLM through Ollama.

They are my exercise solutions from the [Scrimba AI Engineer
Path](https://scrimba.com/the-ai-engineer-path-c02v). Each folder links to its lesson,
and the scaffolding (HTML, CSS, Vite setup) comes from the course.

## Projects

| Folder | What it shows | Keys |
|---|---|---|
| [`01-openai-image-generation`](01-openai-image-generation) | OpenAI image generation | OPENAI_API_KEY |
| [`02-openai-fine-tuning`](02-openai-fine-tuning) | OpenAI fine-tuning | OPENAI_API_KEY |
| [`03-langchain-text-chunking`](03-langchain-text-chunking) | Text chunking with LangChain | none |
| [`04-openai-embeddings`](04-openai-embeddings) | OpenAI embeddings | OPENAI_API_KEY |
| [`05-supabase-vector-store`](05-supabase-vector-store) | Store embeddings in Supabase (pgvector) | OPENAI_API_KEY, SUPABASE_URL, SUPABASE_API_KEY |
| [`06-chunk-embed-store`](06-chunk-embed-store) | Chunk, embed, store | OPENAI_API_KEY, SUPABASE_URL, SUPABASE_API_KEY |
| [`07-rag-podcast-answer`](07-rag-podcast-answer) | RAG: answer from retrieved context | OPENAI_API_KEY, SUPABASE_URL, SUPABASE_API_KEY |
| [`08-rag-movie-chatbot`](08-rag-movie-chatbot) | RAG movie chatbot | OPENAI_API_KEY, SUPABASE_URL, SUPABASE_API_KEY |
| [`09-hf-find-models`](09-hf-find-models) | Find Hugging Face models | HF_TOKEN |
| [`10-hf-translation`](10-hf-translation) | Translation with Hugging Face Inference | HF_TOKEN |
| [`11-hf-image-to-image`](11-hf-image-to-image) | Image-to-image with ControlNet | HF_TOKEN |
| [`12-hf-text-to-speech`](12-hf-text-to-speech) | Text to speech | HF_TOKEN |
| [`13-transformersjs-object-detection`](13-transformersjs-object-detection) | In-browser object detection | none |
| [`14-ollama-express-server`](14-ollama-express-server) | Local LLM behind Express | none |

Demos 04–08 form one pipeline:

1. **Chunk** text with LangChain.
2. **Embed** each chunk with `text-embedding-ada-002`.
3. **Store** the vectors in Supabase pgvector.
4. **Retrieve** the nearest chunks with a cosine-similarity SQL function.
5. **Answer** with GPT-4 using only that context.

## Running a demo

```bash
cp .env.example .env     # add the keys the demo needs
cd 08-rag-movie-chatbot
npm install
npm start                # Vite dev server
```

Every browser demo reads the shared root `.env` through its `vite.config.js`. Inside
Scrimba's sandbox the keys came from the platform instead.

**These demos call APIs directly from the browser.** Any key you set ends up in the
page, so only run them locally and never deploy them as they are. A real app would
make these calls from a server, as `14-ollama-express-server` does.

GitHub Actions installs and builds every browser demo on each push.
