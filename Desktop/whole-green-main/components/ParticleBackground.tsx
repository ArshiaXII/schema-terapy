"use client"

import { useEffect } from "react"

declare global {
  interface Window {
    tsParticles: any
  }
}

export default function ParticleBackground() {
  useEffect(() => {
    const initializeParticles = () => {
      if (typeof window !== "undefined" && window.tsParticles) {
        window.tsParticles.load("tsparticles", {
          fpsLimit: 60,
          interactivity: {
            events: {
              onHover: {
                enable: true,
                mode: "grab"
              }
            }
          },
          particles: {
            number: {
              value: 80,
              density: {
                enable: true,
                value_area: 800
              }
            },
            color: {
              value: "#a0a0a0" // A slightly more visible gray for the dots
            },
            shape: {
              type: "circle"
            },
            opacity: {
              value: 0.5, // Dots are 50% opaque
              random: false
            },
            size: {
              value: { min: 1, max: 3 },
              anim: {
                enable: false
              }
            },
            links: {
              enable: true,
              distance: 150,
              color: "#ffffff", // White lines
              opacity: 0.4, // Lines are 40% opaque
              width: 1
            },
            move: {
              enable: true,
              speed: 1.5, // A calm and slow speed
              direction: "none",
              random: false,
              straight: false,
              out_mode: "out",
              bounce: false
            }
          },
          detectRetina: true,
          background: {
            color: 'transparent'
          }
        })
      }
    }

    // Check if tsParticles is already loaded
    if (window.tsParticles) {
      initializeParticles()
    } else {
      // Wait for the script to load
      const checkForTsParticles = setInterval(() => {
        if (window.tsParticles) {
          clearInterval(checkForTsParticles)
          initializeParticles()
        }
      }, 100)

      // Cleanup interval after 10 seconds to prevent infinite checking
      setTimeout(() => {
        clearInterval(checkForTsParticles)
      }, 10000)
    }
  }, [])

  return <div id="tsparticles"></div>
}
