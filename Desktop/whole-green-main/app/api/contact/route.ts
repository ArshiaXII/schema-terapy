import { type NextRequest, NextResponse } from "next/server"

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { name, email, message, service } = body

    // Here you would typically save to a database or send an email
    console.log("AgriTech contact form submission:", { name, email, message, service })

    // Simulate processing time
    await new Promise((resolve) => setTimeout(resolve, 1000))

    return NextResponse.json({
      success: true,
      message:
        "Thank you for your inquiry! Our agricultural specialists will contact you soon to discuss your project.",
    })
  } catch (error) {
    return NextResponse.json({ success: false, message: "Something went wrong. Please try again." }, { status: 500 })
  }
}
