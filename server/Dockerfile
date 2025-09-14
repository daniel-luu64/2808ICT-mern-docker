FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

FROM node:20-alpine
WORKDIR /app
ENV MODE_ENV=production PORT=3000

RUN addgroup -S app && adduser -S app -G app
USER app

COPY --chown=app:app package*.json ./
COPY --from=deps /app/node_modules ./node_modules
COPY --chown=app:app . .

EXPOSE 3000
CMD ["npm", "start"]
