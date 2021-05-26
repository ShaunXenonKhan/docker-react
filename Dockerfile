#
# Builder Phase
#

# Specify base image
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#
# Runner Phase
#

# Specify base image
FROM nginx

# Copy files from builder phase to nginx public director
COPY --from=builder /app/build /usr/share/nginx/html