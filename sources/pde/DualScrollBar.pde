/*
 * Handles a dual scroll bar input/output.
 */
public class DualScrollBar extends Box implements MouseEventHandler{
  
  private Box leftBox;
  private Box rightBox;
  
  
  private boolean isLeftBoxSelected;
  private boolean isRightBoxSelected;
  public DualScrollBar(Position top, int newWidth, int newHeight) {
    super(top, newWidth, newHeight);
    this.isLeftBoxSelected=false;
    this.isRightBoxSelected=false;
    this.leftBox= new Box(top, 10, newHeight);
    this.rightBox= new Box(top.getPositionOffset(newWidth-10,0 ), 10, newHeight);
  }
  
  public void drawBox(){
    super.drawBox();
    fill(100);
    this.leftBox.drawBox();
    this.rightBox.drawBox();
  }
  
  public float getLeftValue(){
    return map( this.leftBox.getLC().getX(), this.getLC().getX() , this.getLC().getX()+this.getWidth(), 0, 100);
  }
  public float getRightValue(){
    return map( this.rightBox.getRC().getX(), this.getLC().getX() , this.getLC().getX()+this.getWidth(), 0, 100);
  }
  
  public void setLeftPosition(Position newP) {
    int x = newP.getX()-this.leftBox.getWidth()/2;
    if (this.contains(newP.getPositionOffset(-this.leftBox.getWidth()/2,0)) && x+this.leftBox.getWidth() < this.rightBox.getLC().getX())
      this.leftBox.setLC(x, this.getLC().getY());
  }
  
  public void setRightPosition(Position newP) {
    int x = newP.getX()- this.rightBox.getWidth()/2;
    if (this.contains(newP.getPositionOffset(this.rightBox.getWidth()/2,0)) && x > this.leftBox.getRC().getX())
      this.rightBox.setLC(x, this.getLC().getY());
  }
 
  
  public boolean isOverLeftBox(Position newP){
    return this.leftBox.contains(newP);
    
  }
  
  public boolean isOverRightBox(Position newP){
    return this.rightBox.contains(newP);
  }
  
  public void handleClick(Position mousePostion){
    if(this.isOverLeftBox(mousePostion)) this.isLeftBoxSelected = true;
    if(this.isOverRightBox(mousePostion)) this.isRightBoxSelected = true;
  }
  public void handleRelease(Position mousePostion){
    this.isRightBoxSelected = false;
    this.isLeftBoxSelected = false;
  }
  public void handleDrag(Position mousePostion){
    if(this.isRightBoxSelected) this.setRightPosition(mousePostion);
    if(this.isLeftBoxSelected) this.setLeftPosition(mousePostion);   
  }
  

  
  
  
  
}
