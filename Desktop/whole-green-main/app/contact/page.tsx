"use client"

import type React from "react"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Badge } from "@/components/ui/badge"
import { Phone, Mail, MapPin, Clock, Send, CheckCircle } from "lucide-react"
import Link from "next/link"

export default function ContactPage() {
  const [isSubmitted, setIsSubmitted] = useState(false)
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
    company: "",
    message: "",
  })

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    try {
      const response = await fetch("/api/contact", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      })

      if (response.ok) {
        setIsSubmitted(true)
        setFormData({
          name: "",
          email: "",
          phone: "",
          company: "",
          message: "",
        })
      }
    } catch (error) {
      console.error("Error submitting form:", error)
    }
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    })
  }

  return (
    <div className="min-h-screen bg-white">
      {/* Navigation */}
      <nav className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center">
              <img src="/images/wholegreen-logo.png" alt="WholeGreen" className="h-8 w-auto" />
            </div>
            <div className="hidden md:block">
              <div className="ml-10 flex items-baseline space-x-4">
                <Link href="/" className="text-gray-500 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium">
                  Home
                </Link>
                <Link
                  href="/products"
                  className="text-gray-500 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium"
                >
                  Products
                </Link>
                <Link
                  href="/contact"
                  className="text-gray-900 hover:text-green-600 px-3 py-2 rounded-md text-sm font-medium"
                >
                  Contact
                </Link>
              </div>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="bg-gradient-to-r from-green-50 to-emerald-50 py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <Badge className="mb-4 bg-green-100 text-green-800 hover:bg-green-200">Get in Touch</Badge>
          <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6">Contact WholeGreen</h1>
          <p className="text-xl text-gray-600 max-w-3xl mx-auto">
            Ready to elevate your culinary experience with premium microgreens? We're here to help with orders,
            questions, and custom growing solutions.
          </p>
        </div>
      </section>

      {/* Contact Form and Info */}
      <section className="py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
            {/* Contact Form */}
            <div>
              <Card>
                <CardHeader>
                  <CardTitle className="text-2xl text-gray-900">Send us a Message</CardTitle>
                  <p className="text-gray-600">Fill out the form below and we'll get back to you within 24 hours.</p>
                </CardHeader>
                <CardContent>
                  {isSubmitted ? (
                    <div className="text-center py-8">
                      <CheckCircle className="w-16 h-16 text-green-600 mx-auto mb-4" />
                      <h3 className="text-xl font-semibold text-gray-900 mb-2">Message Sent!</h3>
                      <p className="text-gray-600">
                        Thank you for contacting us. We'll get back to you within 24 hours.
                      </p>
                    </div>
                  ) : (
                    <form onSubmit={handleSubmit} className="space-y-6">
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                          <Label htmlFor="name">Full Name *</Label>
                          <Input
                            id="name"
                            name="name"
                            type="text"
                            required
                            value={formData.name}
                            onChange={handleChange}
                            className="mt-1"
                          />
                        </div>
                        <div>
                          <Label htmlFor="email">Email Address *</Label>
                          <Input
                            id="email"
                            name="email"
                            type="email"
                            required
                            value={formData.email}
                            onChange={handleChange}
                            className="mt-1"
                          />
                        </div>
                      </div>

                      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                          <Label htmlFor="phone">Phone Number</Label>
                          <Input
                            id="phone"
                            name="phone"
                            type="tel"
                            value={formData.phone}
                            onChange={handleChange}
                            className="mt-1"
                          />
                        </div>
                        <div>
                          <Label htmlFor="company">Company/Restaurant</Label>
                          <Input
                            id="company"
                            name="company"
                            type="text"
                            value={formData.company}
                            onChange={handleChange}
                            className="mt-1"
                          />
                        </div>
                      </div>

                      <div>
                        <Label htmlFor="message">Message *</Label>
                        <Textarea
                          id="message"
                          name="message"
                          required
                          rows={5}
                          value={formData.message}
                          onChange={handleChange}
                          className="mt-1"
                          placeholder="Tell us about your microgreen needs, order quantities, delivery requirements, or any questions you have..."
                        />
                      </div>

                      <Button type="submit" className="w-full bg-green-600 hover:bg-green-700 text-white">
                        <Send className="w-4 h-4 mr-2" />
                        Send Message
                      </Button>
                    </form>
                  )}
                </CardContent>
              </Card>
            </div>

            {/* Contact Information */}
            <div className="space-y-8">
              <Card>
                <CardHeader>
                  <CardTitle className="text-xl text-gray-900">Contact Information</CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="flex items-start gap-4">
                    <Phone className="w-6 h-6 text-green-600 mt-1" />
                    <div>
                      <h3 className="font-semibold text-gray-900">Phone</h3>
                      <p className="text-gray-600">+1 (555) 123-4567</p>
                      <p className="text-sm text-gray-500">Monday - Friday, 8:00 AM - 6:00 PM</p>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <Mail className="w-6 h-6 text-green-600 mt-1" />
                    <div>
                      <h3 className="font-semibold text-gray-900">Email</h3>
                      <p className="text-gray-600">info@wholegreen.com</p>
                      <p className="text-sm text-gray-500">We respond within 24 hours</p>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <MapPin className="w-6 h-6 text-green-600 mt-1" />
                    <div>
                      <h3 className="font-semibold text-gray-900">Address</h3>
                      <p className="text-gray-600">
                        123 Green Valley Road
                        <br />
                        Farm City, FC 12345
                        <br />
                        United States
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="text-xl text-gray-900">Business Hours</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    <div className="flex justify-between items-center">
                      <span className="text-gray-600">Monday - Friday</span>
                      <span className="font-semibold text-gray-900">8:00 AM - 6:00 PM</span>
                    </div>
                    <div className="flex justify-between items-center">
                      <span className="text-gray-600">Saturday</span>
                      <span className="font-semibold text-gray-900">9:00 AM - 4:00 PM</span>
                    </div>
                    <div className="flex justify-between items-center">
                      <span className="text-gray-600">Sunday</span>
                      <span className="text-gray-500">Closed</span>
                    </div>
                  </div>

                  <div className="mt-6 p-4 bg-green-50 rounded-lg">
                    <div className="flex items-center gap-2 mb-2">
                      <Clock className="w-4 h-4 text-green-600" />
                      <span className="font-semibold text-green-800">Same-Day Orders</span>
                    </div>
                    <p className="text-sm text-green-700">
                      Orders placed before 2:00 PM can be delivered the same day within our local delivery area.
                    </p>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="text-xl text-gray-900">Quick Order Info</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <h4 className="font-semibold text-gray-900 mb-2">Minimum Orders</h4>
                      <ul className="text-sm text-gray-600 space-y-1">
                        <li>• Restaurants: $50 minimum</li>
                        <li>• Individual customers: $25 minimum</li>
                        <li>• Bulk orders: Contact for pricing</li>
                      </ul>
                    </div>

                    <div>
                      <h4 className="font-semibold text-gray-900 mb-2">Delivery Areas</h4>
                      <ul className="text-sm text-gray-600 space-y-1">
                        <li>• Local delivery: 25-mile radius</li>
                        <li>• Regional shipping: 3-5 business days</li>
                        <li>• National shipping: Available upon request</li>
                      </ul>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* FAQ Section */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">Frequently Asked Questions</h2>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">How fresh are your microgreens?</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600">
                  Our microgreens are harvested daily and delivered within 24-48 hours of harvest to ensure maximum
                  freshness and nutritional value.
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Do you offer bulk pricing?</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600">
                  Yes! We offer competitive bulk pricing for restaurants, catering companies, and large orders. Contact
                  us for a custom quote.
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-lg">What's your shelf life?</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600">
                  When properly stored, our microgreens maintain peak quality for 5-14 days depending on the variety. We
                  provide storage instructions with every order.
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Can you grow custom varieties?</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600">
                  We can grow custom varieties for special events, seasonal menus, or ongoing restaurant needs. Lead
                  time is typically 2-3 weeks.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div className="col-span-1 md:col-span-2">
              <img
                src="/images/wholegreen-logo.png"
                alt="WholeGreen"
                className="h-8 w-auto mb-4 filter brightness-0 invert"
              />
              <p className="text-gray-300 mb-4">
                Premium microgreens grown with precision and delivered fresh to your kitchen. Elevating culinary
                experiences with nutrient-dense, flavorful greens.
              </p>
              <div className="flex space-x-4">
                <Phone className="h-5 w-5 text-green-400" />
                <span className="text-gray-300">+1 (555) 123-4567</span>
              </div>
              <div className="flex space-x-4 mt-2">
                <Mail className="h-5 w-5 text-green-400" />
                <span className="text-gray-300">info@wholegreen.com</span>
              </div>
              <div className="flex space-x-4 mt-2">
                <MapPin className="h-5 w-5 text-green-400" />
                <span className="text-gray-300">123 Green Valley, Farm City, FC 12345</span>
              </div>
            </div>

            <div>
              <h3 className="text-lg font-semibold mb-4">Quick Links</h3>
              <ul className="space-y-2">
                <li>
                  <Link href="/" className="text-gray-300 hover:text-green-400">
                    Home
                  </Link>
                </li>
                <li>
                  <Link href="/products" className="text-gray-300 hover:text-green-400">
                    Products
                  </Link>
                </li>
                <li>
                  <Link href="/contact" className="text-gray-300 hover:text-green-400">
                    Contact
                  </Link>
                </li>
              </ul>
            </div>

            <div>
              <h3 className="text-lg font-semibold mb-4">Products</h3>
              <ul className="space-y-2">
                <li>
                  <Link href="/products/perilla" className="text-gray-300 hover:text-green-400">
                    Perilla
                  </Link>
                </li>
                <li>
                  <Link href="/products/daikon-radish" className="text-gray-300 hover:text-green-400">
                    Daikon Radish
                  </Link>
                </li>
                <li>
                  <Link href="/products/amaranth" className="text-gray-300 hover:text-green-400">
                    Amaranth
                  </Link>
                </li>
                <li>
                  <Link href="/products/red-radish" className="text-gray-300 hover:text-green-400">
                    Red Radish
                  </Link>
                </li>
              </ul>
            </div>
          </div>

          <div className="border-t border-gray-800 mt-8 pt-8 text-center">
            <p className="text-gray-400">© 2024 WholeGreen. All rights reserved. | Privacy Policy | Terms of Service</p>
          </div>
        </div>
      </footer>
    </div>
  )
}
