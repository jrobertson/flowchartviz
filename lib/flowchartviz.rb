#!/usr/bin/env ruby

# file: flowchartviz.rb

require 'line-tree'
require 'pxgraphviz'


class Flowchartviz
  
  attr_reader :raw_doc
  
  def initialize(s,truthlabels: %i(yes no))        
    
    @true, @false = truthlabels
    
    plaintext = scan(LineTree.new(s).to_a).flatten.compact.join("\n")

@raw_doc=<<EOF
<?polyrex schema='items[direction]/item[label, connection, shape]' delimiter =' # '?>
direction: TB
#{plaintext}
EOF

    @pxg = PxGraphViz.new(@raw_doc)
 
  end
  
  def export(file='gvml.xml')
    File.write file, @pxg.to_doc.xml(pretty: true)    
  end
  
  alias export_as export
  
  def import(s)
    @pxg = PxGraphViz.new(RXFHelper.read(s).first)
  end
  
  def to_png()
    @pxg.to_png
  end  
  
  def to_svg()
    @pxg.to_svg
  end
   
  def write(filename)
    @pxg.write filename
  end
      
  
  private
  
  def scan(a, i=0, b=true)

    k = 0

    a.map.with_index do |x,j|

      case x[0]
      when /^if */
        k+=1
        b = true
        x[0].gsub!(/(?:^if | then$)/,'') << ' #  # diamond' 
      when /^else */
        x[0] = nil
        k -= 1
        b = false
      when /^end */
        x[0] = nil
      else
        k = 1
        x[0] << ' # ' + (b ? @true : @false).to_s unless b.nil?
        b = nil
      end

      scan x[1..-1],j+k, b if x.length > 1
      x[0].prepend '  ' * (j + i) if x[0]
      x
    end

  end
    
end