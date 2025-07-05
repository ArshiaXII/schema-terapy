"use client"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Separator } from "@/components/ui/separator"
import { ArrowLeft, Star, Clock, CheckCircle, Sparkles, ChefHat, Utensils } from "lucide-react"
import Link from "next/link"
import Image from "next/image"

// Product data
const productData = {
  id: "daikon-radish",
  name: "Daikon Radish",
  tagline: "Spicy & Crisp",
  scientificName: "Raphanus sativus var. longipinnatus",
  heroImage: "/images/products/daikon-radish-hero.jpg",
  galleryImages: [
    "/images/products/daikon-radish-1.jpg",
    "/images/products/daikon-radish-2.jpg",
    "/images/products/daikon-radish-3.jpg"
  ],
  price: "$19.99",
  unit: "per 4oz container",
  rating: 4.8,
  harvestTime: "7-14 days",
  tastingProfile: "A clean, spicy, and peppery flavor, similar to a mature radish but more delicate. The crisp texture provides a satisfying crunch that enhances any dish.",
  appearance: "Bright white stems with vibrant green leaves. The cotyledons are round and smooth, creating an elegant contrast with the crisp white stems.",
  nutritionalHighlights: [
    "Rich in Vitamin C - supports immune system",
    "High in Phosphorus - essential for bone health", 
    "Good source of Potassium - supports heart function",
    "Contains natural enzymes for digestion"
  ],
  culinaryUses: [
    "Garnish for sushi and sashimi",
    "Adds a kick to sandwiches and wraps",
    "Perfect topping for tacos and bowls",
    "Enhances salads with spicy crunch",
    "Beautiful garnish for soups",
    "Adds texture to grain bowls"
  ]
}

