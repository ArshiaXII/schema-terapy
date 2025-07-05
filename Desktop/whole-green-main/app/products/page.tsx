"use client"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { ArrowRight, Leaf, Star, Clock, Sparkles } from "lucide-react"
import Link from "next/link"
import Image from "next/image"

const products = [
  {
    id: "daikon-radish",
    name: "Daikon Radish",
    tagline: "Spicy & Crisp",
    scientificName: "Raphanus sativus var. longipinnatus",
    description: "Clean, spicy, and peppery flavor with bright white stems and vibrant green leaves. Perfect for adding a crisp kick to any dish.",
    image: "/images/products/daikon-radish-hero.jpg",
    cardImage: "/images/products/daikon-radish-card.jpg",
    price: "$19.99",
    unit: "per 4oz container",
    harvestTime: "7-14 days",
    rating: 4.8,
    features: ["Rich in Vitamin C", "Phosphorus", "Potassium"],
    color: "from-green-500 to-emerald-600",
    textColor: "text-green-600",
  },
  {
    id: "amaranth",
    name: "Amaranth",
    tagline: "Vibrant & Earthy",
    scientificName: "Amaranthus spp.",
    description: "Mild, slightly sweet, and earthy flavor with stunning vivid magenta color throughout leaves and stems.",
    image: "/images/products/amaranth-hero.jpg",
    cardImage: "/images/products/amaranth-card.jpg",
    price: "$22.99",
    unit: "per 4oz container",
    harvestTime: "10-14 days",
    rating: 4.7,
    features: ["Packed with Antioxidants", "Vitamin K", "Vitamin E"],
    color: "from-red-500 to-pink-600",
    textColor: "text-red-600",
  },
  {
    id: "red-radish",
    name: "Red Radish",
    tagline: "Bold & Peppery",
    scientificName: "Raphanus sativus",
    description: "Intense and robust peppery flavor with striking reddish-purple stems and green cotyledon leaves.",
    image: "/images/products/red-radish-hero.jpg",
    cardImage: "/images/products/red-radish-card.jpg",
    price: "$21.99",
    unit: "per 4oz container",
    harvestTime: "7-12 days",
    rating: 4.8,
    features: ["Vitamins A, B, C, E, K", "Spicy Flavor", "Natural Enzymes"],
    color: "from-red-600 to-rose-700",
    textColor: "text-red-700",
  },
  {
    id: "perilla",
    name: "Perilla",
    tagline: "Aromatic & Unique",
    scientificName: "Perilla frutescens",
    description: "Complex and unique flavor with notes of mint, basil, and anise. Broad, serrated leaves in green and purple varieties.",
    image: "/images/products/perilla-hero.jpg",
    cardImage: "/images/products/perilla-card.jpg",
    price: "$24.99",
    unit: "per 4oz container",
    harvestTime: "14-21 days",
    rating: 4.9,
    features: ["Omega-3 Fatty Acids", "Iron", "Calcium"],
    color: "from-purple-500 to-indigo-600",
    textColor: "text-purple-600",
  },
]

