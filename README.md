# 🏠 Home Server - Docker Services

This repository manages a collection of self-hosted services running on a single Proxmox node. These services provide local media streaming, DNS filtering, AI tools, cloud storage, and more.

## 🌐 Network Overview
 - **Access**: Local network (`192.168.0.1`)
 - **Remote Access**: Secured using Tailscale, no ports exposed to the public internet.
 - **No Reverse Proxy**: All services are accessed using re-written hostnames thru AdGuard Home (e.g., `service.home.lan`).

<!-- Not up-to-date -->
<!-- ![My home network schema](static/network-schema.svg) -->

## 📦 Services Overview

### 📡 AdGuard Home
 - **Purpose**: DNS-based ad blocker and privacy protection.
 - **UI**: https://adguard.home.lan

### 🎥 Jellyfin
 - **Purpose**: Media server for streaming local content.
 - **UI**: https://jellyfin.home.lan
 - **Mounts**: Movies, Shows
 - **GPU Support**: ~~Yes (via NVIDIA_VISIBLE_DEVICES)~~ I did not manage to pass thru the GPU to the container, so currently no hardware acceleration.

### 🎥 Sonarr
  - **Purpose**: Automated TV show downloader and organizer.
  - **UI**: https://sonarr.home.lan
  - **Mounts**: Shows

### 🎥 Radarr
 - **Purpose**: Automated movie downloader and organizer.
 - **UI**: https://radarr.home.lan
 - **Mounts**: Movies

### 🎥 Bazarr
  - **Purpose**: Subtitle management for Sonarr and Radarr.
  - **UI**: https://bazarr.home.lan
  - **Mounts**: Shows, Movies
  - **Dependencies**: Sonarr, Radarr
  - **Language**: French, English

### 🎥 Jackett
  - **Purpose**: Proxy server for torrent indexers.
  - **UI**: https://jackaett.home.lan

### 🎥 Prowlarr
  - **Purpose**: Indexer manager for Sonarr and Radarr.
  - **UI**: https://prowlarr.home.lan

### Watcharr
 - **Purpose**: Rate and track watched movies and TV shows.
 - **UI**: https://watcharr.home.lan

### 🎥 Jellyseerr
  - **Purpose**: Movie & TV show request manager for Jellyfin.
  - **UI**: https://jellyseerr.home.lan
  - **Dependencies**: Jellyfin, Sonarr, Radarr

### 🧲 Transmission (via VPN)
 - **Purpose**: Torrent client routed through a VPN container (Surfshark with WireGuard).
 - **UI**: https://transmission.home.lan
 - **Network Mode**: Shares network with vpn container.

### 🛡️ VPN (gluetun)
 - **Purpose**: Provides secure VPN tunnel for torrent traffic using WireGuard.
 - **Service Provider**: Surfshark
 - **Exposed Port**: 8083 (Transmission UI proxy)

### 🔐 Vaultwarden
 - **Purpose**: Self-hosted Bitwarden-compatible password manager.
 - **UI**: https://vaultwarden.home.lan

### ☁️ Nextcloud AIO
 - **Purpose**: All-in-One Nextcloud instance for file sync, sharing, and collaboration.
 - **UI**: https://nextcloud.paillaugue.fr

### 🖼️ Immich
 - **Purpose**: Photo and video management (Google Photos alternative).
 - **UI**: https://immich.home.lan
 - **Dependencies**: Redis, PostgreSQL, Machine Learning container
 - **ML Hardware Acceleration**: Enabled via immich-machine-learning:cuda

### 🤖 Open WebUI + Ollama
 - **Purpose**: ChatGPT-like LLM UI backed by Ollama.
 - **UI**: https://openwebui.home.lan
 - **Ollama Port**: 11434 (model serving)

### 🔍 Fourget
 - **Purpose**: Lightweight search engine frontend.
 - **UI**: https://search.home.lan

### 🧭 Glance
 - **Purpose**: Dashboard to visualize and access all services from one place.
 - **UI**: https://homepage.home.lan

### My speed
 - **Purpose**: Network speed test and monitoring.
 - **UI**: https://my-speed.home.lan

### Libre-translate
 - **Purpose**: Self-hosted translation API and UI.
 - **UI**: https://translate.home.lan

### NGINX proxy manager
 - **Purpose**: Manage NGINX reverse proxy with a simple UI.
 - **UI**: https://proxy-manager.home.lan/

### Navidrome
 - **Purpose**: Self-hosted music server and streamer.
 - **UI**: https://navidrome.home.lan/

### Gitea
 - **Purpose**: Self-hosted Git service.
 - **UI**: https://gitea.home.lan/

### NTFY
 - **Purpose**: Simple notification service.
 - **UI**: http://ntfy.home.lan/

### Wikipedia
 - **Purpose**: Self-hosted offline Wikipedia instance (thru kiwix serve).
 - **UI**: https://wikipedia.home.lan/


## 🔐 Remote Access via Tailscale
**Tailscale** is used to securely connect to the home network from outside and installed direclty on the router, allowing full access to LAN devices.

## 🗂️ Media Storage
 - `/mnt/hdd/` (2TB) is only used as a backup disk for some of the service's backup folder.
 - `/mnt/hdd2/` (4TB) is used for Jellyfin content (Movies, Shows, ...), Immich uploads, and any other storage.

## 🧭 Dashboard (Glance)
![My glance dashboard](static/Glance_homepage.png)
 - Glance provides a unified overview of all services with health indicators.

## 📎 Additional Notes
 - Transmission is routed through a Surfshark WireGuard VPN via gluetun.
 - Vaultwarden is only accessible within the LAN or via Tailscale for enhanced security.
