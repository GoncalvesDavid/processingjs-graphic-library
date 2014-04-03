/*
 * Interface that defines the services provided by an object capable of handling mouse events. 
 */
public interface MouseEventHandler {
  /*
   * Handles the mouse click event.
   */
  public void handleClick(Position mousePostion);
  /*
   * Handles the mouse release event.
   */
  public void handleRelease(Position mousePostion);
  /*
   * Handles the mouse dragging event.
   */
  public void handleDrag(Position mousePostion);
  
}