export default function DaikonRadishPage() {
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
      <section className="relative min-h-[70vh] flex items-center justify-center overflow-hidden">
        <div className="absolute inset-0">
          <Image
            src={productData.heroImage}
            alt={`${productData.name} Hero`}
            fill
            className="object-cover"
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-r from-black/70 via-black/50 to-black/30"></div>
        </div>
        
        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center text-white">
            <Link 
              href="/products" 
              className="inline-flex items-center text-green-200 hover:text-white mb-6 transition-colors"
            >
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Products
            </Link>
            
            <div className="mb-6">
              <Badge className="mb-4 bg-green-600 text-white border-green-500">
                <Sparkles className="w-3 h-3 mr-1" />
                {productData.tagline}
              </Badge>
            </div>
            
            <h1 className="text-5xl md:text-7xl font-bold mb-4 leading-tight font-orbitron">
              {productData.name}
              <span className="block text-3xl md:text-4xl font-normal text-green-200 mt-2 italic">
                {productData.scientificName}
              </span>
            </h1>
            
            <div className="flex items-center justify-center gap-6 mb-8 text-lg">
              <div className="flex items-center">
                <Star className="w-5 h-5 mr-2 fill-yellow-400 text-yellow-400" />
                <span className="font-semibold">{productData.rating}/5</span>
              </div>
              <div className="flex items-center">
                <Clock className="w-5 h-5 mr-2" />
                {productData.harvestTime}
              </div>
            </div>
            
            <div className="text-4xl font-bold mb-2">{productData.price}</div>
            <div className="text-xl text-green-200 mb-8">{productData.unit}</div>
            
            <Button size="lg" className="bg-green-600 hover:bg-green-700 text-white px-8 py-4 text-lg font-orbitron font-medium">
              <Link href="/contact" className="flex items-center">
                Order Now
                <ArrowLeft className="ml-2 h-5 w-5 rotate-180" />
              </Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Introduction */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-6 font-orbitron">
            The Perfect Balance of <span className="text-green-600">Spice & Freshness</span>
          </h2>
          <p className="text-xl text-gray-600 leading-relaxed">
            Our Daikon Radish microgreens deliver an exceptional culinary experience with their clean, peppery bite and crisp texture. 
            These premium microgreens bring the essence of traditional Japanese daikon radish in a concentrated, nutrient-dense form 
            that elevates any dish with both flavor and visual appeal.
          </p>
        </div>
      </section>

      {/* Detailed Information Section */}
      <section className="py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16">
            {/* Left Column - Gallery */}
            <div>
              <h3 className="text-2xl font-bold text-gray-900 mb-8 font-orbitron">Product Gallery</h3>
              <div className="space-y-6">
                {productData.galleryImages.map((image, index) => (
                  <div key={index} className="relative aspect-[4/3] rounded-lg overflow-hidden shadow-lg">
                    <Image
                      src={image}
                      alt={`${productData.name} ${index + 1}`}
                      fill
                      className="object-cover hover:scale-105 transition-transform duration-300"
                    />
                  </div>
                ))}
              </div>
            </div>

            {/* Right Column - Detailed Content */}
            <div className="space-y-12">
              {/* Tasting Profile */}
              <Card className="border-0 shadow-lg">
                <CardContent className="p-8">
                  <div className="flex items-center mb-4">
                    <ChefHat className="w-6 h-6 text-green-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900 font-orbitron">Tasting Profile</h3>
                  </div>
                  <p className="text-gray-700 leading-relaxed text-lg">
                    {productData.tastingProfile}
                  </p>
                </CardContent>
              </Card>

              {/* Appearance */}
              <Card className="border-0 shadow-lg">
                <CardContent className="p-8">
                  <div className="flex items-center mb-4">
                    <Sparkles className="w-6 h-6 text-green-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900 font-orbitron">Appearance</h3>
                  </div>
                  <p className="text-gray-700 leading-relaxed text-lg">
                    {productData.appearance}
                  </p>
                </CardContent>
              </Card>

              {/* Nutritional Highlights */}
              <Card className="border-0 shadow-lg">
                <CardContent className="p-8">
                  <div className="flex items-center mb-6">
                    <CheckCircle className="w-6 h-6 text-green-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900 font-orbitron">Nutritional Highlights</h3>
                  </div>
                  <ul className="space-y-3">
                    {productData.nutritionalHighlights.map((highlight, index) => (
                      <li key={index} className="flex items-start">
                        <CheckCircle className="w-5 h-5 text-green-500 mr-3 mt-0.5 flex-shrink-0" />
                        <span className="text-gray-700 text-lg">{highlight}</span>
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>

              {/* Culinary Uses */}
              <Card className="border-0 shadow-lg">
                <CardContent className="p-8">
                  <div className="flex items-center mb-6">
                    <Utensils className="w-6 h-6 text-green-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900 font-orbitron">Culinary Uses</h3>
                  </div>
                  <ul className="space-y-3">
                    {productData.culinaryUses.map((use, index) => (
                      <li key={index} className="flex items-start">
                        <CheckCircle className="w-5 h-5 text-green-500 mr-3 mt-0.5 flex-shrink-0" />
                        <span className="text-gray-700 text-lg">{use}</span>
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-gradient-to-r from-green-600 to-emerald-600">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-4xl md:text-5xl font-bold text-white mb-6 font-orbitron">Ready to Experience Daikon Radish?</h2>
          <p className="text-xl text-green-100 mb-8 leading-relaxed">
            Contact us today to place your order or discuss custom growing requirements for your restaurant or business.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button size="lg" className="bg-white text-green-600 hover:bg-gray-100 hover:shadow-lg transition-all font-orbitron font-medium">
              <Link href="/contact" className="flex items-center">
                Place Order
                <ArrowLeft className="ml-2 h-4 w-4 rotate-180" />
              </Link>
            </Button>
            <Button size="lg" variant="outline" className="border-white text-white hover:bg-white hover:text-green-600 transition-all font-orbitron font-medium">
              <Link href="/products" className="flex items-center">
                View Other Products
              </Link>
            </Button>
          </div>
        </div>
      </section>
    </div>
  )
}
