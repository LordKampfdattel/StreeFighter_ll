class TextureManager {
  private class Texture {
    String filename;
    PImage texture;
    
    Texture() {
      filename = new String();
    }
  }
  
  private ArrayList<Texture> textures;
  
  public TextureManager() {
    textures = new ArrayList<Texture>();
  }
  
  public PImage get(String filename) {
    for(int i = 0; i < textures.size(); i++) {
      if(textures.get(i).filename.equals(filename)) {
        return textures.get(i).texture;
      }
    }
    
    Texture texture = new Texture();
    texture.filename = filename;
    texture.texture = loadImage(filename);
    
    if(texture.texture != null) {
      textures.add(texture);
      return texture.texture;
    }
    else {
      return null;
    }
  }
}