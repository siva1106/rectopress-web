# 1. Use the official Julia environment
FROM julia:latest

# 2. Set the working directory inside the server
WORKDIR /app

# 3. Copy all your website files to the server
COPY . .

# 4. Install the required Julia packages (Genie, SQLite, DataFrames)
RUN julia --project -e 'using Pkg; Pkg.instantiate()'

# 5. The Start Command (Tells Genie to listen to Render's internet port)
CMD julia --project -e 'using Genie; Genie.loadapp(); up(parse(Int, get(ENV, "PORT", "8000")), "0.0.0.0", async=false)'