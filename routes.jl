using Genie.Router

# The Home Page
route("/") do
    html("""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recto Press | Web Design</title>
        <style>
            body { font-family: sans-serif; text-align: center; padding: 10%; background: #111; color: #fff; }
            h1 { font-size: 4rem; margin-bottom: 10px; color: #00FF88; }
            p { font-size: 1.5rem; font-style: italic; color: #ccc; }
        </style>
    </head>
    <body>
        <h1>Recto Press</h1>
        <p>"We are always on the front page, setting the standard."</p>
    </body>
    </html>
    """)
end

# The Services Page
route("/services") do
    "<h1>Our Services</h1><p>Web Design for Startups and Industry.</p>"
end