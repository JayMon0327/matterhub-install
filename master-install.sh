#!/usr/bin/env bash
set -euo pipefail

echo "🚀 최상위 설치 스크립트 시작"

# ──────────────────────────────────────────────
# 1) matterhub-platform 설치
echo "📦 matterhub-platform 클론 및 설치"
cd /home/hyodol/Desktop
git clone https://github.com/JayMon0327/matterhub-platform.git
cd matterhub-platform
echo "tech8123" | sudo -S chmod +x ./scripts/install.sh
sudo ./scripts/install.sh

# ──────────────────────────────────────────────
# 2) Flask 서버 클론 및 설정
echo "📦 Flask 서버 클론 및 의존성 설치"
cd /home/hyodol/Desktop
mkdir -p matterhub
cd matterhub
git init
git remote add origin https://github.com/nano-2-ly/whatsmatter-hub-flask-server.git
git pull origin master
sleep 3

# 패키지 설치
sudo apt update
sudo apt install -y python3-pip
sudo python3 -m pip install -r requirements.txt

# ──────────────────────────────────────────────
# 3) systemd 서비스 등록
echo "🔧 systemd 서비스 등록"
sudo cp device_config/matterhub.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable matterhub.service
sudo systemctl restart matterhub.service

# ──────────────────────────────────────────────
# ✅ 완료
echo "🎉 전체 설치 완료!"
echo "🔍 Flask 서버 상태 확인: sudo systemctl status matterhub.service"
echo "🌐 Home Assistant 접속:  http://<Jetson_IP>:8123"
