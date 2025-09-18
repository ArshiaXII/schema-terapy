"use client"

import { useEffect, useRef, useCallback } from 'react'

interface Node {
  x: number
  y: number
  vx: number
  vy: number
  originalX: number
  originalY: number
  id: number
}

export default function PlexusBackground() {
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const animationRef = useRef<number>()
  const nodesRef = useRef<Node[]>([])
  const mouseRef = useRef({ x: 0, y: 0, isActive: false })
  const isMobileRef = useRef(false)
  const touchTimeoutRef = useRef<NodeJS.Timeout>()

  // Configuration
  const config = {
    nodeCount: 100, // Increased density for more prominent effect
    maxDistance: 120,
    interactionRadius: 180,
    nodeSpeed: 0.3, // Very slow movement
    nodeSize: 3.5, // Increased node size for better visibility
    lineWidth: 2, // Increased line thickness for more impact
    baseOpacity: 0.5, // Increased to 50% for much better visibility
    interactionOpacity: 0.85, // Increased to 85% for strong mouse interaction
    color: '#FFFFFF', // Changed to white for blend mode compatibility
    mobileNodeCount: 60, // Increased mobile density
    mobileMaxDistance: 100,
  }

  // Detect mobile device
  const detectMobile = useCallback(() => {
    return window.innerWidth <= 768 || /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
  }, [])

  // Initialize nodes
  const initializeNodes = useCallback((canvas: HTMLCanvasElement) => {
    const nodeCount = isMobileRef.current ? config.mobileNodeCount : config.nodeCount
    const nodes: Node[] = []
    
    for (let i = 0; i < nodeCount; i++) {
      const x = Math.random() * canvas.width
      const y = Math.random() * canvas.height
      nodes.push({
        x,
        y,
        vx: (Math.random() - 0.5) * config.nodeSpeed,
        vy: (Math.random() - 0.5) * config.nodeSpeed,
        originalX: x,
        originalY: y,
        id: i
      })
    }
    
    nodesRef.current = nodes
  }, [config.nodeCount, config.mobileNodeCount, config.nodeSpeed])

  // Update node positions
  const updateNodes = useCallback((canvas: HTMLCanvasElement) => {
    const nodes = nodesRef.current
    const mouse = mouseRef.current
    
    nodes.forEach(node => {
      // Basic movement
      node.x += node.vx
      node.y += node.vy
      
      // Boundary collision with smooth bounce
      if (node.x <= 0 || node.x >= canvas.width) {
        node.vx *= -1
        node.x = Math.max(0, Math.min(canvas.width, node.x))
      }
      if (node.y <= 0 || node.y >= canvas.height) {
        node.vy *= -1
        node.y = Math.max(0, Math.min(canvas.height, node.y))
      }
      
      // Mouse interaction (desktop only)
      if (!isMobileRef.current && mouse.isActive) {
        const dx = mouse.x - node.x
        const dy = mouse.y - node.y
        const distance = Math.sqrt(dx * dx + dy * dy)
        
        if (distance < config.interactionRadius) {
          const force = (config.interactionRadius - distance) / config.interactionRadius
          const attraction = force * 0.02 // Very gentle attraction
          node.vx += dx * attraction * 0.1
          node.vy += dy * attraction * 0.1
        }
      }
      
      // Damping to prevent excessive speed
      node.vx *= 0.99
      node.vy *= 0.99
      
      // Gentle return to original area
      const returnForce = 0.001
      node.vx += (node.originalX - node.x) * returnForce
      node.vy += (node.originalY - node.y) * returnForce
    })
  }, [config.interactionRadius])

  // Draw the plexus network
  const draw = useCallback((canvas: HTMLCanvasElement, ctx: CanvasRenderingContext2D) => {
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    
    const nodes = nodesRef.current
    const mouse = mouseRef.current
    const maxDistance = isMobileRef.current ? config.mobileMaxDistance : config.maxDistance
    
    // Draw connections first (behind nodes)
    ctx.strokeStyle = config.color
    ctx.lineWidth = config.lineWidth
    
    for (let i = 0; i < nodes.length; i++) {
      for (let j = i + 1; j < nodes.length; j++) {
        const dx = nodes[i].x - nodes[j].x
        const dy = nodes[i].y - nodes[j].y
        const distance = Math.sqrt(dx * dx + dy * dy)
        
        if (distance < maxDistance) {
          let opacity = config.baseOpacity * (1 - distance / maxDistance)
          
          // Enhance opacity near mouse (desktop only)
          if (!isMobileRef.current && mouse.isActive) {
            const midX = (nodes[i].x + nodes[j].x) / 2
            const midY = (nodes[i].y + nodes[j].y) / 2
            const mouseDistance = Math.sqrt((mouse.x - midX) ** 2 + (mouse.y - midY) ** 2)
            
            if (mouseDistance < config.interactionRadius) {
              const enhancement = (config.interactionRadius - mouseDistance) / config.interactionRadius
              opacity = Math.min(config.interactionOpacity, opacity + enhancement * 0.15)
            }
          }
          
          ctx.globalAlpha = opacity
          ctx.beginPath()
          ctx.moveTo(nodes[i].x, nodes[i].y)
          ctx.lineTo(nodes[j].x, nodes[j].y)
          ctx.stroke()
        }
      }
    }
    
    // Draw nodes
    ctx.fillStyle = config.color
    nodes.forEach(node => {
      let opacity = config.baseOpacity * 1.5
      
      // Enhance opacity near mouse (desktop only)
      if (!isMobileRef.current && mouse.isActive) {
        const mouseDistance = Math.sqrt((mouse.x - node.x) ** 2 + (mouse.y - node.y) ** 2)
        if (mouseDistance < config.interactionRadius) {
          const enhancement = (config.interactionRadius - mouseDistance) / config.interactionRadius
          opacity = Math.min(config.interactionOpacity, opacity + enhancement * 0.2)
        }
      }
      
      ctx.globalAlpha = opacity
      ctx.beginPath()
      ctx.arc(node.x, node.y, config.nodeSize, 0, Math.PI * 2)
      ctx.fill()
    })
    
    ctx.globalAlpha = 1
  }, [config])

  // Animation loop
  const animate = useCallback(() => {
    const canvas = canvasRef.current
    const ctx = canvas?.getContext('2d')
    
    if (!canvas || !ctx) return
    
    updateNodes(canvas)
    draw(canvas, ctx)
    
    animationRef.current = requestAnimationFrame(animate)
  }, [updateNodes, draw])

  // Handle resize
  const handleResize = useCallback(() => {
    const canvas = canvasRef.current
    if (!canvas) return
    
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    
    // Reinitialize nodes on significant resize
    initializeNodes(canvas)
  }, [initializeNodes])

  // Mouse move handler
  const handleMouseMove = useCallback((e: MouseEvent) => {
    if (isMobileRef.current) return
    
    mouseRef.current = {
      x: e.clientX,
      y: e.clientY,
      isActive: true
    }
  }, [])

  // Touch handler for mobile
  const handleTouch = useCallback((e: TouchEvent) => {
    if (!isMobileRef.current) return
    
    const touch = e.touches[0]
    if (touch) {
      // Brief enhancement effect on touch
      mouseRef.current = {
        x: touch.clientX,
        y: touch.clientY,
        isActive: true
      }
      
      // Clear the effect after a short time
      if (touchTimeoutRef.current) {
        clearTimeout(touchTimeoutRef.current)
      }
      
      touchTimeoutRef.current = setTimeout(() => {
        mouseRef.current.isActive = false
      }, 500)
    }
  }, [])

  useEffect(() => {
    const canvas = canvasRef.current
    if (!canvas) return
    
    // Setup
    isMobileRef.current = detectMobile()
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    
    initializeNodes(canvas)
    
    // Event listeners
    window.addEventListener('resize', handleResize)
    if (!isMobileRef.current) {
      window.addEventListener('mousemove', handleMouseMove)
    } else {
      window.addEventListener('touchstart', handleTouch)
      window.addEventListener('touchmove', handleTouch)
    }
    
    // Start animation
    animate()
    
    // Cleanup
    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current)
      }
      if (touchTimeoutRef.current) {
        clearTimeout(touchTimeoutRef.current)
      }
      window.removeEventListener('resize', handleResize)
      window.removeEventListener('mousemove', handleMouseMove)
      window.removeEventListener('touchstart', handleTouch)
      window.removeEventListener('touchmove', handleTouch)
    }
  }, [detectMobile, initializeNodes, handleResize, handleMouseMove, handleTouch, animate])

  return (
    <canvas
      ref={canvasRef}
      style={{
        position: 'fixed',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
        zIndex: 1, // Positive z-index for proper layering
        pointerEvents: 'none', // Don't interfere with page interactions
        background: 'transparent',
        mixBlendMode: 'difference' // Critical for visibility on all backgrounds
      }}
    />
  )
}
