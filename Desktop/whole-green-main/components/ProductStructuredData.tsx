interface ProductStructuredDataProps {
  product: {
    id: string
    name: string
    scientificName: string
    description: string
    price: string
    rating: number
    image: string
    nutritionalHighlights: string[]
    culinaryUses: string[]
  }
}

export default function ProductStructuredData({ product }: ProductStructuredDataProps) {
  const structuredData = {
    "@context": "https://schema.org",
    "@type": "Product",
    "name": `${product.name} Microgreens`,
    "description": product.description,
    "brand": {
      "@type": "Brand",
      "name": "WholeGreen"
    },
    "category": "Fresh Produce",
    "image": product.image,
    "offers": {
      "@type": "Offer",
      "price": product.price.replace('$', ''),
      "priceCurrency": "USD",
      "availability": "https://schema.org/InStock",
      "seller": {
        "@type": "Organization",
        "name": "WholeGreen"
      }
    },
    "aggregateRating": {
      "@type": "AggregateRating",
      "ratingValue": product.rating,
      "bestRating": 5,
      "worstRating": 1,
      "ratingCount": 50
    },
    "nutrition": {
      "@type": "NutritionInformation",
      "calories": "25 per 100g",
      "description": product.nutritionalHighlights.join(", ")
    },
    "additionalProperty": [
      {
        "@type": "PropertyValue",
        "name": "Scientific Name",
        "value": product.scientificName
      },
      {
        "@type": "PropertyValue",
        "name": "Product Type",
        "value": "Microgreens"
      },
      {
        "@type": "PropertyValue",
        "name": "Growing Method",
        "value": "Organic"
      }
    ]
  }

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(structuredData) }}
    />
  )
}
