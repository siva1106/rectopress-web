using Genie
using Genie.Router
using Genie.Renderer.Html
using SQLite
using DataFrames

# 1. Initialize SQLite Database (Kept for your Home Page projects only)
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

# Serve CSS file explicitly
route("/css/style.css") do
    serve_static_file("css/style.css")
end

# Serve the Logo explicitly
route("/img/logo.png") do
    serve_static_file("img/logo.png")
end

# Serve the Favicon explicitly
route("/favicon.ico") do
    serve_static_file("img/logo.png")
end

# 2. Page Routes
# The Home Page
route("/") do
    projects_df = DataFrame(SQLite.DBInterface.execute(db, "SELECT * FROM projects"))
    template = read("app/views/home.jl.html", String)
    html(template, projects = eachrow(projects_df))
end

# The Services Page
route("/services") do
    read("app/views/services.jl.html", String)
end

# The Contact Page (GET only) - Reads the embedded Google Form template
route("/contact") do
    read("app/views/contact.jl.html", String)
end