/**
 <form><input type="file" id="file-input"/></form>
 */

MouseHandler mh = null;
Graphic g = null;
DualScrollBar dsb = null;

void setup(){
    size(840,50);
}

void draw(){
  background(25);
  
  if(g==null){
    text("no data test", 20,20);
  } else {
  
    mh.update(mousePressed,new Position(mouseX,mouseY));
    
    g.drawBox();
    g.debug();
    dsb.drawBox();
  
    float iMin = map(dsb.getLeftValue(),0,1000,0,1000);
    float iMax = map(dsb.getRightValue(),0,1000,0,1000);
    
    g.setIndexMinToDisplay(int(iMin));
    g.setIndexMaxToDisplay(int(iMax));
  }
  
}

void sendData(String data) {

  size(840,510);
  g = new Graphic(new Position(20,20), 800, 400, data);
  
  dsb = new DualScrollBar(new Position(20,450),800,40 );
  
  ArrayList<MouseEventHandler> l = new ArrayList<MouseEventHandler>();
  l.add(g);
  l.add(dsb); 
  mh = new MouseHandler(l);
}

void setYUnits(String s){
  g.setYunits(s);  
}
