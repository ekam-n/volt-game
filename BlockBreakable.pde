// block that breaks when you walk on it

class BlockBreakable extends Block {

  BlockBreakable(PVector pos, int wdth, int hght) {

    super(pos, wdth, hght);
  }

  void update(Character c) {



    super.update(c);



    if ( isOn(p1) && p1.pos.y >= pos.y - hght && p1.pos.y <= pos.y + hght ) {

      lv.currLevel.blocks.remove(this);
    }
  }
}
