/*
 * This class is a tool to easly fire events to mouse handlers. 
 * Processing way of running do not allow a simple mouse event management. 
 * Hence, this class allow the user to register any mouse event handler implementation 
 * so the simple update() method of the MouseHandler can fire mouse events to them.
 * How to use : 
 *    -create an instance of a MouseHandler. 
 *    -register your mouse event handlers to this instance.
 *    -call the update method in the main draw() method.
 */
public class MouseHandler{
  
  /*
   * True when the mouse is pressed.
   */
  private boolean pressed;
  
  /*
   * True when something is drag.
   */
  private boolean dragging;
  /*
   * True when the mouse is released.
   */
  private boolean released;
  
  /*
   * Mouse event handlers registred to the MouseHandler.
   */
  private ArrayList<MouseEventHandler> mouseEventHandlers;
  
  /*
   * Creates a ready to use MouseHandler with no mouseEventHandlers.
   */
  public MouseHandler(ArrayList<MouseEventHandler> newList) {
    this.pressed = false;
    this.dragging = false;
    this.released = false;
    this.mouseEventHandlers = newList;
    
  }
  
  /*
   * Updates its state by looking at isMousePressed. 
   * Fire detected events (click/drag/release) to the registred mouse event handlers. 
   */
  public void update(boolean isMousePressed, Position p) {
    if (isMousePressed) {
      if (this.pressed && !this.dragging) this.dragging = true;
      else if (!this.pressed) this.pressed = true;
    } else {
      if (this.released) this.released = false;
      else if(this.pressed) {
        this.released = true;
        this.pressed = false;
        this.dragging = false;
      }
    }
    
    this.fireMouseState(p);
  }
  
  /*
   * Registers a new MouseEventHandler to the list of objects managed.
   */
  public void registerDragHandler(MouseEventHandler dh) {
    this.mouseEventHandlers.add(dh);
  }
  
  /*
   * Return true if the state is mouse pressed.
   */
  public boolean getMousePressed() { return this.pressed;}
  /*
   * Return true if the state is mouse dragging.
   */
  public boolean getMouseDragging() { return this.dragging;}
  /*
   * Return true if the state is mouse released.
   */
  public boolean getMouseReleased() { return this.released;}
  
  /*
   * Fire a detected event to the registered MouseEventHandlers.
   */
  private void fireMouseState(Position mousePosition){
    if (this.dragging){
      for (MouseEventHandler d : this.mouseEventHandlers){
        d.handleDrag(mousePosition);
      }
    } else if (this.pressed) {
      for (MouseEventHandler d : this.mouseEventHandlers){
      d.handleClick(mousePosition);
      }
    }else if (this.released) {
      for (MouseEventHandler d : this.mouseEventHandlers){
      d.handleRelease(mousePosition);
      }
    }
  }
  
}
