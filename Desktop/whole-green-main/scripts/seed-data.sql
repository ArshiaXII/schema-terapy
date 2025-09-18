-- Seed data for the GreenThumb website

-- Insert services
INSERT INTO services (name, description, price_range, image_url) VALUES
('Lawn Care', 'Professional lawn maintenance including mowing, fertilizing, and weed control', '$50-200/month', '/images/lawn-care.jpg'),
('Garden Design', 'Custom garden design and landscaping solutions for your outdoor space', '$500-5000', '/images/garden-design.jpg'),
('Plant Installation', 'Expert plant selection and installation for optimal growth and beauty', '$100-1000', '/images/plant-installation.jpg'),
('Maintenance', 'Ongoing garden and landscape maintenance services', '$75-300/month', '/images/maintenance.jpg'),
('Landscaping', 'Complete landscape transformation and hardscaping services', '$1000-10000', '/images/landscaping.jpg'),
('Consultation', 'Professional gardening advice and planning consultation', '$100-300', '/images/consultation.jpg');

-- Insert team members
INSERT INTO team_members (name, position, bio, image_url, social_links) VALUES
('Andrew Brown', 'Landscape Designer, Florist', 'Andrew has over 15 years of experience in landscape design and specializes in creating beautiful, sustainable gardens.', '/images/andrew-brown.jpg', '{"facebook": "andrewbrown", "twitter": "andrewbrown", "instagram": "andrewbrown"}'),
('Sarah Johnson', 'Garden Specialist', 'Sarah is passionate about organic gardening and helps clients create eco-friendly outdoor spaces.', '/images/sarah-johnson.jpg', '{"facebook": "sarahjohnson", "instagram": "sarahjohnson"}'),
('Mike Wilson', 'Lawn Care Expert', 'Mike specializes in lawn care and maintenance, ensuring your grass stays healthy and green year-round.', '/images/mike-wilson.jpg', '{"twitter": "mikewilson", "instagram": "mikewilson"}');

-- Insert sample blog posts
INSERT INTO blog_posts (title, slug, excerpt, content, image_url, author_id, published) VALUES
('Best Plants for Your Garden', 'best-plants-for-your-garden', 'Discover the perfect plants that will thrive in your garden environment.', 'When choosing plants for your garden, it''s important to consider your local climate, soil conditions, and the amount of sunlight your garden receives...', '/images/blog-plants.jpg', 1, true),
('Seasonal Garden Care', 'seasonal-garden-care', 'Learn how to maintain your garden throughout different seasons.', 'Garden care varies significantly throughout the year. Each season brings its own challenges and opportunities...', '/images/blog-seasonal.jpg', 2, true),
('Landscape Design Ideas', 'landscape-design-ideas', 'Get inspired with creative landscape design concepts for your space.', 'Creating a beautiful landscape requires careful planning and creative vision. Here are some inspiring ideas...', '/images/blog-design.jpg', 1, true);

-- Insert sample projects
INSERT INTO projects (title, description, category, images, client_name, completion_date, featured) VALUES
('Modern Backyard Transformation', 'Complete backyard renovation with contemporary design elements', 'Landscaping', '["project1-1.jpg", "project1-2.jpg", "project1-3.jpg"]', 'The Johnson Family', '2024-05-15', true),
('Rooftop Garden Paradise', 'Urban rooftop garden with sustainable plant selection', 'Garden Design', '["project2-1.jpg", "project2-2.jpg"]', 'Downtown Office Building', '2024-04-20', true),
('Lawn Restoration Project', 'Complete lawn renovation and maintenance program', 'Lawn Care', '["project3-1.jpg", "project3-2.jpg"]', 'Suburban Home', '2024-06-10', false);
