using Genie
using Genie.Router

# The Home Page
route("/") do
    read("app/views/home.html", String)
end

# Explicitly serve your CSS file with the correct headers
route("/css/style.css") do
    serve_static_file("css/style.css")
end

# The Services Page
route("/services") do
    "<h1>Our Services</h1><p>Web Design for Startups and Industry.</p>"
end