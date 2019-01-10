# Default code, use or delete...
@mod = Sketchup.active_model # Open model
@ent = @mod.entities # All entities in model
@sel = @mod.selection # Current selection
@view = @mod.active_view
@dizi = Array.new(10) {Array.new(10)}

@s = 100.inch
@w = 60.inch
@beta = 0.01

def build_material()
  n = 10
  (0..n-1).each { |i|
    (0..n-1).each { |j|
      pts = []
      pts[0] = [i*@s,j*@s,0]
      pts[1] = [i*@s,j*@s+@w,0]
      pts[2] = [i*@s+@w,j*@s+@w,0]
      pts[3] = [i*@s+@w,j*@s,0]
      entities2 = @ent.add_group
      face = entities2.entities.add_face pts
      face.back_material = [200,(255/(n)*j).round,(255/(n)*i).round]
      face.pushpull -40
      @dizi[i][j]=entities2
  }
    }
end  

def scale_object()
  (0..45).each { |k|
    (0..9).each { |i|
        (0..9).each { |j|
        
          height = Math.cos(@beta*(((i)*(i+k))+((j)*(j+k))))*1.7
          scale_transformation = Geom::Transformation.scaling(1,1,height)
          @dizi[j][i].transformation =scale_transformation
          @dizi[j][i].transform!(scale_transformation)


          }
         # $view.refresh


          }

          sleep 0.08
          @view.refresh
          }
end




build_material()
scale_object()
  
