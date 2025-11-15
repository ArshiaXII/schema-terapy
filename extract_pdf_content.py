#!/usr/bin/env python3
"""Extract text content from PDF files in kaynaklarim folder"""

import os
import sys

try:
    import PyPDF2
except ImportError:
    print("PyPDF2 not installed. Installing...")
    os.system("pip install PyPDF2")
    import PyPDF2

def extract_pdf_text(pdf_path, max_pages=50):
    """Extract text from PDF file"""
    try:
        text_content = []
        with open(pdf_path, 'rb') as file:
            pdf_reader = PyPDF2.PdfReader(file)
            num_pages = min(len(pdf_reader.pages), max_pages)
            
            for page_num in range(num_pages):
                page = pdf_reader.pages[page_num]
                text = page.extract_text()
                if text:
                    text_content.append(f"--- Page {page_num + 1} ---\n{text}")
        
        return "\n\n".join(text_content)
    except Exception as e:
        return f"Error reading {pdf_path}: {str(e)}"

def main():
    kaynak_dir = "kaynaklarim"
    
    if not os.path.exists(kaynak_dir):
        print(f"Directory {kaynak_dir} not found!")
        return
    
    pdf_files = [f for f in os.listdir(kaynak_dir) if f.endswith('.pdf')]
    
    print(f"Found {len(pdf_files)} PDF files:\n")
    
    for pdf_file in pdf_files:
        pdf_path = os.path.join(kaynak_dir, pdf_file)
        print(f"\n{'='*80}")
        print(f"Extracting: {pdf_file}")
        print(f"{'='*80}\n")
        
        content = extract_pdf_text(pdf_path, max_pages=20)
        
        # Save to text file
        output_file = f"extracted_{pdf_file.replace('.pdf', '.txt')}"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"Saved to: {output_file}")
        print(f"Content preview (first 1000 chars):\n{content[:1000]}...\n")

if __name__ == "__main__":
    main()

