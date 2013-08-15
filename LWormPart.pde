
class LWormPart extends LBasicBody{
  
  DistanceJoint BackJoint;
  boolean stable = false;
  LWormPart Head;
  
    LWormPart(int pX, int pY) {
     MaxRotter = 5.f;
    rotter = MaxRotter;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    //bd.linearDamping = 0.1f;
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.density = 0.1f;
    fixtureDef.friction = 0f;
    fixtureDef.filter.categoryBits = 0x0002;
    fixtureDef.filter.maskBits = 0x0006;

    bd.fixedRotation = true;
    bd.position.set(box2d.coordPixelsToWorld(pX+iPixDefaultHalfSize,pY+iPixDefaultHalfSize));
    PhBody = box2d.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(iPixDefaultHalfSize);
    fixtureDef.shape = cs;
    
    MassData md = new MassData();
    md.mass = 1;
    md.center.setZero();
    PhBody.createFixture(fixtureDef);
    PhBody.setMassData(md);
    PhBody.setUserData(this);
  }
  
  Vec2 getPosition() {
    Fixture fd = PhBody.getFixtureList();
    Vec2 g = box2d.coordWorldToPixels(PhBody.getPosition());
    Vec2 ret = g.sub(getSize());
    return ret;
  }
  
    Vec2 getSize() {
    Fixture fd = PhBody.getFixtureList();
    CircleShape thisSahpe =  (CircleShape) fd.getShape(); 
    float r = box2d.scalarWorldToPixels(thisSahpe.getRadius());
    return new Vec2(r, r);
  }
  
  
  
    void Display(){
    noStroke();
    fill(color(defaultcolor));
    Vec2 vecPosition = getPosition();
    Vec2 vecSize = getSize();
    //ellipse(vecPosition.x,vecPosition.y,vecSize.x*2,vecSize.y*2);
    //if(stable)
      rect(vecPosition.x,vecPosition.y,iPixDefaultSize,iPixDefaultSize);
    //else
    //  rect(vecPosition.x-1,vecPosition.y-2,iPixDefaultSize,iPixDefaultSize);
}


    void ApplyForce()
    {
           PhBody.applyForceToCenter(new Vec2(0,-1));

      if (BackJoint == null) return;      
      float CurrentJointLength = BackJoint.getLength();
      LWormPart wp = (LWormPart) BackJoint.getBodyB().getUserData();
      
      if(stable && !wp.stable){
        if(box2d.scalarWorldToPixels(CurrentJointLength) >= getSize().x * 2)
          BackJoint.setLength(CurrentJointLength - 0.05);
        else {
          wp.setStable();
        }
      }
      if(!stable && wp.stable){
         if(box2d.scalarWorldToPixels(CurrentJointLength) <= getSize().x * 5)
          BackJoint.setLength(CurrentJointLength + 0.05);
        else {
          setStable();
          wp.setUnStable();
        }     
    }
    

    
    
    }
    
    void setStable(){
      Fixture fd = PhBody.getFixtureList();
      //CircleShape thisSahpe =  (CircleShape) fd.getShape();
      PhBody.destroyFixture(fd);
          FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.density = 0.1f;
    fixtureDef.friction = 10.f;
    fixtureDef.filter.categoryBits = 0x0002;
    fixtureDef.filter.maskBits = 0x0006;
        CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(iPixDefaultHalfSize);
    fixtureDef.shape = cs;
      PhBody.createFixture(fixtureDef);
      //PhBody.friction = 10f;
      stable = true;
      if (BackJoint == null) Head.setUnStable();     
    }
    
   void setUnStable(){
       Fixture fd = PhBody.getFixtureList();
      //CircleShape thisSahpe =  (CircleShape) fd.getShape();
      PhBody.destroyFixture(fd);
          FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.density = 0.1f;
    fixtureDef.friction = 0.1f;
    fixtureDef.filter.categoryBits = 0x0002;
    fixtureDef.filter.maskBits = 0x0006;
        CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(iPixDefaultHalfSize);
    fixtureDef.shape = cs;
      PhBody.createFixture(fixtureDef);
      stable = false;
    }
}
