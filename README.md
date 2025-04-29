# 🏠 Home Server - Docker Services

This repository manages a collection of self-hosted services running on a single machine using Docker Compose. These services provide local media streaming, DNS filtering, AI tools, cloud storage, and more.

## 🌐 Network Overview
 - **Access**: Local network (`192.168.0.3`) via `http://192.168.0.3:PORT`
 - **Remote Access**: Secured using Tailscale, no ports exposed to the public internet.
 - **No Reverse Proxy**: All services are accessed using direct IP and port mapping.
 - **Device Location**: Docker services are hosted on debian-laptop.local.

![My home network schema](static/network-schema.svg)

## 📦 Services Overview

### 📡 AdGuard Home
 - **Purpose**: DNS-based ad blocker and privacy protection.
 - **UI**: http://192.168.0.3:8085

### 🎥 Jellyfin
 - **Purpose**: Media server for streaming local content.
 - **UI**: http://192.168.0.3:8080
 - **Mounts**: Movies, Shows
 - **GPU Support**: Yes (via NVIDIA_VISIBLE_DEVICES)

### 🎥 Sonarr
  - **Purpose**: Automated TV show downloader and organizer.
  - **UI**: http://192.168.0.3:8090
  - **Mounts**: Shows

### 🎥 Radarr
 - **Purpose**: Automated movie downloader and organizer.
 - **UI**: http://192.168.0.3:8091
 - **Mounts**: Movies

### 🎥 Bazarr
  - **Purpose**: Subtitle management for Sonarr and Radarr.
  - **UI**: http://192.168.0.3:8092
  - **Mounts**: Shows, Movies
  - **Dependencies**: Sonarr, Radarr
  - **Language**: French, English
  - **Subtitles**: OpenSubtitles

### 🎥 Jackett
  - **Purpose**: Proxy server for torrent indexers.
  - **UI**: http://192.168.0.3:8093

### 🎥 Jellyseerr
  - **Purpose**: Movie & TV show request manager for Jellyfin.
  - **UI**: http://192.168.0.3:8094
  - **Dependencies**: Jellyfin, Sonarr, Radarr

### 🧲 Transmission (via VPN)
 - **Purpose**: Torrent client routed through a VPN container (Surfshark with WireGuard).
 - **UI**: http://192.168.0.3:8083
 - **Network Mode**: Shares network with vpn container.

### 🛡️ VPN (gluetun)
 - **Purpose**: Provides secure VPN tunnel for torrent traffic using WireGuard.
 - **Service Provider**: Surfshark
 - **Exposed Port**: 8083 (Transmission UI proxy)

### 🔐 Vaultwarden
 - **Purpose**: Self-hosted Bitwarden-compatible password manager.
 - **UI**: http://192.168.0.3:8081

### ☁️ Nextcloud AIO
 - **Purpose**: All-in-One Nextcloud instance for file sync, sharing, and collaboration.
 - **UI**: http://nextcloud.paillaugue.fr

### 🖼️ Immich
 - **Purpose**: Photo and video management (Google Photos alternative).
 - **UI**: http://192.168.0.3:8082
 - **Dependencies**: Redis, PostgreSQL (pgvecto-rs), Machine Learning container
 - **ML Hardware Acceleration**: Enabled via immich-machine-learning:cuda

### 🤖 Open WebUI + Ollama
 - **Purpose**: ChatGPT-like LLM UI backed by Ollama.
 - **UI**: http://192.168.0.3:8084
 - **Ollama Port**: 11434 (model serving)

### 🔍 Fourget
 - **Purpose**: Lightweight search engine frontend.
 - **UI**: http://192.168.0.3:8089

### 🧭 Glance
 - **Purpose**: Dashboard to visualize and access all services from one place.
 - **UI**: http://192.168.0.3:8088


## 🔐 Remote Access via Tailscale
 - **Tailscale** is used to securely connect to the home network from outside.
 - Devices on Tailscale can directly access `192.168.0.3:PORT` as if on LAN.
 - No reverse proxy, no port forwarding, and no public exposure is used or required.

## ⚙️ Environment & Config Locations
All services use bind-mounted volumes for persistent storage and configuration. See [docker-compose.yaml](docker-compose.yaml) for exact paths.

Make sure to configure variables in a .env file : [.env.exemple](.env.exemple)

## 🗂️ Media Storage
 - `/mnt/hdd/` 2TB is only used as a backup disk for some of the service's backup folder
 - `/mnt/hdd2/` (4TB) is used for Jellyfin content (Movies, Shows, ...), Immich uploads, and any other storage

## 🧭 Dashboard (Glance)
![My glance dashboard](static/Glance_homepage.png)
 - Glance provides a unified overview of all services with health indicators.
 - Powered by Docker labels (glance.name, glance.url, glance.icon, etc.).

Access: [http://192.168.0.3:8088](http://192.168.0.3:8088)


## 📎 Additional Notes
 - Transmission is routed through a Surfshark WireGuard VPN via gluetun.
 - Vaultwarden is only accessible within the LAN or via Tailscale for enhanced security.
 - No HTTPS is configured since all traffic is either local or encrypted via Tailscale.