export default function ProductsPage() {
  return (
    <div className="min-h-screen bg-white">
      {/* Navigation */}
      <nav className="bg-white shadow-sm border-b sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10">
                <Image
                  src="/images/pyramid-logo.svg"
                  alt="WHOLEGREEN"
                  width={40}
                  height={40}
                  className="w-full h-full"
                />
              </div>
              <Image
                src="/images/wholegreen-logo.png"
                alt="WHOLEGREEN"
                width={120}
                height={24}
                className="h-6 w-auto"
              />
            </div>
            <div className="hidden md:block">
              <div className="ml-10 flex items-baseline space-x-4">
                <Link href="/" className="text-gray-500 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium transition-colors font-orbitron">
                  Home
                </Link>
                <Link
                  href="/products"
                  className="text-green-600 bg-green-50 px-3 py-2 rounded-md text-sm font-medium font-orbitron"
                >
                  Products
                </Link>
                <Link
                  href="/contact"
                  className="text-gray-500 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium transition-colors font-orbitron"
                >
                  Contact
                </Link>
              </div>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="relative bg-gradient-to-br from-green-50 via-emerald-50 to-teal-50 py-20">
        <div className="absolute inset-0 bg-[url('/images/microgreens-pattern.svg')] opacity-5"></div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="flex items-center justify-center mb-6">
            <Sparkles className="w-6 h-6 text-green-600 mr-2" />
            <Badge className="bg-green-100 text-green-800 hover:bg-green-200 text-sm px-4 py-2">
              Premium Microgreens Collection
            </Badge>
          </div>
          <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-6 leading-tight font-orbitron">
            Our Product
            <span className="text-green-600"> Catalog</span>
          </h1>
          <p className="text-xl text-gray-600 max-w-3xl mx-auto leading-relaxed">
            Discover our carefully curated selection of premium microgreens, each variety chosen for its exceptional
            flavor, nutritional value, and culinary versatility. From spicy radishes to aromatic herbs.
          </p>
        </div>
      </section>

      {/* Products Grid */}
      <section className="py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-8 lg:gap-12">
            {products.map((product, index) => (
              <Card 
                key={product.id} 
                className="group overflow-hidden hover:shadow-2xl transition-all duration-500 border-0 shadow-lg hover:-translate-y-2"
              >
                <div className="relative overflow-hidden">
                  <div className="aspect-[4/3] relative">
                    <Image
                      src={product.cardImage}
                      alt={product.name}
                      fill
                      className="object-cover group-hover:scale-110 transition-transform duration-700"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/20 to-transparent"></div>
                    
                    {/* Rating Badge */}
                    <div className="absolute top-4 left-4">
                      <Badge className="bg-white/90 text-gray-900 backdrop-blur-sm">
                        <Star className="w-3 h-3 mr-1 fill-yellow-400 text-yellow-400" />
                        {product.rating}
                      </Badge>
                    </div>
                    
                    {/* Product Name Overlay */}
                    <div className="absolute bottom-4 left-4 text-white">
                      <h3 className="text-2xl font-bold mb-1 font-orbitron">{product.name}</h3>
                      <p className="text-green-200 font-medium font-orbitron">{product.tagline}</p>
                    </div>
                  </div>
                </div>

                <CardContent className="p-8">
                  <div className="mb-4">
                    <p className="text-sm text-gray-500 italic mb-2">{product.scientificName}</p>
                    <p className="text-gray-700 leading-relaxed">{product.description}</p>
                  </div>

                  <div className="flex items-center gap-6 mb-6 text-sm text-gray-500">
                    <div className="flex items-center">
                      <Clock className="w-4 h-4 mr-2" />
                      {product.harvestTime}
                    </div>
                    <div className="flex items-center">
                      <Leaf className="w-4 h-4 mr-2" />
                      Organic
                    </div>
                  </div>

                  <div className="mb-6">
                    <h4 className="font-semibold text-gray-900 mb-3 font-orbitron">Key Nutrients:</h4>
                    <div className="flex flex-wrap gap-2">
                      {product.features.map((feature, featureIndex) => (
                        <Badge 
                          key={featureIndex} 
                          variant="secondary" 
                          className="text-xs bg-gray-100 text-gray-700 hover:bg-gray-200"
                        >
                          {feature}
                        </Badge>
                      ))}
                    </div>
                  </div>

                  <div className="flex items-center justify-between mb-6">
                    <div>
                      <div className="text-2xl font-bold text-gray-900">{product.price}</div>
                      <div className="text-sm text-gray-500">{product.unit}</div>
                    </div>
                  </div>

                  <Button
                    className={`w-full bg-gradient-to-r ${product.color} hover:shadow-lg text-white group-hover:shadow-xl transition-all duration-300 font-orbitron font-medium`}
                    size="lg"
                  >
                    <Link href={`/products/${product.id}`} className="flex items-center justify-center w-full">
                      Learn More
                      <ArrowRight className="ml-2 h-4 w-4 group-hover:translate-x-1 transition-transform" />
                    </Link>
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-gradient-to-r from-green-600 to-emerald-600">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-4xl md:text-5xl font-bold text-white mb-6 font-orbitron">Ready to Elevate Your Culinary Experience?</h2>
          <p className="text-xl text-green-100 mb-8 leading-relaxed">
            Contact us today to discuss custom orders, bulk pricing, or to learn more about our premium growing practices.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button size="lg" className="bg-white text-green-600 hover:bg-gray-100 hover:shadow-lg transition-all font-orbitron font-medium">
              <Link href="/contact" className="flex items-center">
                Get in Touch
                <ArrowRight className="ml-2 h-4 w-4" />
              </Link>
            </Button>
            <Button size="lg" variant="outline" className="border-white text-white hover:bg-white hover:text-green-600 transition-all font-orbitron font-medium">
              <Link href="/" className="flex items-center">
                Back to Home
              </Link>
            </Button>
          </div>
        </div>
      </section>
    </div>
  )
}
