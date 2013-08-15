class LWorm extends LBody{
  
  int WormLength = 5;
        float dF = 0;
  boolean Pull = true;
  
  ArrayList<LWormPart> Parts = new ArrayList<LWormPart>();
  ArrayList<DistanceJoint> Joints = new ArrayList<DistanceJoint>();
  
  LWorm(float X, float Y){
    
    
    Vec2 size = new Vec2(1,WormLength * iPixDefaultSize - iPixDefaultHalfSize);
    Vec2 coord = new Vec2(X,Y);
    Vec2 pointCoordAndSize = box2d.coordPixelsToWorld(coord.add(size));
    Vec2 pointCoord = box2d.coordPixelsToWorld(coord);
    Vec2 lowerBound = new Vec2(min(pointCoordAndSize.x,pointCoord.x), min(pointCoordAndSize.y,pointCoord.y));
    Vec2 upperBound = new Vec2(max(pointCoordAndSize.x,pointCoord.x), max(pointCoordAndSize.y,pointCoord.y));    
    lowerBound.addLocal(new Vec2(0.2,0.2));
    upperBound.subLocal(new Vec2(0.2,0.2));
    
    AABB aabb = new AABB();
    aabb.lowerBound.set(lowerBound);
    aabb.upperBound.set(upperBound);
    Query callback = new Query();
    box2d.world.queryAABB(callback, aabb);
     //println(callback.Grounds.size());
     assert(callback.Grounds.size()>4);
     float MinY = iScreenHeight; float FirstX = 0; float SizeY = 0;
    for (int i=0;i<callback.Grounds.size();i++){
      LGround PushedGround = callback.Grounds.get(i);
      if(PushedGround.getPosition().y < MinY){
        MinY = PushedGround.getPosition().y;
        FirstX = PushedGround.getPosition().x;
        SizeY = PushedGround.getSize().y;
      }
      PushedGround.setPosition(new Vec2(PushedGround.getPosition().x + PushedGround.getSize().x, PushedGround.getPosition().y ));
    } 
    /*
    float MinY = Y;
    float FirstX = X;
    float SizeY = iPixDefaultSize;
    */
    for(int i =0;i< floor(WormLength/2.f)+1;i++){
      LWormPart newPart = new LWormPart((int)FirstX, (int)(MinY + i*2*SizeY));
      Parts.add(newPart);
    }
    

      arBody.addAll(Parts);
      
    for(int i =0;i< (Parts.size() - 1);i++){
      LWormPart Part1 = Parts.get(i);
      LWormPart Part2 = Parts.get(i+1);
    DistanceJointDef djd = new DistanceJointDef();
    // Connection between previous particle and this one
    djd.bodyA = Part1.PhBody;
    djd.bodyB = Part2.PhBody;
    // Equilibrium length
    djd.length = box2d.scalarPixelsToWorld(SizeY*2);
    
    // These properties affect how springy the joint is 
    djd.frequencyHz = 30;  // Try a value less than 5 (0 for no elasticity)
    djd.dampingRatio = 0.5; // Ranges between 0 and 1
    djd.collideConnected = false;
    
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
    Part1.BackJoint = dj;
    Joints.add(dj);
    }
    
    for(int i =1;i< Parts.size();i++){
          Parts.get(i).setUnStable();
      //newPart.setUnStable();
    }
    Parts.get(Parts.size()-1).Head = Parts.get(0);
    Parts.get(0).setStable();

    
    
  }
  
  
    void ApplyForce(){
/*
      float dS = Parts.get(2).getPosition().y - Parts.get(0).getPosition().y ;
      if(dS >= 4*iPixDefaultSize && Pull){
        dF=-0.02;    Pull = false;
      }
      else if (dS <= 2*iPixDefaultSize && !Pull)
      {
        dF=0.02;  Pull = true;      
      }
              for(int i =0;i<Joints.size();i++){
          Joints.get(i).setLength(Joints.get(i).getLength()+ dF); 
        }   
    Parts.get(0).PhBody.applyForceToCenter(new Vec2(0,0.5));
    */    

    }
    
}

