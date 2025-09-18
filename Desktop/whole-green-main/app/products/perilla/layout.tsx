import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Perilla Microgreens - Aromatic & Unique | WholeGreen",
  description: "Premium Perilla microgreens with complex mint, basil, and anise flavors. Rich in Omega-3, iron, and calcium. Perfect for Korean, Japanese cuisine and gourmet applications.",
  keywords: "perilla microgreens, Asian herb microgreens, omega-3, Korean cuisine, Japanese cuisine, aromatic microgreens, unique flavor microgreens",
  openGraph: {
    title: "Perilla Microgreens - Aromatic & Unique",
    description: "Premium Perilla microgreens with complex mint, basil, and anise flavors. Essential for Korean and Japanese cuisine.",
    images: ["/images/products/perilla-hero.jpg"],
    type: "website",
    siteName: "WholeGreen",
  },
  twitter: {
    card: "summary_large_image",
    title: "Perilla Microgreens - Aromatic & Unique",
    description: "Premium Perilla microgreens with complex mint, basil, and anise flavors. Essential for Korean and Japanese cuisine.",
    images: ["/images/products/perilla-hero.jpg"],
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

export default function PerillaLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
