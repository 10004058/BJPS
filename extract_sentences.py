from pypdf import PdfReader
import re
import pandas as pd
import os
from pathlib import Path

# Define paths
pdf_folder = Path(r"plos_articles_pdfs") #update path
csv_path = Path(r"Corpus.csv")#update path


all_sentences = []

# Loop over all PDF files in the folder
for pdf_file in pdf_folder.glob("*.pdf"):
    print(f"Processing: {pdf_file.name}")
    try:
        reader = PdfReader(pdf_file)
        text = ""
        for page in reader.pages:
            page_text = page.extract_text()
            print(page_text)
            if page_text:
                text += page_text + "\n"

        # Fix hyphenation and line breaks
        text = re.sub(r'(\w+)-\s+(\w+)', r'\1\2', text)
        text = re.sub(r'\s+', ' ', text)

        # Split into sentences
        sentences = [s.strip() for s in re.split(r'(?<=[.!?])\s+', text) if s.strip()]

        # Add filename and sentence to list
        for s in sentences:
            all_sentences.append({"filename": pdf_file.name, "sentence": s})

    except Exception as e:
        print(f"Error processing {pdf_file.name}: {e}")

# Save all sentences to CSV
df = pd.DataFrame(all_sentences)
df.to_csv(csv_path, index=False, encoding="utf-8")

print(f"✅ Saved {len(df)} sentences from {len(list(pdf_folder.glob('*.pdf')))} PDFs to {csv_path}")

