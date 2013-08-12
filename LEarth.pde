class LEarth extends LBody {
  Vec2 g = new Vec2(0,-9);
  
  Vec2 GetForce(Vec2 vecPoint){
    return g;
    
  }
}

class LDestructor extends LBody {
  Vec2 force = new Vec2();
  Vec2 impulse = new Vec2();  
  
  LDestructor(Vec2 in_force, Vec2 in_impulse){
    force = in_force;
    impulse = in_impulse;
  }
  
  Vec2 GetForce(Vec2 vecPoint){
    Vec2 dist = new Vec2(iScreenWidth/2 - vecPoint.x,  iScreenHeight/2 - vecPoint.y);
    Vec2 norm = new Vec2(iScreenWidth/2 - vecPoint.y,  iScreenHeight/2 - vecPoint.x);
    Vec2 normalizeDist = dist.mul(1.0f/dist.length()*0.2);
    Vec2 normalizeNorm = norm.mul(-1.0f/norm.length());
    Vec2 diff = normalizeNorm.sub(normalizeDist) ;
    Vec2 vecForce = new Vec2(diff.x*3,diff.y*3 );
    return vecForce;
  }
  
  Vec2 GetImpulse(Vec2 vecPoint){
    Vec2 dist = new Vec2(-iScreenWidth/2 + vecPoint.x, - iScreenHeight/2 + vecPoint.y);
    Vec2 normalize = dist.mul(1.0f/dist.length());
    Vec2 vecImpulse = new Vec2(normalize.y*5,normalize.x*5);
    return vecImpulse;
  }
  
}
