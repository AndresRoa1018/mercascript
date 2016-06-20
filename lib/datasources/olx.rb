class Olx < Datasource
  PAGES_TO_EXAMINE = 5

  def pepe
   puts "ole"
  end

  def publish(result_product)
    browser = sign_in

    browser.goto('http://www.olx.com.pe/posting')

    browser.element(:css => 'a.icon-material-cat-830').wait_until_present
    browser.element(:css => 'a.icon-material-cat-830').click
    browser.element(css: "[data-id='831']").click

    photos = [
      "/Users/arnoldroa/Downloads/Captura de pantalla 2016-05-30 a las 10.26.42 a.m..png",
      "/Users/arnoldroa/Downloads/Captura de pantalla 2016-05-30 a las 10.20.20 a.m..png",
      "/Users/arnoldroa/Downloads/Captura de pantalla 2016-05-30 a las 10.29.54 a.m..png",
      "/Users/arnoldroa/Downloads/Captura de pantalla 2016-05-31 a las 12.15.00 p.m..png",
      "/Users/arnoldroa/Downloads/Captura de pantalla 2016-05-30 a las 10.17.11 a.m..png",
      "/Users/arnoldroa/Downloads/Captura de pantalla 2016-05-20 a las 9.18.20 a.m..png",
      "/Users/arnoldroa/Downloads/Screenshot 2016-04-08 11.16.15.png"
    ]

    fi = 0
    photos.each do |photo|
      browser.file_field(id: "file#{fi}").set(photo)
      fi += 1
    end

    browser.text_field(name: "title").set(result_product.name)

    browser.textarea(name: "description").set("vendo control 1234567890-")
    browser.text_field(name: "priceW").wait_until_present
    browser.text_field(name: "priceW").set(result_product.price)
    browser.text_field(name: "contactName").set(result_product.nick_seller)
    browser.text_field(name: "email").set(@source_config.login)
    browser.text_field(name: "phone").set("3123765234")

    binding.pry
    browser.button(value: "Publicar").click


  end

  def fetch_results(search)
      mecha = Mechanize.new

      url = "https://www.olx.com#{@source_config.domain}/nf/search/#{search.name}"

      puts url
      
      products = []
      (PAGES_TO_EXAMINE-1).times do |i|
        append_page = i > 0 ? "/-p-#{i+1}" : ''
        result_page = mecha.get("#{url}#{append_page}") 
        products += result_page.search("main.items-list-view ul.items-list li.item").map{|p| p} rescue []
      end
      
      products.each do |result|
        
        product_page = mecha.click result.at("a")

        if product_page.search('.content').empty?
          puts "Ignoring, product probably removed"
          next
        end

        puts " *   #{search.name}  parsing element #{product_page.uri}"
        
        begin
          seller = product_page.at('div.details p.name').try :text
          image_result = result.at('figure.items-image img').try :attr, :src
          #ARREGLAR IMAGES ->>
          
          images = product_page.search('nav.carrousel li a').map {|x| x.try :attr, :href } 
          #product_images = product_page.at("div.product-gallery-container label img").map {|x| x.attr :scr}
          puts "  - found #{images.count} images"           
          # raise "images not found" if image_result.empty?
        rescue => e
          binding.pry
          puts " error obtainin images #{e.message}"
        end
        
         
        
         
        source_id = product_page.uri.to_s.split('-').last rescue product_page.uri

        
        if ResultProduct.exists?({source_id: source_id})
          puts "ya existe #{source_id}"
        else
          rp = ResultProduct.new
          
          begin
            data = JSON.parse(product_page.at('main').attr(:"data-item")) rescue {}
            
            #metas = Hash[product_page.search('meta[itemprop]').map{|m| [m[:itemprop], m[:content]]}]
            rp.search = search
            rp.name = data["title"]
            rp.price = data["price"]["amount"] rescue nil
            rp.currency = map_currency data["price"]["preCurrency"] rescue nil
            rp.url = product_page.uri
           
            
            rp.source = "Olx"
            rp.source_id = source_id
            rp.nick_seller = seller
            rp.description_html = data["description"]                          
            rp.image_url = image_result
            rp.data = data.to_json

            #### = images_show.map{|x|  }
          rescue NoMethodError => e
            binding.pry
            puts "NoMethodError: #{e.message}"
          rescue => e
            binding.pry
            puts "otro error: #{e.message}"
          ensure
            
            rp.save
          end

          images.each do |image|
            rp.photos.create(url: image)
          end

         
        end
      end

  rescue Mechanize::ResponseCodeError => e
    puts e.message
  end



  def sign_in
    url = "http://www.olx.com#{@source_config.domain}/"
    # page = @mecha.get(url)

    # singin = @mecha.click page.at('li.user-action a')
    # form = singin.forms.last

    # form['usernameOrEmail'] = @source_config.login
    # form['password'] = @source_config.password

    # logged_in_page = form.submit

    #  puts "pagina lista"

    #  publish = @mecha.click logged_in_page.at('div.text p a')
    #  @publish = publish
    #  product = ResultProduct.find 1
    #  form_publish = publish.forms.last
    #  form_publish['title'] = product.name
    #  form_publish['contactName'] = "and"
    #  form_publish['email'] = "andsb18@gmail.com"
    #  form_publish['phone']= "12313423"
    #  form_publish['streetAddress'] = "av. chocolate con calle pan"
    #  form_publish['description'] = product.description_html.to_s

    #  #form_publish['images[0]'] = Photo.find (1).url
    #  #form_publish['images[1]'] = Photo.find (2).url
    #  #form_publish['images[2]'] = Photo.find (3).url
    #  #form_publish['images[3]'] = Photo.find (4).url
    #  #form_publish['images[4]'] = Photo.find (5).url
    #  #form_publish['images[5]'] = Photo.find (6).url

    browser = Watir::Browser.new :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
    browser.goto('http://www.olx.com.pe/login')
    browser.text_field(name: "usernameOrEmail").set(@source_config.login)
    browser.text_field(name: "password").set(@source_config.password)
    browser.button(value: "Entrar").click
  
    browser    
  end

  private
    def map_currency(symbol)
      case @source_config.domain
      when ".co"
        "COP"
      when ".pe"
        (symbol == "$") ? "USD" : 'PEN'
      end
    end



end


