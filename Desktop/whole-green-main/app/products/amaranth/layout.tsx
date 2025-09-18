import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Amaranth Microgreens - Vibrant & Earthy | WholeGreen",
  description: "Stunning Amaranth microgreens with vivid magenta color and mild, earthy flavor. Packed with antioxidants, Vitamin K, and complete proteins. Premium quality guaranteed.",
  keywords: "amaranth microgreens, colorful microgreens, antioxidants, vitamin K, complete protein, ancient superfood, vibrant microgreens",
  openGraph: {
    title: "Amaranth Microgreens - Vibrant & Earthy",
    description: "Stunning Amaranth microgreens with vivid magenta color and mild, earthy flavor. Ancient superfood packed with nutrients.",
    images: ["/images/products/amaranth-hero.jpg"],
    type: "website",
    siteName: "WholeGreen",
  },
  twitter: {
    card: "summary_large_image",
    title: "Amaranth Microgreens - Vibrant & Earthy",
    description: "Stunning Amaranth microgreens with vivid magenta color and mild, earthy flavor. Ancient superfood packed with nutrients.",
    images: ["/images/products/amaranth-hero.jpg"],
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

export default function AmaranthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
