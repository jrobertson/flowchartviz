#!/usr/bin/env ruby

# file: flowchartviz.rb

require 'line-tree'
require 'pxgraphviz'



class Flowchartviz
  
  def initialize(s)
        
    plaintext = scan(LineTree.new(s).to_a).flatten.compact.join("\n")

raw_px=<<EOF
<?polyrex schema='items[direction]/item[label, connection, shape]' delimiter =' # '?>
direction: TB

EOF

    @pxg = PxGraphViz.new(raw_px + plaintext)
 
  end
  
  def export(file='gvml.xml')
    File.write file, @pxg.to_doc.xml(pretty: true)    
  end
  
  alias export_as export
  
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
        x[0] << ' # ' + (b ? :yes : :no).to_s
      end

      scan x[1..-1],j+k, b if x.length > 1
      x[0].prepend '  ' * (j + i) if x[0]
      x
    end

  end
    
end


