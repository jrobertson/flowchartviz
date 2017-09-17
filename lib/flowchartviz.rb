#!/usr/bin/env ruby

# file: flowchartviz.rb

require 'line-tree'
require 'pxgraphviz'


class Flowchartviz < PxGraphViz
  
  
  def initialize(s,truthlabels: %i(yes no), style: default_stylesheet(), 
                 delimiter: ' # ')        
    
    @true, @false = truthlabels
    
    if s =~ /<?flowchartviz / then
      
      raw_fc = s.clone
      s2 = raw_fc.slice!(/<\?flowchartviz [^>]*\?>/)
      
      if s2 then
        
        attributes = %w(delimiter id).inject({}) do |r, keyword|
          found = s2[/(?<=#{keyword}=['"])[^'"]+/]
          found ? r.merge(keyword.to_sym => found) : r
        end
        
      end
      
      h = {delimiter: delimiter }.merge attributes || {}
      s = raw_fc

      delimiter = h[:delimiter]

    end    
    
    plaintext = scan(LineTree.new(s).to_a).flatten.compact.join("\n")
    
    schema = 'items[direction]/item[label, url, connection, shape]'    

raw_doc=<<EOF
<?polyrex schema='#{schema}' delimiter='#{delimiter}'?>
direction: TB
#{plaintext}
EOF

    super(raw_doc, style: style)
 
  end
      
  
  private
  
  def scan(a, i=0, b=true)

    k = 0

    a.map.with_index do |x,j|
      
      end_fields = ''

      case x[0]
      when /^if */
        k+=1
        b = true
        x[0].gsub!(/(?:^if | then$)/,'') 
        end_fields = ' #  # diamond' 
      when /^else */
        x[0] = nil
        k -= 1
        b = false
      when /^end */
        x[0] = nil
      else
        k = 1
        end_fields = ' # ' + (b ? @true : @false).to_s unless b.nil?
        b = nil
      end

      if x[0] and end_fields.length > 0 then
        x[0] << ' # ' unless x[0] =~ /#/
        x[0] << end_fields
      end

      scan x[1..-1],j+k, b if x.length > 1
      x[0].prepend '  ' * (j + i) if x[0]
      x
    end

  end
  
  def default_stylesheet()

<<STYLE
  node { 
    color: #0ae; 
    fillcolor: #fff;
    fontcolor: #061; 
    fontname: 'Trebuchet MS';
    fontsize: 8; 
    margin: 0.07;
    penwidth: 1; 
    style: filled;
    shape: box
  }
  
  a node {
    color: #0011ee;   
  }

  edge {
    arrowsize: 0.5;
    color: #999999; 
    fontcolor: #444444; 
    fontname: Verdana; 
    fontsize: 8; 
    dir: forward;
    weight: 1;
  }
STYLE

  end   
    
end