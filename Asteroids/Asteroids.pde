
ArrayList<Planet> planets = new ArrayList<Planet>();

float currentRadius = 10;

void setup()
{
   size(480, 480);
}

void draw()
{
  for(Planet planet : planets)
  {
    planet.update();
  }
  
  clear();
  
  for(Planet planet : planets)
  {
    planet.draw();
  }
  
  ellipse(mouseX, mouseY, currentRadius, currentRadius);
  
}

void mousePressed()
{ 
  if(mouseButton == LEFT)
  {
    planets.add(new Planet(mouseX,mouseY, (int)currentRadius));
  }
  else if(mouseButton == RIGHT)
  {
    planets.add(new FixedPlanet(mouseX,mouseY, (int)currentRadius));
  }
}

void keyPressed()
{
  planets.clear();
}

void mouseWheel(MouseEvent event)
{
  currentRadius += event.getCount();
}

class Planet
{  
  PVector location;
  PVector force;
  PVector velocity;
  
  double mass;
  
  int radius;
  
  Planet(int xpos, int ypos, int radius)
  {
    this.location = new PVector(xpos,ypos);
    
    this.radius = radius;
    this.mass = radius * radius * Math.PI;
    
    this.force = new PVector(0,0);
    this.velocity = new PVector(0,0);
  }
  
  void update()
  {
    force = new PVector(0,0);
    
    for(Planet planet : planets)
    {
      if(planet == this || getDistance(location, planet.location) <= 10)
        continue;
      
      force.x += (planet.location.x - location.x) * planet.mass/(getDistance(location, planet.location) * getDistance(location, planet.location));
      force.y += (planet.location.y - location.y) * planet.mass/(getDistance(location, planet.location) * getDistance(location, planet.location));
    }
    
    velocity.x += force.x;
    velocity.y += force.y;
    
    location.x += velocity.x * 0.01;
    location.y += velocity.y * 0.01;
  }
  
  void draw()
  {
    fill(255);
    
    ellipse(location.x, location.y, radius, radius);
  }
}

class FixedPlanet extends Planet
{
  FixedPlanet(int xpos, int ypos, int radius)
  {
    super(xpos,ypos,radius);
  }
  
  @Override
  void update()
  {
  }
}

double getDistance(PVector v1, PVector v2)
{
  return Math.sqrt((v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y));
}