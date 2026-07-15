import requests
import time
import os

# --- User settings ---
journals = ["PLoSGenetics", "PLoSBiology"]  # List of journals to search
search_term = "ancestry"
save_dir = "plos_articles_pdfs"
os.makedirs(save_dir, exist_ok=True)

# --- Loop over each journal ---
for journal in journals:
    print(f"\nSearching {journal} for articles about '{search_term}'...")
    
    # --- Step 1: Search PLOS for articles ---
    search_url = "http://api.plos.org/search"
    params = {
        "q": f"body:{search_term}",
        "fq": f"journal_key:{journal}",
        "fl": "id,title,publication_date",
        "wt": "json",
        "rows": 100000
    }

    response = requests.get(search_url, params=params)
    data = response.json()
    articles = data['response']['docs']

    print(f"Found {len(articles)} articles in {journal}.")

    # --- Step 2: Download PDFs ---
    for article in articles:
        doi = article['id']
        safe_doi = doi.replace("/", "_")
        pub_date = article.get("publication_date", "unknown-date")[:10]  # YYYY-MM-DD

        # PDF URL format
        pdf_url = f"http://journals.plos.org/{journal.lower()}/article/file?id={doi}&type=printable"

        try:
            pdf_response = requests.get(pdf_url)
            if pdf_response.status_code == 200:
                file_name = f"{journal}_{pub_date}_{safe_doi}.pdf"
                file_path = os.path.join(save_dir, file_name)

                with open(file_path, "wb") as f:
                    f.write(pdf_response.content)
                print(f"Downloaded: {file_name}")
            else:
                print(f"Failed to download: {safe_doi}.pdf (status {pdf_response.status_code})")
        except Exception as e:
            print(f"Error downloading {doi}: {e}")

        time.sleep(2)
