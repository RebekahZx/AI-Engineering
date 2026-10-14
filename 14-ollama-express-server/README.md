# Local LLM behind Express

A small Express server that forwards `GET /?question=…` to a local Mistral model through the Ollama SDK.

## Run

Needs [Ollama](https://ollama.com) installed and `ollama pull mistral`. Run it with `npm install && npm start`, then open `http://localhost:3000/?question=hello`.

From the Scrimba AI Engineer Path: https://scrimba.com/the-ai-engineer-path-c02v/~07uj
