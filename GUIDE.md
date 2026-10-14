# A hands-on guide to building with AI models in JavaScript

This guide walks you through the 14 demos in this repo in a sensible order. By the end
you will have:

- called hosted models;
- run models yourself, in the browser and on your own machine;
- built a working retrieval-augmented generation (RAG) chatbot;
- seen how fine-tuning works.

Each step says what to learn, where to look in the code, and something to try.

The demos are my solutions to exercises from the
[Scrimba AI Engineer Path](https://scrimba.com/the-ai-engineer-path-c02v). If you want
video explanations, take the course alongside this guide.

---

## Before you start

**You need**
- Node.js 20 or newer.
- Accounts for the parts you want to try:

  | Account | Needed for |
  |---|---|
  | [OpenAI](https://platform.openai.com) | Demos 01, 02, 04–08 |
  | [Hugging Face](https://huggingface.co/settings/tokens) (free token) | Demos 09–12 |
  | [Supabase](https://supabase.com) (free project) | Demos 05–08 |
  | [Ollama](https://ollama.com) | Demo 14 |

**Cost.** OpenAI calls are billed per use, and Hugging Face's free tier has rate limits.
Demos 03, 13 and 14 make no paid API calls.

**One-time setup**

```bash
git clone https://github.com/RebekahZx/AI-Engineering.git
cd AI-Engineering
cp .env.example .env        # fill in only the keys you have
```

**Running any demo**

```bash
cd <demo-folder>
npm install
npm start                   # opens a Vite dev server; most output goes to the browser console
```

> **Keys in the browser.** To keep the demos small, they call APIs straight from the
> page, so your key ends up in the page. That is fine on your own machine and never
> fine on a public site. Stage 2 shows the server-side pattern you would use for real.

---

## Stage 1: Call a hosted model

Start here. Each demo is one API call, so you see the shape of a request and a
response with nothing else in the way.

| Demo | You learn |
|---|---|
| [`01-openai-image-generation`](01-openai-image-generation) | The OpenAI SDK, a text prompt in and an image out. The image comes back as base64 (`response_format: 'b64_json'`) and is shown as a data URL. |
| [`10-hf-translation`](10-hf-translation) | Hugging Face's inference client. Picking a model for a task (`facebook/mbart-large-50-many-to-many-mmt`) and passing task parameters (`src_lang`, `tgt_lang`). |
| [`12-hf-text-to-speech`](12-hf-text-to-speech) | Models that return binary data. The audio comes back as a `Blob`, which `URL.createObjectURL` turns into something an `<audio>` tag can play. |
| [`11-hf-image-to-image`](11-hf-image-to-image) | Steering a model with an input image plus a prompt, a negative prompt and `strength` (how far it may move from the original). |
| [`09-hf-find-models`](09-hf-find-models) | Searching the Hugging Face Hub in code: filter by task, by likes and by whether a hosted endpoint is available, instead of browsing by hand. |

**Try this**
- In 01, change `size` and `model`, then read the API reference to see which
  combinations are allowed.
- In 10, change `tgt_lang` to another language code from the model card.
- In 11, run the same prompt at `strength` 0.3, 0.6 and 0.9 and compare the results.

---

## Stage 2: Run a model yourself

Hosted APIs aren't the only option.

| Demo | You learn |
|---|---|
| [`13-transformersjs-object-detection`](13-transformersjs-object-detection) | Running a model **inside the browser** with Transformers.js. `pipeline('object-detection', 'Xenova/yolos-tiny')` downloads the model once, then everything runs locally: no key, no per-call cost. |
| [`14-ollama-express-server`](14-ollama-express-server) | Running an LLM **on your own machine** with Ollama, behind a small Express server. This is also the shape a real app should take: the browser talks to your server, and only your server talks to the model. |

**Try this**
- In 13, lower `threshold` from `0.95` to `0.7` and watch more (and less reliable) boxes
  appear. This is the precision/recall trade-off you can see.
- In 14, change `model: 'mistral'` to another model you've pulled with `ollama pull`.

---

## Stage 3: Build a RAG chatbot (demos 03 → 08)

This is the core of the repo. An LLM only knows its training data. RAG lets it answer
questions about **your** documents:

```
                 ingest once                                   every question
 ┌──────────┐   ┌──────────┐   ┌───────────────┐      ┌────────────┐   ┌──────────────┐   ┌─────────┐
 │ text file│ → │  chunks  │ → │  embeddings   │  →   │ embed the  │ → │ find nearest │ → │ LLM     │
 │          │   │ (03, 06) │   │ in Supabase   │      │ question   │   │ chunks (SQL) │   │ answers │
 └──────────┘   └──────────┘   │ (04, 05, 06)  │      └────────────┘   └──────────────┘   │ from    │
                               └───────────────┘                                          │ context │
                                                                                          └─────────┘
```

Do the demos in order.

**03 · Chunking.** [`03-langchain-text-chunking`](03-langchain-text-chunking)

Long documents are split into pieces small enough to embed and to fit in a prompt.
`RecursiveCharacterTextSplitter` tries to split at paragraph and sentence boundaries
first. `chunkOverlap` repeats a little text between neighbouring chunks, so a fact that
falls on a boundary isn't lost.
*Try:* set `chunkSize` to 50 and then 500, and look at the chunks in the console. Too
small and chunks lose meaning; too large and retrieval gets vague.

**04 · Embeddings.** [`04-openai-embeddings`](04-openai-embeddings)

An embedding is a list of numbers (1,536 for `text-embedding-ada-002`). Texts with
similar *meaning* get similar lists, even when they share no words. That is what makes
search by meaning possible.
*Try:* log `embedding.length`, then embed two sentences that mean the same thing in
different words.

**05 · Store vectors.** [`05-supabase-vector-store`](05-supabase-vector-store)

Embeddings go into Postgres with the pgvector extension. First run
[`documents.sql`](05-supabase-vector-store/documents.sql) in the Supabase SQL editor. It
creates the table and `match_documents`, a function that ranks rows by **cosine
similarity**. The `<=>` operator returns cosine *distance*, so similarity is
`1 - distance`.

**06 · The full ingestion pipeline.** [`06-chunk-embed-store`](06-chunk-embed-store)

This one combines the three steps above: chunk `movies.txt`, embed every chunk and store
it. Run [`movies.sql`](06-chunk-embed-store/movies.sql) first.

**07 · Answer from retrieved context.** [`07-rag-podcast-answer`](07-rag-podcast-answer)

At question time:

1. Embed the question.
2. Call `match_documents` to fetch the closest chunk.
3. Send the chunk and the question to the model.

The **system prompt** does the important work. It tells the model to answer only from
the context and to say *"Sorry, I don't know the answer"* otherwise. That instruction is
your main defence against made-up answers.

**08 · Chatbot with memory.** [`08-rag-movie-chatbot`](08-rag-movie-chatbot)

Two upgrades on 07:

- It retrieves the top **4** chunks and joins them, instead of using only one.
- It pushes each reply back into `chatMessages`, so the model sees the conversation
  history. That is why a follow-up like "who directed it?" works.

*Try:* ask about a movie that isn't in `movies.txt` and check that it declines.

### Things that commonly go wrong in this stage

- **Duplicate rows.** Demos 05 and 06 insert every time the page loads, and the dev
  server reloads on every save. Run them once, then empty the table in Supabase if you
  see duplicates.
- **"Cannot read properties of undefined" in 07.** No chunk passed `match_threshold`
  (0.50), so `data[0]` doesn't exist. Lower the threshold, or check that the table
  actually has rows.
- **Dimension mismatch.** The table is `vector(1536)` to match `text-embedding-ada-002`.
  If you switch embedding models, the column size must match the new model's output
  length. Re-embed everything with the same model you use for questions.
- **Order matters.** 07 needs the table filled by 05, and 08 needs the table filled by 06.

---

## Stage 4: Customise a model with fine-tuning

[`02-openai-fine-tuning`](02-openai-fine-tuning) trains `gpt-3.5-turbo` on
[`motivationalBotData.jsonl`](02-openai-fine-tuning/motivationalBotData.jsonl): 52
example conversations in chat format, one JSON object per line, each with
`system`, `user` and `assistant` messages.

The code shows all three steps:

1. Upload the file.
2. Create the fine-tuning job.
3. Poll its status.

These steps are commented out. The live code queries the finished model.

**Fine-tuning or RAG?** Fine-tuning teaches a **style or behaviour**: here, an upbeat
coach voice. RAG gives the model **facts it didn't have**. If your problem is "it doesn't
know our data", use RAG first.

*Note:* the `ft:` model id in the code belongs to the course's OpenAI account. To try
it, uncomment the steps, run your own job, and paste in your own model id.

---

## Quick reference

| Term | Meaning |
|---|---|
| Embedding | A vector that represents the meaning of a text |
| Chunk | A piece of a larger document, sized for embedding and prompting |
| Cosine similarity | How closely two vectors point the same way (1 = identical direction) |
| Vector database | A store that can find the nearest vectors to a query; here Supabase with pgvector |
| RAG | Retrieve relevant chunks, then generate an answer grounded in them |
| System prompt | Standing instructions that shape every reply |
| Fine-tuning | Further training a model on your own examples to change its behaviour |
| Inference | Running a trained model to get an output |

## Where to go next

1. **Move API calls server-side.** Put demo 08's logic behind an Express route like
   demo 14, so keys never reach the browser.
2. **Cite sources.** Return the matched chunks along with the answer, so users can
   check where it came from.
3. **Measure retrieval.** Write 10–20 questions with known answers and check whether the
   right chunk comes back before you tune prompts.
4. **Revisit model choices.** The model names here are what the course used. Check the
   providers' current model lists before building something new.
