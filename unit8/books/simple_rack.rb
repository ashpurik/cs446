#!/usr/bin/ruby

require 'rack'
require 'csv'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
		@time = Time.now
    @books = get_books
	end

  def get_books
    books = []
    i=0
    CSV.foreach("books.csv") do |row|
      row << i
      books << row
      i += 1
    end
    return books
  end

	def call(env)
    # create request and response objects
		request = Rack::Request.new(env)
		response = Rack::Response.new
    # include the header
		File.open("header.html", "r") { |head| response.write(head.read) }
		case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/form.*/
        # serve up book sorting form
        render_form(request, response)
      when /\/list.*/
        # serve up list of books response
        render_list(request, response)
      when /\/crazy.*/
        # serve up the form
        render_crazy(request, response)
      when /\/goofy.*/
        # serve up a list response
        render_goofy(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
      end	# end case

      # include the footer
      File.open("footer.html", "r") { |foot| response.write(foot.read) }

      response.finish
    end

  def render_form(request, response)
    File.open("form.html", "r") { |form| response.write(form.read) }
  end

  def apply_sort(sort) 
    case sort
      when "Title"
        @books.sort! { |x,y| x[0] <=> y[0] }
      when "Author"
        @books.sort! { |x,y| x[1] <=> y[1] }
      when "Language"
        @books.sort! { |x,y| x[2] <=> y[2] }
      when "Year"
        @books.sort! { |x,y| x[3] <=> y[3] }
    end
  end

  def render_list(request, response)
    sort = request.GET["sort_type"] 
    apply_sort(sort)
    response.write("<h2>Sorted by #{sort}</h2><br>")
    response.write("<table>")
    response.write("<tr>")
    response.write("<th>Rank</th>")
    response.write("<th>Title</th>")
    response.write("<th>Author</th>")
    response.write("<th>Language</th>")
    response.write("<th>Year</th>")
    response.write("<th>Copies</th>")
    response.write("</tr>")
    @books.each do |book|
      response.write("<tr>")
      response.write("<td>#{book[5]}</td>")
      response.write("<td>#{book[0]}</td>")
      response.write("<td>#{book[1]}</td>")
      response.write("<td>#{book[2]}</td>")
      response.write("<td>#{book[3]}</td>")
      response.write("<td>#{book[4]}</td>")
      response.write("</tr>")
    end
    response.write("</table>")
  end

  # try http://localhost:8080/crazy
	def render_crazy(req, response)
		response.write("This is just crazy! #{@time}")
	end

  # try http://localhost:8080/goofy?name=Jezebel
	def render_goofy(req, response)
		whoIsGoofy = req.GET["name"]
		response.write( "<h2>Proclamation</h2>\n" )
    response.write("<p>#{whoIsGoofy} is goofy!")
	end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
