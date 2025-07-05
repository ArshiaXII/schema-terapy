import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Premium Microgreens Collection | WholeGreen",
  description: "Discover our premium microgreens collection: Daikon Radish, Amaranth, Red Radish, and Perilla. Fresh, nutritious, and perfect for professional kitchens and gourmet cooking.",
  keywords: "premium microgreens, fresh microgreens, gourmet microgreens, professional kitchen, nutritious microgreens, microgreens collection",
  openGraph: {
    title: "Premium Microgreens Collection",
    description: "Discover our carefully curated selection of premium microgreens, each variety chosen for exceptional flavor, nutritional value, and culinary versatility.",
    images: ["/images/products/collection-hero.jpg"],
    type: "website",
    siteName: "WholeGreen",
  },
  twitter: {
    card: "summary_large_image",
    title: "Premium Microgreens Collection",
    description: "Discover our carefully curated selection of premium microgreens, each variety chosen for exceptional flavor, nutritional value, and culinary versatility.",
    images: ["/images/products/collection-hero.jpg"],
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

export default function ProductsLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
