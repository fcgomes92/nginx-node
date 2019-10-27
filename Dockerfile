FROM nginx:latest
EXPOSE 80
EXPOSE 3000

RUN mkdir -p /data/pm2
RUN mkdir -p /entrypoint

# Create the app folder 
RUN mkdir -p /app/node_modules

# Update the system
RUN apt-get update -y && apt-get upgrade -y

# Add node source 
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash ./nodesource_setup.sh && rm /nodesource_setup.sh

# Install dependencies
RUN apt-get install curl nodejs build-essential make -y
RUN npm install -g yarn pm2@latest

WORKDIR /app

# Create the nginx config
COPY ./container/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./container/nginx/nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

# Install the app dependencies
COPY package.json ./
RUN yarn install --no-cache --production

COPY . .

ENV PM2_HOME=/data/pm2

COPY ./container/Makefile /entrypoint/Makefile

ENTRYPOINT [ "make", "-f", "/entrypoint/Makefile" ]

CMD [ "start" ]