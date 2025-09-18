# Schema Therapy RAG API

A FastAPI-based Retrieval-Augmented Generation (RAG) web service for analyzing Schema Therapy concepts using your private document collection.

## Features

- 🌐 **FastAPI Web Service**: RESTful API with automatic documentation
- 📄 **Document Processing**: Automatically extracts text from PDF and DOCX files
- 🧠 **AI-Powered Analysis**: Uses Google's Gemini 2.0 Flash model for Schema Therapy analysis
- 💾 **Persistent Vector Database**: ChromaDB for efficient document retrieval
- 🔍 **Smart Retrieval**: Finds the most relevant Schema Therapy concepts for analysis
- 🎯 **Personalized Reports**: Generates structured educational reports based on schema analysis
- 📊 **Health Monitoring**: Built-in health check endpoints

## Setup Instructions

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

Or install manually:
```bash
pip install google-generativeai langchain-google-genai langchain chromadb pypdf2 python-docx
```

### 2. Security Setup

1. **Get Google API Key:**
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a new API key
   - Copy the API key

2. **Configure Environment Variables:**
   - Create a copy of `.env.example` and rename it to `.env`
   - Open the `.env` file
   - Replace `"YOUR_API_KEY_HERE"` with your actual Google API key:
     ```
     GOOGLE_API_KEY="your_actual_api_key_here"
     ```

⚠️ **Important:** Never commit your `.env` file to version control. It contains sensitive information.

### 3. Prepare Your Documents

1. Create a folder named `kaynaklarim` in the same directory as `main.py`
2. Add your Schema Therapy documents (PDF and DOCX files) to this folder

### 4. Run the API Server

```bash
python main.py
```

The API will start on `http://localhost:8000`

- **API Documentation**: Visit `http://localhost:8000/docs` for interactive API documentation
- **Health Check**: Visit `http://localhost:8000/health` to check system status

## How It Works

1. **Document Loading**: The service scans the `kaynaklarim` folder for PDF and DOCX files
2. **Text Extraction**: Extracts and combines text from all documents
3. **Vector Database Creation**: Creates embeddings and stores them in ChromaDB (only on first startup)
4. **QA Chain Setup**: Initializes the Gemini model and retrieval system
5. **API Service**: Provides RESTful endpoints for Schema Therapy analysis

## Folder Structure

```
schema-therapy-rag-api/
├── main.py              # FastAPI application
├── requirements.txt     # Python dependencies
├── README.md           # This file
├── .env.example        # Environment variables template
├── kaynaklarim/        # Your Schema Therapy documents (create this)
│   ├── document1.pdf
│   ├── document2.docx
│   └── ...
└── chroma_db/          # Vector database (created automatically)
```

## API Usage

### Available Endpoints

1. **GET /** - API information and available endpoints
2. **GET /health** - Health check and system status
3. **POST /analyze-schemas/** - Analyze schemas and generate personalized reports

### Schema Analysis Endpoint

**POST /analyze-schemas/**

Request body:
```json
{
  "schemas": ["Defectiveness", "Abandonment", "Emotional Inhibition"]
}
```

Response:
```json
{
  "analysis": "## ▶️ Defectiveness: General Overview\n...",
  "schemas_analyzed": ["Defectiveness", "Abandonment", "Emotional Inhibition"]
}
```

### Example Usage with curl

```bash
curl -X POST "http://localhost:8000/analyze-schemas/" \
     -H "Content-Type: application/json" \
     -d '{"schemas": ["Defectiveness", "Abandonment"]}'
```

## Customization

### API Configuration

In the `main.py` file, you can modify:
- `host="0.0.0.0"` and `port=8000` - Server host and port
- `search_kwargs={"k": 5}` - Number of relevant chunks to retrieve
- `temperature=0.3` - Model creativity (0.0 = deterministic, 1.0 = creative)

### Text Chunking Parameters

In the `create_vector_database()` function:
- `chunk_size=1000` - Size of each text chunk
- `chunk_overlap=200` - Overlap between chunks

### CORS Configuration

For production, update the CORS settings in `main.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://yourdomain.com"],  # Specify allowed origins
    allow_credentials=True,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)
```

## Troubleshooting

### Common Issues

1. **API Key Error**: Make sure your `.env` file contains the correct Google API key
2. **No Documents Found**: Ensure the `kaynaklarim` folder exists and contains PDF/DOCX files
3. **Import Errors**: Run `pip install -r requirements.txt` to install all dependencies
4. **Port Already in Use**: Change the port in the uvicorn.run() call or kill the existing process

### Performance Tips

- The vector database is created only once and reused on subsequent startups
- Larger documents will take longer to process initially
- Consider using smaller chunk sizes for more precise retrieval
- Use a reverse proxy (nginx) for production deployments

## Security Note

- Keep your Google API key secure in the `.env` file
- Never commit your `.env` file to version control
- Configure CORS properly for production
- Consider adding authentication for production use
