import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Red Radish Microgreens - Bold & Peppery | WholeGreen",
  description: "Intense Red Radish microgreens with robust peppery flavor. Rich in vitamins A, B, C, E, K. Perfect for egg dishes, tacos, and Mexican cuisine. Premium fresh microgreens.",
  keywords: "red radish microgreens, peppery microgreens, spicy microgreens, vitamins, Mexican cuisine, egg dishes, bold flavor microgreens",
  openGraph: {
    title: "Red Radish Microgreens - Bold & Peppery",
    description: "Intense Red Radish microgreens with robust peppery flavor and striking reddish-purple stems. Perfect for adding bold heat to any dish.",
    images: ["/images/products/red-radish-hero.jpg"],
    type: "website",
    siteName: "WholeGreen",
  },
  twitter: {
    card: "summary_large_image",
    title: "Red Radish Microgreens - Bold & Peppery",
    description: "Intense Red Radish microgreens with robust peppery flavor and striking reddish-purple stems. Perfect for adding bold heat to any dish.",
    images: ["/images/products/red-radish-hero.jpg"],
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

export default function RedRadishLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
