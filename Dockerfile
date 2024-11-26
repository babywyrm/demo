# Use an outdated base image
FROM node:15

##
##
##

# Set the working directory
WORKDIR /app

# Create a package.json with outdated Node.js dependencies
RUN echo '{
  "name": "test-app",
  "version": "1.0.0",
  "dependencies": {
    "express": "4.17.0",     # Vulnerable: Express 4.17.0 has security issues
    "lodash": "4.17.15",      # Vulnerable: lodash <=4.17.19 has known vulnerabilities
    "request": "2.88.2"       # Vulnerable: request is deprecated
  }
}' > package.json

# Install Node.js dependencies
RUN npm install

# Create a requirements.txt with outdated Python dependencies
RUN echo 'flask==1.0.2' > requirements.txt  # Vulnerable: Flask 1.0.2 has a known security vulnerability

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Create a Gemfile with outdated Ruby dependencies
RUN echo 'source "https://rubygems.org"\n gem "rails", "5.2.3"\n gem "nokogiri", "1.10.1"' > Gemfile  # Vulnerable: Rails 5.2.3 and Nokogiri 1.10.1 have known vulnerabilities

# Install Ruby and Bundler
RUN apt-get install -y ruby-full build-essential

# Install Ruby dependencies
RUN gem install bundler && bundle install

# Expose a port (for testing purposes)
EXPOSE 3000

# Command to run the application (modify as needed)
CMD ["npm", "start"]

