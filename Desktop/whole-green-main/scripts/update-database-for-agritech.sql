-- Update database for AgriTech Solutions

-- Update services for agricultural technologies
UPDATE services SET 
  name = 'Microgreen Production',
  description = 'Advanced microgreen cultivation systems with controlled environment technology',
  price_range = '$5,000-50,000'
WHERE name = 'Lawn Care';

UPDATE services SET 
  name = 'Indoor Agriculture',
  description = 'Complete indoor farming solutions with hydroponic and aeroponic systems',
  price_range = '$10,000-100,000'
WHERE name = 'Garden Design';

UPDATE services SET 
  name = 'Space Agriculture',
  description = 'Revolutionary farming technologies for extraterrestrial environments',
  price_range = '$50,000-500,000'
WHERE name = 'Plant Installation';

UPDATE services SET 
  name = 'Precision Farming',
  description = 'IoT-enabled agricultural monitoring and automation systems',
  price_range = '$2,000-25,000'
WHERE name = 'Maintenance';

UPDATE services SET 
  name = 'Hydroponics Systems',
  description = 'Soil-free growing systems for maximum yield and efficiency',
  price_range = '$3,000-30,000'
WHERE name = 'Landscaping';

UPDATE services SET 
  name = 'Agricultural Consulting',
  description = 'Expert consultation on advanced agricultural technologies and implementation',
  price_range = '$200-500/hour'
WHERE name = 'Consultation';

-- Update team members for agricultural focus
UPDATE team_members SET 
  name = 'Dr. Sarah Chen',
  position = 'Agricultural Scientist, Space Farming Specialist',
  bio = 'Dr. Chen leads our space agriculture research program and has published extensively on extraterrestrial farming technologies.'
WHERE name = 'Andrew Brown';

UPDATE team_members SET 
  name = 'Dr. Michael Rodriguez',
  position = 'Microgreen Production Expert',
  bio = 'Specializes in optimizing microgreen production systems and developing new cultivation techniques.'
WHERE name = 'Sarah Johnson';

UPDATE team_members SET 
  name = 'Dr. Emily Watson',
  position = 'Indoor Agriculture Engineer',
  bio = 'Expert in designing and implementing large-scale indoor farming facilities with advanced automation.'
WHERE name = 'Mike Wilson';

-- Update blog posts for agricultural content
UPDATE blog_posts SET 
  title = 'Microgreen Production Techniques',
  slug = 'microgreen-production-techniques',
  excerpt = 'Advanced methods for optimizing microgreen yield and quality in controlled environments.',
  content = 'Microgreen production requires precise control of environmental factors including light, temperature, humidity, and nutrients...'
WHERE title = 'Best Plants for Your Garden';

UPDATE blog_posts SET 
  title = 'Indoor Agriculture Systems',
  slug = 'indoor-agriculture-systems',
  excerpt = 'Comprehensive guide to setting up efficient indoor farming operations.',
  content = 'Indoor agriculture represents the future of sustainable food production, offering year-round growing capabilities...'
WHERE title = 'Seasonal Garden Care';

UPDATE blog_posts SET 
  title = 'Space Agriculture Research',
  slug = 'space-agriculture-research',
  excerpt = 'Latest developments in farming technologies for space exploration and colonization.',
  content = 'As humanity prepares for long-term space missions and eventual colonization of other planets...'
WHERE title = 'Landscape Design Ideas';

-- Update projects for agricultural focus
UPDATE projects SET 
  title = 'Mars Simulation Greenhouse',
  description = 'Advanced greenhouse facility simulating Martian growing conditions',
  category = 'Space Agriculture',
  client_name = 'NASA Research Center'
WHERE title = 'Modern Backyard Transformation';

UPDATE projects SET 
  title = 'Vertical Microgreen Farm',
  description = 'Large-scale vertical farming facility for microgreen production',
  category = 'Indoor Agriculture',
  client_name = 'Urban Fresh Foods'
WHERE title = 'Rooftop Garden Paradise';

UPDATE projects SET 
  title = 'Automated Hydroponic System',
  description = 'Fully automated hydroponic growing system with IoT monitoring',
  category = 'Precision Farming',
  client_name = 'TechFarm Industries'
WHERE title = 'Lawn Restoration Project';
