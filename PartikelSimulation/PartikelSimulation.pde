
ArrayList<Activator> activators = new ArrayList<Activator>();
ArrayList<Inhibitor> inhibitors = new ArrayList<Inhibitor>();


final double gForceAc = 0.01;
final double gForceIn = 6;

final PVector center = new PVector(250,250);

void setup()
{
  size(500,500);
}


double previousTime = 0;;

void update()
{
  double dt = millis() - previousTime;
  
  previousTime = millis();
  
  
  for(Activator activator : activators)
  {
    activator.update(dt);
  }
  
  for(Inhibitor inhibitor : inhibitors)
  {
    
  }
  
}

void draw()
{
  update();
  
  clear();
  fill(255);
  
  for(Activator activator : activators)
  {
    activator.draw();
  }
  
  for(Inhibitor inhibitor : inhibitors)
  {
    
  } 
}

void mouseClicked()
{
  activators.add(new Activator(mouseX, mouseY)); 
  
  for(int i = 0; i < 20; i++)
  {
    activators.add(new Activator((int)(Math.random() * 400) + 50, (int)(Math.random() * 400) + 50));
  }

}

class Activator
{
  public PVector location;
  
  PVector force = new PVector(0,0);
  PVector velocity = new PVector(0,0);
  
  public Activator(int x, int y)
  {
    location = new PVector(x,y);
  }
  
  public void draw()
  {
    ellipse(location.x, location.y,5,5);
  }
  
  public void update(double dt)
  {
    setLocation(dt);
    
  }
  
  private void setLocation(double dt)
  {
   //calculate force on Activator
   force.x = 0;
   force.y = 0;
   for(Activator activator : activators)
   {
     if(activator != this)
     {
       force.x += (location.x - activator.location.x) * gForceAc/(getDistance(location, activator.location) * getDistance(location, activator.location));
       force.y += (location.y - activator.location.y) * gForceAc/(getDistance(location, activator.location) * getDistance(location, activator.location));
     }
   }
   
   //left wall
   force.x += 1/(1 * location.x);
   
   //right wall
   force.x -= 1/(1 * (500 - location.x)); 
   
   //upper wall
   force.y += 1/(1 * location.y);
   
   //bottom wall
   force.y -= 1/(1 * (500 - location.y)); 
   
   //
   
   //friction
   force.x -= velocity.x/40;
   force.y -= velocity.y/40;
   
   velocity.x += force.x * dt;
   velocity.y += force.y * dt;
   
    if(location.x >= 500 || location.x <= 0 || location.y >= 500 || location.y <= 0)
   {
     velocity.x = 250 - location.x;
     velocity.y = 250 - location.y;
   }
   
   location.x += 0.5 * velocity.x * dt;
   location.y += 0.5 * velocity.y * dt;
   
  
  }
  
}

class Inhibitor
{
}


double getDistance(PVector v1, PVector v2)
{
  return Math.sqrt((v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y));
}