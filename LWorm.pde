class LWorm extends LBody{
  class LWormPart extends LBasicBody{
  
  
  }
  
  int WormLength = 5;
  
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
     println(callback.Grounds.size());
     assert(callback.Grounds.size()>4);
    for (int i=0;i<callback.Grounds.size();i++){
      LGround PushedGround = callback.Grounds.get(i);
      PushedGround.setPosition(new Vec2(PushedGround.getPosition().x + PushedGround.getSize().x, PushedGround.getPosition().y ));
    
    
    
    }
    
    
    
  }
  
  
  
  
  
  
}
