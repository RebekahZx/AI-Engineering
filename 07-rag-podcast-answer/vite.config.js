import { defineConfig, loadEnv } from "vite"

// These demos call AI APIs straight from the browser, so the keys below are
// embedded in the page. Fine for local learning; never deploy them.
// Keys are read from the shared .env file in the repository root.
const KEYS = ["OPENAI_API_KEY", "HF_TOKEN", "SUPABASE_URL", "SUPABASE_API_KEY"]

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, "..", "")
  return {
    envDir: "..",
    define: Object.fromEntries(
      KEYS.map((key) => [`process.env.${key}`, JSON.stringify(env[key] ?? "")])
    ),
    // Several demos use top-level await.
    build: { target: "esnext" },
  }
})
