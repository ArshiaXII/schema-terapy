import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Daikon Radish Microgreens - Spicy & Crisp | WholeGreen",
  description: "Premium Daikon Radish microgreens with clean, spicy flavor. Rich in Vitamin C, phosphorus, and potassium. Perfect for sushi, salads, and Asian cuisine. Order fresh microgreens today.",
  keywords: "daikon radish microgreens, spicy microgreens, vitamin C, sushi garnish, Asian microgreens, fresh microgreens, premium microgreens",
  openGraph: {
    title: "Daikon Radish Microgreens - Spicy & Crisp",
    description: "Premium Daikon Radish microgreens with clean, spicy flavor and crisp texture. Perfect for sushi, salads, and adding a kick to any dish.",
    images: ["/images/products/daikon-radish-hero.jpg"],
    type: "website",
    siteName: "WholeGreen",
  },
  twitter: {
    card: "summary_large_image",
    title: "Daikon Radish Microgreens - Spicy & Crisp",
    description: "Premium Daikon Radish microgreens with clean, spicy flavor and crisp texture. Perfect for sushi, salads, and adding a kick to any dish.",
    images: ["/images/products/daikon-radish-hero.jpg"],
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

export default function DaikonRadishLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
