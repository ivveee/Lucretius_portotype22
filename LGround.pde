class LGround extends LBasicBody {
  
  float finY = iScreenHeight;
  int rotterMass = 0;
  int rotterMassMax = 3;
  Vec2 pusher = new Vec2(0,-1);
     // Vec2 SumVelocity = new Vec2();;
  
  LGround(float pX, float pY) {       
    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;//STATIC;
    FixtureDef fixtureDef = new FixtureDef();
    //fixtureDef.density = 0.0f;
    fixtureDef.friction = 1.0f;
    fixtureDef.filter.categoryBits = 0x0004;  // 0100 I am ground
    fixtureDef.filter.maskBits = 0x0002;  // 0010 I will collide with bodies
    CreateBody(bd,fixtureDef,pX,pY);
    PhBody.setUserData(this);
  }

  void Display() {
    noStroke();
    fill(color(defaultcolor));
    Vec2 vecPosition = getPosition();
    Vec2 vecSize = getSize();
    rect(vecPosition.x, vecPosition.y, vecSize.x, vecSize.y);
 }
  
  void ApplyForce(){
    Vec2 size = getSize();
    Vec2 coord = getPosition();
    Vec2 pointCoordAndSize = box2d.coordPixelsToWorld(coord.add(size));
    Vec2 pointCoord = box2d.coordPixelsToWorld(coord);
    Vec2 lowerBound = new Vec2(min(pointCoordAndSize.x,pointCoord.x), min(pointCoordAndSize.y,pointCoord.y));
    Vec2 upperBound = new Vec2(max(pointCoordAndSize.x,pointCoord.x), max(pointCoordAndSize.y,pointCoord.y));    
    lowerBound.addLocal(new Vec2(0.2,0.2));
    upperBound.subLocal(new Vec2(0.2,0.2));
    
    //println(lowerBound + " " + upperBound);
    AABB aabb = new AABB();
    aabb.lowerBound.set(lowerBound);
    aabb.upperBound.set(upperBound);
    Query callback = new Query();
    box2d.world.queryAABB(callback, aabb);
    Vec2 SumVelocity = new Vec2();
    for (LBody oLForceBody: arBodiesAffect) {
      Vec2 f = oLForceBody.GetImpulse(getPosition()); 
      SumVelocity.addLocal(f);
    }
    
    Vec2 currentPusher = new Vec2(0,0);
    
    /*if(callback.Grounds.size() == 0){
            currentPusher = new Vec2(0, 0);
    }*/
    for (int i=0;i<callback.Grounds.size();i++) {
      LGround PushingGround = callback.Grounds.get(i);
      if (PushingGround!=this && PushingGround.getPosition().y <= getPosition().y 
                                                          && PushingGround.PhBody.getLinearVelocity().y == 0){
        //SumVelocity.addLocal(pusher);
        currentPusher = pusher;
        //finY = PushingGround.getPosition().y + PushingGround.getSize().y;
        break;
      }
    }
    /*if (getPosition().y > finY && PhBody.getLinearVelocity().y != 0) {
      currentPusher = new Vec2(0, 0);
      setPosition(new Vec2(getPosition().x,finY));
    }*/
    SumVelocity.addLocal(currentPusher);
    PhBody.setLinearVelocity(SumVelocity);
  }


  void setPosition(Vec2 NewPos) {
    Vec2 InWorld = box2d.coordPixelsToWorld(NewPos.x + getSize().x/2, NewPos.y + getSize().y/2);
    PhBody.setTransform(InWorld, 0.f);
  }
}

class Query implements QueryCallback {

  ArrayList <LGround> Grounds = new ArrayList <LGround>();

  boolean reportFixture(Fixture A) {
    Body b = A.getBody();
    Object o = b.getUserData();
    if (o == null)return true;
    if (o.getClass() == LGround.class ) {
      Grounds.add((LGround) o);
    }
    return true;
  }
}

