using Genie
using Genie.Router
using Genie.Renderer.Html
using SQLite
using DataFrames

# 1. Initialize SQLite Database
if !isdir("db")
    mkdir("db")
end

db = SQLite.DB("db/rectopress.sqlite")

# Create a projects table if it doesn't exist
SQLite.execute(db, """
CREATE TABLE IF NOT EXISTS projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    tagline TEXT,
    client_type TEXT,
    description TEXT,
    link TEXT
)
""")

# Seed mock projects ONLY if the database is empty
results = DataFrame(SQLite.DBInterface.execute(db, "SELECT COUNT(*) as count FROM projects"))
if results[1, :count] == 0
    SQLite.execute(db, "INSERT INTO projects (title, tagline, client_type, description, link) VALUES (?, ?, ?, ?, ?)", 
        ("SaaS Startup Launcher", "A highly optimized landing page for rapid tech conversion.", "Startup", "Designed with a modern dark mode aesthetic, micro-animations, and a frictionless signup funnel targeting seed-stage tech companies.", "https://rectopress.com"))
    SQLite.execute(db, "INSERT INTO projects (title, tagline, client_type, description, link) VALUES (?, ?, ?, ?, ?)", 
        ("Apex Industrial Portal", "Robust manufacturing enterprise portal with zero-lag UI.", "Industry", "An industrial machinery showcase portal featuring responsive CAD viewers and robust quote-request forms, built for global manufacturers.", "https://rectopress.com"))
end

# 2. Dynamic Home Page Route
route("/") do
    # Fetch projects from the database
    projects_df = DataFrame(SQLite.DBInterface.execute(db, "SELECT * FROM projects"))
    
    # Read the raw HTML file explicitly
    template = read("app/views/home.jl.html", String)
    
    # Render the template with the database data
    html(template, projects = eachrow(projects_df))
end

# Serve CSS file explicitly
route("/css/style.css") do
    serve_static_file("css/style.css")
end

# The Services Page
route("/services") do
    read("app/views/services.jl.html", String)
end

# The Contact Page
route("/contact") do
    read("app/views/contact.jl.html", String)
end