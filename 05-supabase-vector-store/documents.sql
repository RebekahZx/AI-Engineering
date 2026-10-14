-- Run in the Supabase SQL editor.
create extension if not exists vector;

create table if not exists documents (
  id bigserial primary key,
  content text,           -- the text chunk
  embedding vector(1536)  -- text-embedding-ada-002 has 1536 dimensions
);

-- Cosine-similarity search used by the RAG demos via supabase.rpc('match_documents', ...)
create or replace function match_documents (
  query_embedding vector(1536),
  match_threshold float,
  match_count int
)
returns table (id bigint, content text, similarity float)
language sql stable
as $$
  select documents.id, documents.content, 1 - (documents.embedding <=> query_embedding) as similarity
  from documents
  where 1 - (documents.embedding <=> query_embedding) > match_threshold
  order by documents.embedding <=> query_embedding
  limit match_count;
$$;
