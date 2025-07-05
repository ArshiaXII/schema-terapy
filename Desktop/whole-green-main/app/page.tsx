"use client"

import { useState } from "react"
import { Card, CardContent } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Separator } from "@/components/ui/separator"
import { Leaf, Microscope, Sprout, Rocket, Users, TrendingUp, ChefHat, Beaker, Globe, Star } from "lucide-react"
import Link from "next/link"
import Image from "next/image"
import LoadingScreen from "@/components/loading-screen"

export default function HomePage() {
  const [isLoading, setIsLoading] = useState(true)

  const handleLoadingComplete = () => {
    setIsLoading(false)
  }

  if (isLoading) {
    return <LoadingScreen onComplete={handleLoadingComplete} />
  }

  return (
    <div className="min-h-screen animate-[fadeIn_1s_ease-out]">
      {/* Navigation */}
      <nav className="fixed top-0 w-full bg-black/90 backdrop-blur-sm z-50 border-b border-gray-800">
        <div className="container mx-auto px-4">
          <div className="flex items-center justify-between h-16">
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

            <div className="hidden md:flex items-center space-x-8">
              <Link href="/" className="text-green-400 hover:text-green-300 transition-colors font-orbitron font-medium">
                HOME
              </Link>
              <Link href="/products" className="text-white hover:text-green-400 transition-colors font-orbitron font-medium">
                PRODUCTS
              </Link>
              <Link href="#about" className="text-white hover:text-green-400 transition-colors font-orbitron font-medium">
                ABOUT US
              </Link>
              <Link href="#services" className="text-white hover:text-green-400 transition-colors font-orbitron font-medium">
                SERVICES
              </Link>
              <Link href="#team" className="text-white hover:text-green-400 transition-colors font-orbitron font-medium">
                TEAM
              </Link>
              <Link href="/contact" className="text-white hover:text-green-400 transition-colors font-orbitron font-medium">
                CONTACTS
              </Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="hero-section relative min-h-screen flex items-center justify-center overflow-hidden">


        <div className="relative z-10 text-center text-white px-4 max-w-4xl mx-auto">
          {/* Animated Logo */}
          <div className="mb-8 relative">
            <div className="w-32 h-32 mx-auto mb-6 animate-[logoEntrance_2s_cubic-bezier(0.68,-0.55,0.265,1.55)]">
              <Image
                src="/images/pyramid-logo.svg"
                alt="WHOLEGREEN Logo"
                width={128}
                height={128}
                className="w-full h-full drop-shadow-2xl animate-[logoGlow_3s_ease-in-out_infinite_alternate]"
              />
            </div>

            {/* Animated Rings */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div className="w-40 h-40 border-2 border-white/20 rounded-full animate-[ring1_4s_ease-out_infinite]"></div>
              <div className="absolute w-52 h-52 border-2 border-white/10 rounded-full animate-[ring2_4s_ease-out_infinite_0.5s]"></div>
              <div className="absolute w-64 h-64 border-2 border-white/5 rounded-full animate-[ring3_4s_ease-out_infinite_1s]"></div>
            </div>

            {/* Floating Particles */}
            <div className="absolute inset-0 pointer-events-none">
              {[...Array(12)].map((_, i) => (
                <div
                  key={i}
                  className="absolute w-1 h-1 bg-white/30 rounded-full animate-[particle_8s_ease-in-out_infinite]"
                  style={{
                    left: `${20 + i * 8}%`,
                    top: `${30 + (i % 4) * 15}%`,
                    animationDelay: `${i * 0.4}s`,
                  }}
                ></div>
              ))}
            </div>
          </div>

          <div className="mb-6 animate-[slideUp_1.5s_ease-out_1s_both]">
            <Image src="/images/wholegreen-logo.png" alt="WHOLEGREEN" width={400} height={80} className="mx-auto" />
          </div>
          <p className="text-xl md:text-2xl text-gray-200 animate-[slideUp_1.5s_ease-out_1.5s_both]">
            Premium Microgreen Technologies
          </p>
          <p className="text-lg text-gray-300 mt-2 animate-[slideUp_1.5s_ease-out_2s_both]">
            Profesyonel mutfaklar için
          </p>
        </div>
      </section>

      {/* Welcome Section */}
      <section className="py-20 bg-white">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="relative">
              <Image
                src="/images/welcome-section.png"
                alt="Agricultural Scientist"
                width={600}
                height={400}
                className="rounded-lg shadow-xl"
              />
            </div>

            <div className="space-y-6">
              <div>
                <h3 className="text-green-600 font-semibold text-lg mb-2">Welcome to WHOLEGREEN</h3>
                <h2 className="text-4xl font-bold text-gray-900 mb-4 font-orbitron">
                  Premium Microgreen Technologies
                  <br />
                  <span className="text-gray-600 text-2xl">for sustainable future</span>
                </h2>
              </div>

              <p className="text-gray-600 leading-relaxed">
                We specialize in cutting-edge agricultural technologies including microgreen production, indoor
                agriculture systems, and space agriculture solutions. Our innovative approaches combine precision
                farming with sustainable practices to maximize yield while minimizing environmental impact.
              </p>

              <div className="grid grid-cols-2 gap-4">
                <div className="flex items-center gap-3">
                  <Microscope className="w-8 h-8 text-green-600" />
                  <span className="text-gray-700">Microgreen Production</span>
                </div>
                <div className="flex items-center gap-3">
                  <Sprout className="w-8 h-8 text-green-600" />
                  <span className="text-gray-700">Indoor Agriculture</span>
                </div>
                <div className="flex items-center gap-3">
                  <Rocket className="w-8 h-8 text-green-600" />
                  <span className="text-gray-700">Space Agriculture</span>
                </div>
                <div className="flex items-center gap-3">
                  <Beaker className="w-8 h-8 text-green-600" />
                  <span className="text-gray-700">Precision Farming</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Services Section */}
      <section id="services" className="py-20 bg-gray-50">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h3 className="text-green-600 font-semibold text-lg mb-2">Our Services</h3>
            <h2 className="text-4xl font-bold text-gray-900 mb-4 font-orbitron">What Exactly We Do?</h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              We provide comprehensive agricultural technology solutions
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <Card className="bg-gradient-to-br from-green-400 to-emerald-500 text-white hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8 text-center">
                <Microscope className="w-12 h-12 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2 font-orbitron">Microgreen Production</h3>
                <p className="text-green-100">Advanced cultivation systems for premium microgreens</p>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-blue-400 to-cyan-500 text-white hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8 text-center">
                <Sprout className="w-12 h-12 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2 font-orbitron">Indoor Agriculture</h3>
                <p className="text-blue-100">Controlled environment farming solutions</p>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-purple-400 to-pink-500 text-white hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8 text-center">
                <Rocket className="w-12 h-12 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2 font-orbitron">Space Agriculture</h3>
                <p className="text-purple-100">Extraterrestrial farming technologies</p>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-orange-400 to-red-500 text-white hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8 text-center">
                <TrendingUp className="w-12 h-12 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2 font-orbitron">Precision Farming</h3>
                <p className="text-orange-100">IoT-enabled monitoring systems</p>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-teal-400 to-green-500 text-white hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8 text-center">
                <Beaker className="w-12 h-12 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2 font-orbitron">Hydroponics Systems</h3>
                <p className="text-teal-100">Soil-free growing technology</p>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-indigo-400 to-purple-500 text-white hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8 text-center">
                <Globe className="w-12 h-12 mx-auto mb-4" />
                <h3 className="text-xl font-bold mb-2 font-orbitron">Agricultural Consulting</h3>
                <p className="text-indigo-100">Expert technical consultation</p>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* Statistics Section */}
      <section className="py-20 relative">
        <div className="absolute inset-0">
          <Image
            src="/images/stats-section.png"
            alt="Agricultural Statistics Background"
            fill
            className="object-cover"
          />
          <div className="absolute inset-0 bg-black/60"></div>
        </div>

        <div className="relative z-10 container mx-auto px-4">
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-8 text-center text-white">
            <div>
              <div className="text-4xl md:text-5xl font-bold text-green-400 mb-2">150</div>
              <div className="text-gray-300">Happy Clients</div>
            </div>
            <div>
              <div className="text-4xl md:text-5xl font-bold text-green-400 mb-2">2.5K</div>
              <div className="text-gray-300">Systems Installed</div>
            </div>
            <div>
              <div className="text-4xl md:text-5xl font-bold text-green-400 mb-2">50M</div>
              <div className="text-gray-300">Plants Grown</div>
            </div>
            <div>
              <div className="text-4xl md:text-5xl font-bold text-green-400 mb-2">12</div>
              <div className="text-gray-300">Years of Exp</div>
            </div>
            <div>
              <div className="text-4xl md:text-5xl font-bold text-green-400 mb-2">25</div>
              <div className="text-gray-300">Specialists</div>
            </div>
            <div>
              <div className="text-4xl md:text-5xl font-bold text-green-400 mb-2">18</div>
              <div className="text-gray-300">Tech Awards</div>
            </div>
          </div>
        </div>
      </section>

      {/* Products Preview */}
      <section className="py-20 bg-white">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h3 className="text-green-600 font-semibold text-lg mb-2">Our Products</h3>
            <h2 className="text-4xl font-bold text-gray-900 mb-4 font-orbitron">Premium Microgreens</h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              Discover our range of premium microgreen varieties, each with unique flavor profiles and nutritional
              benefits
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
            <Card className="hover:shadow-xl transition-all duration-300 border-purple-200">
              <CardContent className="p-6 text-center">
                <div className="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Leaf className="w-8 h-8 text-purple-600" />
                </div>
                <h3 className="font-bold text-lg mb-2">Perilla</h3>
                <p className="text-gray-600 text-sm mb-4">Anason aromalı premium mikrofiliz</p>
                <Badge className="bg-purple-100 text-purple-800">41 kcal/100g</Badge>
              </CardContent>
            </Card>

            <Card className="hover:shadow-xl transition-all duration-300 border-green-200">
              <CardContent className="p-6 text-center">
                <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Sprout className="w-8 h-8 text-green-600" />
                </div>
                <h3 className="font-bold text-lg mb-2">Daikon Radish</h3>
                <p className="text-gray-600 text-sm mb-4">Japon mutfağının vazgeçilmezi</p>
                <Badge className="bg-green-100 text-green-800">28 kcal/100g</Badge>
              </CardContent>
            </Card>

            <Card className="hover:shadow-xl transition-all duration-300 border-red-200">
              <CardContent className="p-6 text-center">
                <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Star className="w-8 h-8 text-red-600" />
                </div>
                <h3 className="font-bold text-lg mb-2">Amaranth</h3>
                <p className="text-gray-600 text-sm mb-4">Çarpıcı kırmızı renk</p>
                <Badge className="bg-red-100 text-red-800">35 kcal/100g</Badge>
              </CardContent>
            </Card>

            <Card className="hover:shadow-xl transition-all duration-300 border-orange-200">
              <CardContent className="p-6 text-center">
                <div className="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <ChefHat className="w-8 h-8 text-orange-600" />
                </div>
                <h3 className="font-bold text-lg mb-2">Red Radish</h3>
                <p className="text-gray-600 text-sm mb-4">Keskin biberimsi tat</p>
                <Badge className="bg-orange-100 text-orange-800">32 kcal/100g</Badge>
              </CardContent>
            </Card>
          </div>

          <div className="text-center">
            <Link href="/products">
              <Button
                size="lg"
                className="bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 text-white"
              >
                Tüm Ürünleri Görüntüle
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* Team Section */}
      <section id="team" className="py-20 bg-gray-50">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h3 className="text-green-600 font-semibold text-lg mb-2">Our Staff</h3>
            <h2 className="text-4xl font-bold text-gray-900 mb-4 font-orbitron">Who We Are?</h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              Meet our amazing team of agricultural scientists and technology experts
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <Card className="text-center hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8">
                <div className="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Users className="w-12 h-12 text-green-600" />
                </div>
                <h3 className="text-xl font-bold mb-2 font-orbitron">Dr. Sarah Chen</h3>
                <p className="text-green-600 font-medium mb-3">Agricultural Scientist, Microgreen Specialist</p>
                <p className="text-gray-600 text-sm">
                  Leading expert in microgreen cultivation with 15+ years of research experience
                </p>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8">
                <div className="w-24 h-24 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Rocket className="w-12 h-12 text-blue-600" />
                </div>
                <h3 className="text-xl font-bold mb-2 font-orbitron">Dr. Michael Torres</h3>
                <p className="text-blue-600 font-medium mb-3">Space Agriculture Engineer</p>
                <p className="text-gray-600 text-sm">
                  Pioneer in extraterrestrial farming technologies and closed-loop systems
                </p>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-xl transition-all duration-300">
              <CardContent className="p-8">
                <div className="w-24 h-24 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Beaker className="w-12 h-12 text-purple-600" />
                </div>
                <h3 className="text-xl font-bold mb-2 font-orbitron">Dr. Emily Rodriguez</h3>
                <p className="text-purple-600 font-medium mb-3">Indoor Agriculture Systems Designer</p>
                <p className="text-gray-600 text-sm">
                  Specialist in controlled environment agriculture and hydroponic systems
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-gradient-to-r from-green-600 to-emerald-600 text-white">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-4xl font-bold mb-4 font-orbitron">Ready to Transform Your Agriculture?</h2>
          <p className="text-xl text-green-100 mb-8 max-w-2xl mx-auto">
            Contact us today to learn how our advanced agricultural technologies can revolutionize your farming
            operations
          </p>
          <Link href="/contact">
            <Button size="lg" variant="secondary" className="bg-white text-green-600 hover:bg-gray-100">
              Get Started Today
            </Button>
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-12">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <div className="flex items-center gap-3 mb-4">
                <Image src="/images/pyramid-logo.svg" alt="WHOLEGREEN" width={32} height={32} />
                <Image
                  src="/images/wholegreen-logo.png"
                  alt="WHOLEGREEN"
                  width={120}
                  height={24}
                  className="h-6 w-auto"
                />
              </div>
              <p className="text-gray-400">Premium microgreen technologies for a sustainable future</p>
            </div>

            <div>
              <h4 className="font-semibold mb-4">Services</h4>
              <ul className="space-y-2 text-gray-400">
                <li>Microgreen Production</li>
                <li>Indoor Agriculture</li>
                <li>Space Agriculture</li>
                <li>Precision Farming</li>
              </ul>
            </div>

            <div>
              <h4 className="font-semibold mb-4">Products</h4>
              <ul className="space-y-2 text-gray-400">
                <li>Perilla</li>
                <li>Daikon Radish</li>
                <li>Amaranth</li>
                <li>Red Radish</li>
              </ul>
            </div>

            <div>
              <h4 className="font-semibold mb-4">Contact</h4>
              <ul className="space-y-2 text-gray-400">
                <li>info@wholegreen.com</li>
                <li>+1 (555) 123-4567</li>
                <li>123 Innovation Drive</li>
                <li>Tech Valley, CA 94000</li>
              </ul>
            </div>
          </div>

          <Separator className="my-8 bg-gray-800" />

          <div className="text-center text-gray-400">
            <p>&copy; 2024 WHOLEGREEN. All rights reserved.</p>
          </div>
        </div>
      </footer>

      <style jsx>{`
        @keyframes fadeIn {
          0% { opacity: 0; }
          100% { opacity: 1; }
        }
        
        @keyframes logoEntrance {
          0% { transform: scale(0) rotate(-180deg); opacity: 0; }
          50% { transform: scale(1.1) rotate(-90deg); opacity: 0.8; }
          100% { transform: scale(1) rotate(0deg); opacity: 1; }
        }
        
        @keyframes logoGlow {
          0% { filter: drop-shadow(0 0 10px rgba(34, 197, 94, 0.3)); }
          100% { filter: drop-shadow(0 0 20px rgba(34, 197, 94, 0.6)); }
        }
        
        @keyframes ring1 {
          0% { transform: scale(0.8); opacity: 0.8; }
          100% { transform: scale(1.2); opacity: 0; }
        }
        
        @keyframes ring2 {
          0% { transform: scale(0.8); opacity: 0.6; }
          100% { transform: scale(1.4); opacity: 0; }
        }
        
        @keyframes ring3 {
          0% { transform: scale(0.8); opacity: 0.4; }
          100% { transform: scale(1.6); opacity: 0; }
        }
        
        @keyframes slideUp {
          0% { transform: translateY(30px); opacity: 0; }
          100% { transform: translateY(0); opacity: 1; }
        }
        
        @keyframes particle {
          0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.3; }
          25% { transform: translateY(-15px) rotate(90deg); opacity: 0.8; }
          50% { transform: translateY(-30px) rotate(180deg); opacity: 0.6; }
          75% { transform: translateY(-15px) rotate(270deg); opacity: 0.9; }
        }
      `}</style>
    </div>
  )
}
