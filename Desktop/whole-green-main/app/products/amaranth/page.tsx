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
  id: "amaranth",
  name: "Amaranth",
  tagline: "Vibrant & Earthy",
  scientificName: "Amaranthus spp.",
  heroImage: "/images/products/amaranth-hero.jpg",
  galleryImages: [
    "/images/products/amaranth-1.jpg",
    "/images/products/amaranth-2.jpg",
    "/images/products/amaranth-3.jpg"
  ],
  price: "$22.99",
  unit: "per 4oz container",
  rating: 4.7,
  harvestTime: "10-14 days",
  tastingProfile: "A mild, slightly sweet, and earthy flavor with a hint of nuttiness. The tender leaves provide a delicate texture that complements both raw and cooked applications.",
  appearance: "Stunning, vivid magenta or red color throughout its leaves and stems. The broad, oval-shaped cotyledons create a dramatic visual impact with their intense coloration.",
  nutritionalHighlights: [
    "Packed with antioxidants - fights free radicals",
    "Rich in Vitamin K - supports bone health",
    "High in Vitamin E - promotes skin health",
    "Contains complete proteins - all essential amino acids"
  ],
  culinaryUses: [
    "Adds spectacular color to salads",
    "Beautiful garnish for soups and entrees",
    "Enhances dessert presentations",
    "Perfect for smoothie bowls",
    "Stunning addition to cheese boards",
    "Colorful topping for grain bowls"
  ]
}

export default function AmaranthPage() {
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
                <Link href="/" className="text-gray-500 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium transition-colors">
                  Home
                </Link>
                <Link
                  href="/products"
                  className="text-green-600 bg-green-50 px-3 py-2 rounded-md text-sm font-medium"
                >
                  Products
                </Link>
                <Link
                  href="/contact"
                  className="text-gray-500 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium transition-colors"
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
              className="inline-flex items-center text-red-200 hover:text-white mb-6 transition-colors"
            >
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Products
            </Link>
            
            <div className="mb-6">
              <Badge className="mb-4 bg-red-600 text-white border-red-500">
                <Sparkles className="w-3 h-3 mr-1" />
                {productData.tagline}
              </Badge>
            </div>
            
            <h1 className="text-5xl md:text-7xl font-bold mb-4 leading-tight">
              {productData.name}
              <span className="block text-3xl md:text-4xl font-normal text-red-200 mt-2 italic">
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
            <div className="text-xl text-red-200 mb-8">{productData.unit}</div>
            
            <Button size="lg" className="bg-red-600 hover:bg-red-700 text-white px-8 py-4 text-lg">
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
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-6">
            Ancient Superfood with <span className="text-red-600">Stunning Beauty</span>
          </h2>
          <p className="text-xl text-gray-600 leading-relaxed">
            Our Amaranth microgreens bring the nutritional power of this ancient superfood in a visually spectacular form. 
            With their vibrant magenta coloration and mild, nutty flavor, these microgreens transform any dish into a 
            work of art while delivering exceptional nutritional benefits.
          </p>
        </div>
      </section>

      {/* Detailed Information Section */}
      <section className="py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16">
            {/* Left Column - Gallery */}
            <div>
              <h3 className="text-2xl font-bold text-gray-900 mb-8">Product Gallery</h3>
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
                    <ChefHat className="w-6 h-6 text-red-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900">Tasting Profile</h3>
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
                    <Sparkles className="w-6 h-6 text-red-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900">Appearance</h3>
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
                    <CheckCircle className="w-6 h-6 text-red-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900">Nutritional Highlights</h3>
                  </div>
                  <ul className="space-y-3">
                    {productData.nutritionalHighlights.map((highlight, index) => (
                      <li key={index} className="flex items-start">
                        <CheckCircle className="w-5 h-5 text-red-500 mr-3 mt-0.5 flex-shrink-0" />
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
                    <Utensils className="w-6 h-6 text-red-600 mr-3" />
                    <h3 className="text-2xl font-bold text-gray-900">Culinary Uses</h3>
                  </div>
                  <ul className="space-y-3">
                    {productData.culinaryUses.map((use, index) => (
                      <li key={index} className="flex items-start">
                        <CheckCircle className="w-5 h-5 text-red-500 mr-3 mt-0.5 flex-shrink-0" />
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
      <section className="py-20 bg-gradient-to-r from-red-600 to-pink-600">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-4xl md:text-5xl font-bold text-white mb-6">Ready to Experience Amaranth?</h2>
          <p className="text-xl text-red-100 mb-8 leading-relaxed">
            Contact us today to place your order or discuss custom growing requirements for your restaurant or business.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button size="lg" className="bg-white text-red-600 hover:bg-gray-100 hover:shadow-lg transition-all">
              <Link href="/contact" className="flex items-center">
                Place Order
                <ArrowLeft className="ml-2 h-4 w-4 rotate-180" />
              </Link>
            </Button>
            <Button size="lg" variant="outline" className="border-white text-white hover:bg-white hover:text-red-600 transition-all">
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
