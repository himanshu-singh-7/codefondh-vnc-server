#!/bin/bash

echo "╔═══════════════════════════════════════════════╗"
echo "║   CODEFONDH VNC SERVER INSTALLATION           ║"
echo "║   This may take 5-10 minutes on first run    ║"
echo "╚═══════════════════════════════════════════════╝"
echo ""

# Update system
echo "📦 [1/5] Updating package lists..."
sudo apt-get update -qq

if [ $? -ne 0 ]; then
    echo "❌ Failed to update package lists"
    exit 1
fi

# Install XFCE Desktop Environment
echo "🖥️  [2/5] Installing XFCE Desktop Environment..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "❌ Failed to install XFCE"
    exit 1
fi

# Install VNC Server
echo "🔧 [3/5] Installing TigerVNC Server..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    tigervnc-standalone-server \
    tigervnc-common \
    > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "❌ Failed to install VNC server"
    exit 1
fi

# Install essential applications
echo "🌐 [4/5] Installing Firefox and essential tools..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    firefox-esr \
    dbus-x11 \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    vim \
    nano \
    git \
    curl \
    wget \
    python3 \
    python3-pip \
    python3-numpy \
    > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "⚠️  Warning: Some optional packages failed to install"
fi

# Install websockify for web VNC clients
echo "🌐 [4.5/5] Installing websockify for web browser access..."
sudo pip3 install websockify numpy -q 2>/dev/null || echo "⚠️  Websockify install skipped"

# Configure VNC startup script
echo "⚙️  [5/5] Configuring VNC environment..."
mkdir -p ~/.vnc

cat > ~/.vnc/xstartup << 'XSTARTUP_EOF'
#!/bin/bash

# Unset session manager variables
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

# Set environment variables
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="XFCE"
export XDG_SESSION_TYPE="x11"
export XDG_SESSION_DESKTOP="xfce"

# Start D-Bus
if [ -x /usr/bin/dbus-launch ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Start XFCE desktop
exec startxfce4
XSTARTUP_EOF

chmod +x ~/.vnc/xstartup

# Clean up
echo "🧹 Cleaning up..."
sudo apt-get autoremove -y -qq > /dev/null 2>&1
sudo apt-get clean -qq > /dev/null 2>&1

echo ""
echo "╔═══════════════════════════════════════════════╗"
echo "║      ✅ INSTALLATION COMPLETED SUCCESSFULLY   ║"
echo "╚═══════════════════════════════════════════════╝"
echo ""
echo "🎉 You can now run: ./start.sh"
echo ""
