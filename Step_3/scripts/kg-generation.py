import logging
from langchain_openai import ChatOpenAI
from langchain_experimental.graph_transformers import LLMGraphTransformer
from langchain_core.documents import Document

# --- logging ---
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)

# --- LLM used by the graph transformer ---
llm = ChatOpenAI(
    model="mistral:7b-instruct",
    base_url="", #replace URL
    api_key="ollama",
    temperature=0.0,
    max_tokens=1024,
).bind(extra_body={"options": {"num_predict": 512, "num_ctx": 4096}})

# --- Graph transformer ---
llm_transformer = LLMGraphTransformer(llm=llm)

def text_to_graph_documents(text: str):
    """Convert raw text to graph documents (nodes + relationships) with logging."""
    logger.info("Converting text to graph documents (len=%d)...", len(text))
    try:
        docs = llm_transformer.convert_to_graph_documents([Document(page_content=text)])
        if not docs:
            logger.warning("No documents returned by LLMGraphTransformer.")
            return []
        g = docs[0]
        logger.info("Conversion complete: %d nodes, %d relationships.",
                    len(getattr(g, "nodes", [])),
                    len(getattr(g, "relationships", [])))
        return docs
    except Exception as e:
        logger.exception("Graph conversion failed: %s", e)
        return []

if __name__ == "__main__":
    sentences = [
    #Insert sentences to convert into KG here, e.g.:
    "XP53BE was a 40-year-old male of Indian ancestry (Fig 1).",
    "define a hypothetical ancestral haplotype (namely the cluster centre) from which the members of the cluster are thought to have descended and they measure the similarity of the centre with each observed haplotype around a putative causal locus.",
    "We began our analysis by modeling Polynesian ancestry.",
    "Much of this was based on genetic ancestry calculated from dense genotype data.",
    ]

    all_graph_docs = []

    for s in sentences:
        logger.info("Processing sentence: %s", s)
        docs = text_to_graph_documents(s)
        all_graph_docs.extend(docs)

    # --- Printing summary of all collected graph docs ---
    for idx, g in enumerate(all_graph_docs):
        logger.info("=== Graph %d ===", idx + 1)
        logger.info("Nodes:")
        for n in getattr(g, "nodes", []):
            logger.info(" - %s", n)
        logger.info("Relationships:")
        for r in getattr(g, "relationships", []):
            logger.info(" - %s --[%s]--> %s", r.source.id, r.type, r.target.id)
