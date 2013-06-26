

module ALLelements
    DOM_Elements = [ 'form', 'input', 'textarea', 'div', 'frame', 'span',
                     'label', 'select', 'option',
                     'body', 'tbody',
                     'img', 'a',
                     'h1', 'h2', 'h3',
                     'br', 'p',
                     'button',
                     'ul', 'li', 'table', 'tr', 'td',
                     'dl', 'dt', 'dd', 'thead', 'th', 'dt', 'caption',
                     'strong', 'hr'
                   ]


     def ele_attrs(element)

     end

     def dump_sub(element)
        
     end

     def all_elements()
         DOM_Elements.each do |ele|
            method = "#{ele}s".to_sym
            begin
                arr = @pg.send(method)
                if arr.length > 1
                    dump_sub(arr[0])
                end
                puts "Tag : #{ele} -- Instances: #{arr.length}"
            rescue => err
                puts "error with tag: #{ele}"
            end
         end
     end
end
