import type { Metadata } from "next"

export const productMetadata = {
  "daikon-radish": {
    title: "Daikon Radish Microgreens - Spicy & Crisp | WholeGreen",
    description: "Premium Daikon Radish microgreens with clean, spicy flavor. Rich in Vitamin C, phosphorus, and potassium. Perfect for sushi, salads, and Asian cuisine. Order fresh microgreens today.",
    keywords: "daikon radish microgreens, spicy microgreens, vitamin C, sushi garnish, Asian microgreens, fresh microgreens, premium microgreens",
    openGraph: {
      title: "Daikon Radish Microgreens - Spicy & Crisp",
      description: "Premium Daikon Radish microgreens with clean, spicy flavor and crisp texture. Perfect for sushi, salads, and adding a kick to any dish.",
      images: ["/images/products/daikon-radish-hero.jpg"],
    },
  },
  "amaranth": {
    title: "Amaranth Microgreens - Vibrant & Earthy | WholeGreen",
    description: "Stunning Amaranth microgreens with vivid magenta color and mild, earthy flavor. Packed with antioxidants, Vitamin K, and complete proteins. Premium quality guaranteed.",
    keywords: "amaranth microgreens, colorful microgreens, antioxidants, vitamin K, complete protein, ancient superfood, vibrant microgreens",
    openGraph: {
      title: "Amaranth Microgreens - Vibrant & Earthy",
      description: "Stunning Amaranth microgreens with vivid magenta color and mild, earthy flavor. Ancient superfood packed with nutrients.",
      images: ["/images/products/amaranth-hero.jpg"],
    },
  },
  "red-radish": {
    title: "Red Radish Microgreens - Bold & Peppery | WholeGreen",
    description: "Intense Red Radish microgreens with robust peppery flavor. Rich in vitamins A, B, C, E, K. Perfect for egg dishes, tacos, and Mexican cuisine. Premium fresh microgreens.",
    keywords: "red radish microgreens, peppery microgreens, spicy microgreens, vitamins, Mexican cuisine, egg dishes, bold flavor microgreens",
    openGraph: {
      title: "Red Radish Microgreens - Bold & Peppery",
      description: "Intense Red Radish microgreens with robust peppery flavor and striking reddish-purple stems. Perfect for adding bold heat to any dish.",
      images: ["/images/products/red-radish-hero.jpg"],
    },
  },
  "perilla": {
    title: "Perilla Microgreens - Aromatic & Unique | WholeGreen",
    description: "Premium Perilla microgreens with complex mint, basil, and anise flavors. Rich in Omega-3, iron, and calcium. Perfect for Korean, Japanese cuisine and gourmet applications.",
    keywords: "perilla microgreens, Asian herb microgreens, omega-3, Korean cuisine, Japanese cuisine, aromatic microgreens, unique flavor microgreens",
    openGraph: {
      title: "Perilla Microgreens - Aromatic & Unique",
      description: "Premium Perilla microgreens with complex mint, basil, and anise flavors. Essential for Korean and Japanese cuisine.",
      images: ["/images/products/perilla-hero.jpg"],
    },
  },
  "products": {
    title: "Premium Microgreens Collection | WholeGreen",
    description: "Discover our premium microgreens collection: Daikon Radish, Amaranth, Red Radish, and Perilla. Fresh, nutritious, and perfect for professional kitchens and gourmet cooking.",
    keywords: "premium microgreens, fresh microgreens, gourmet microgreens, professional kitchen, nutritious microgreens, microgreens collection",
    openGraph: {
      title: "Premium Microgreens Collection",
      description: "Discover our carefully curated selection of premium microgreens, each variety chosen for exceptional flavor, nutritional value, and culinary versatility.",
      images: ["/images/products/collection-hero.jpg"],
    },
  },
}

export function getProductMetadata(productId: string): Metadata {
  const product = productMetadata[productId as keyof typeof productMetadata]
  
  if (!product) {
    return {
      title: "Product Not Found | WholeGreen",
      description: "The requested product could not be found.",
    }
  }

  return {
    title: product.title,
    description: product.description,
    keywords: product.keywords,
    openGraph: {
      title: product.openGraph.title,
      description: product.openGraph.description,
      images: product.openGraph.images,
      type: "website",
      siteName: "WholeGreen",
    },
    twitter: {
      card: "summary_large_image",
      title: product.openGraph.title,
      description: product.openGraph.description,
      images: product.openGraph.images,
    },
    robots: {
      index: true,
      follow: true,
      googleBot: {
        index: true,
        follow: true,
        "max-video-preview": -1,
        "max-image-preview": "large",
        "max-snippet": -1,
      },
    },
  }
}
