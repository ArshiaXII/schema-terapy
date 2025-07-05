import type React from "react"
import type { Metadata } from "next"
import "./globals.css"
import ParticleBackground from "@/components/ParticleBackground"
import PlexusBackground from "@/components/PlexusBackground"

export const metadata: Metadata = {
  title: "v0 App",
  description: "Created with v0",
  generator: "v0.dev",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <head>
        <script src="https://cdn.jsdelivr.net/npm/tsparticles@2.12.0/tsparticles.bundle.min.js"></script>
      </head>
      <body>
        <PlexusBackground />
        <ParticleBackground />
        {children}
      </body>
    </html>
  )
}
