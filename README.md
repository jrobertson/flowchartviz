# Introducing the flowchartviz gem

    require 'flowchartviz' 

    s = "
    if a then
      go left
      keep walking
    else
      go right
      if raining?
        take an umbrella
    end
    "

    fm = Flowchartviz.new(s)
    fm.write '/tmp/flowchart.svg'

See http://www.jamesrobertson.eu/snippets/2017/sep/17/introducing-the-flowchartviz-gem.html

## Resources

* flowchartviz https://rubygems.org/gems/flowchartviz

