FROM node:22-bookworm-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
    bash \
    curl \
    wget \
    ca-certificates \
    unzip \
    iproute2 \
    iputils-ping \
    net-tools \
    procps \
    dnsutils \
    jq \
    && rm -rf /var/lib/apt/lists/*

COPY package.json ./

RUN npm install --omit=dev

COPY index.js .
COPY start.sh .

RUN chmod +x /app/start.sh

ENV NODE_ENV=production

EXPOSE 8080

CMD ["node", "index.js"]