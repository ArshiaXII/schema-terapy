"use client"

import { useEffect, useState } from "react"

interface LoadingScreenProps {
  onComplete?: () => void
}

export default function LoadingScreen({ onComplete }: LoadingScreenProps) {
  const [progress, setProgress] = useState(0)
  const [showTriangulation, setShowTriangulation] = useState(false)

  useEffect(() => {
    const timer = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          clearInterval(timer)
          if (onComplete) {
            setTimeout(onComplete, 500)
          }
          return 100
        }
        return prev + 2
      })
    }, 60)

    // Show triangulation after a brief delay
    const triangulationTimer = setTimeout(() => {
      setShowTriangulation(true)
    }, 800)

    return () => {
      clearInterval(timer)
      clearTimeout(triangulationTimer)
    }
  }, [onComplete])

  // Generate triangulation points
  const generateTriangulation = () => {
    const points = []
    const width = 800
    const height = 600
    const numPoints = 25

    // Generate random points
    for (let i = 0; i < numPoints; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height,
        id: i,
      })
    }

    // Simple Delaunay-inspired triangulation (simplified for visual effect)
    const triangles = []
    for (let i = 0; i < points.length - 2; i++) {
      for (let j = i + 1; j < points.length - 1; j++) {
        for (let k = j + 1; k < points.length; k++) {
          const p1 = points[i]
          const p2 = points[j]
          const p3 = points[k]

          // Only create triangles with reasonable edge lengths
          const d1 = Math.sqrt((p1.x - p2.x) ** 2 + (p1.y - p2.y) ** 2)
          const d2 = Math.sqrt((p2.x - p3.x) ** 2 + (p2.y - p3.y) ** 2)
          const d3 = Math.sqrt((p3.x - p1.x) ** 2 + (p3.y - p1.y) ** 2)

          if (d1 < 150 && d2 < 150 && d3 < 150) {
            triangles.push({ p1, p2, p3, id: `${i}-${j}-${k}` })
          }
        }
      }
    }

    return { points, triangles: triangles.slice(0, 40) } // Limit triangles for performance
  }

  const { points, triangles } = generateTriangulation()

  return (
    <div className="fixed inset-0 bg-white z-50 flex items-center justify-center">
      {/* Triangulation Background */}
      {showTriangulation && (
        <div className="absolute inset-0 overflow-hidden opacity-20">
          <svg
            width="100%"
            height="100%"
            viewBox="0 0 800 600"
            className="absolute inset-0"
            style={{
              animation: "meshPulse 4s ease-in-out infinite",
            }}
          >
            <defs>
              <linearGradient id="triangleGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#10b981" stopOpacity="0.1" />
                <stop offset="50%" stopColor="#059669" stopOpacity="0.2" />
                <stop offset="100%" stopColor="#047857" stopOpacity="0.1" />
              </linearGradient>
              <filter id="glow">
                <feGaussianBlur stdDeviation="2" result="coloredBlur" />
                <feMerge>
                  <feMergeNode in="coloredBlur" />
                  <feMergeNode in="SourceGraphic" />
                </feMerge>
              </filter>
            </defs>

            {/* Render triangles */}
            {triangles.map((triangle, index) => (
              <polygon
                key={triangle.id}
                points={`${triangle.p1.x},${triangle.p1.y} ${triangle.p2.x},${triangle.p2.y} ${triangle.p3.x},${triangle.p3.y}`}
                fill="url(#triangleGradient)"
                stroke="#10b981"
                strokeWidth="0.5"
                opacity="0.6"
                style={{
                  animation: `triangleFade 3s ease-in-out infinite`,
                  animationDelay: `${index * 0.1}s`,
                }}
              />
            ))}

            {/* Render connection lines */}
            {triangles.map((triangle, index) => (
              <g key={`lines-${triangle.id}`}>
                <line
                  x1={triangle.p1.x}
                  y1={triangle.p1.y}
                  x2={triangle.p2.x}
                  y2={triangle.p2.y}
                  stroke="#10b981"
                  strokeWidth="1"
                  opacity="0.3"
                  filter="url(#glow)"
                  style={{
                    animation: `lineGlow 2s ease-in-out infinite`,
                    animationDelay: `${index * 0.05}s`,
                  }}
                />
                <line
                  x1={triangle.p2.x}
                  y1={triangle.p2.y}
                  x2={triangle.p3.x}
                  y2={triangle.p3.y}
                  stroke="#10b981"
                  strokeWidth="1"
                  opacity="0.3"
                  filter="url(#glow)"
                  style={{
                    animation: `lineGlow 2s ease-in-out infinite`,
                    animationDelay: `${index * 0.05 + 0.5}s`,
                  }}
                />
                <line
                  x1={triangle.p3.x}
                  y1={triangle.p3.y}
                  x2={triangle.p1.x}
                  y2={triangle.p1.y}
                  stroke="#10b981"
                  strokeWidth="1"
                  opacity="0.3"
                  filter="url(#glow)"
                  style={{
                    animation: `lineGlow 2s ease-in-out infinite`,
                    animationDelay: `${index * 0.05 + 1}s`,
                  }}
                />
              </g>
            ))}

            {/* Render points */}
            {points.map((point, index) => (
              <circle
                key={point.id}
                cx={point.x}
                cy={point.y}
                r="2"
                fill="#10b981"
                opacity="0.8"
                style={{
                  animation: `pointPulse 2s ease-in-out infinite`,
                  animationDelay: `${index * 0.1}s`,
                }}
              />
            ))}
          </svg>
        </div>
      )}

      {/* Loading Content */}
      <div className="text-center z-10">
        <div className="mb-8">
          <img src="/images/wholegreen-logo.png" alt="WholeGreen" className="h-16 w-auto mx-auto mb-4" />
          <h1 className="text-2xl font-bold text-gray-900 mb-2">WholeGreen</h1>
          <p className="text-gray-600">Premium Microgreens</p>
        </div>

        <div className="w-64 mx-auto">
          <div className="bg-gray-200 rounded-full h-2 mb-4">
            <div
              className="bg-green-600 h-2 rounded-full transition-all duration-300 ease-out"
              style={{ width: `${progress}%` }}
            />
          </div>
          <p className="text-sm text-gray-500">Loading... {progress}%</p>
        </div>
      </div>

      <style jsx>{`
        @keyframes meshPulse {
          0%, 100% { opacity: 0.15; transform: scale(1); }
          50% { opacity: 0.25; transform: scale(1.02); }
        }
        
        @keyframes triangleFade {
          0%, 100% { opacity: 0.3; }
          50% { opacity: 0.7; }
        }
        
        @keyframes lineGlow {
          0%, 100% { opacity: 0.2; stroke-width: 1; }
          50% { opacity: 0.6; stroke-width: 1.5; }
        }
        
        @keyframes pointPulse {
          0%, 100% { opacity: 0.6; r: 2; }
          50% { opacity: 1; r: 3; }
        }
      `}</style>
    </div>
  )
}
