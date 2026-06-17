# 1. Use the official Julia environment
FROM julia:latest

# 2. Set the working directory inside the server
WORKDIR /app

# 3. Copy all your website files to the server
COPY . .

# 4. Install the required Julia packages
RUN julia --project -e 'using Pkg; Pkg.instantiate()'

# 5. Start the Genie server
CMD julia --project -e 'using Genie; Genie.loadapp(); up(async=false)'