FROM node:20.5.1-alpine3.18

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install

RUN npm ci --omit=dev

COPY . .

EXPOSE 8080

CMD [ "npm", "start"]