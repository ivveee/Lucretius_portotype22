class LWood extends LBasicBody {
    //float stability;
LWood(int pX, int pY){
      rotter = MaxRotter;
    //stability = 50000;//random(500,1500);
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    //bd.linearDamping = 0.1f;
    PhBody = box2d.createBody(bd);
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.density = 1.1f;
    fixtureDef.friction = 10.0f;
    fixtureDef.filter.categoryBits = 0x0002;
    fixtureDef.filter.maskBits = 0x0004;
    CreateBody(bd,fixtureDef,pX,pY);
    PhBody.setUserData(this);
    if (stability>0)
            PhBody.setActive(false);
}

void Display(){
    noStroke();
    fill(color(defaultcolor));
    Vec2 vecPosition = getPosition();
    Vec2 vecSize = getSize();
    rect(vecPosition.x ,vecPosition.y,vecSize.x,vecSize.y);
}


  void ApplyForce() {
      setForcesFromBodiesAffect();
  }
  
}
