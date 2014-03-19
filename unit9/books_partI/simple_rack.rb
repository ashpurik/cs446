#!/usr/bin/ruby

require 'rack'
require 'csv'
require 'rack'
require 'erb'
require 'sqlite3'

class SimpleApp
  def initialize()
    # can set up variables that will be needed later
		@time = Time.now
    @db = SQLite3::Database.new("books.sqlite3.db")
    @books = @db.execute("SELECT * FROM books")
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
    response.write(ERB.new(File.read("form.html.erb")).result(binding))
  end

  def apply_sort(sort) 
    case sort
      when "Title"
        @books = @db.execute("SELECT * FROM books ORDER BY title")
      when "Author"
        @books = @db.execute("SELECT * FROM books ORDER BY author")
      when "Language"
        @books = @db.execute("SELECT * FROM books ORDER BY language")
      when "Year"
        @books = @db.execute("SELECT * FROM books ORDER BY published")
      when "Rank"
        @books = @db.execute("SELECT * FROM books ORDER BY id")
    end
  end

  def render_list(request, response)
    sort = request.GET["sort_type"] 
    apply_sort(sort)
    response.write(ERB.new(File.read("list.html.erb")).result(binding))
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
