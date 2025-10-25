#!/bin/bash

echo "╔════════════════════════════════════════╗"
echo "║   CODEFONDH VNC SERVER LAUNCHER        ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Check if dependencies are installed
if ! command -v vncserver &> /dev/null; then
    echo "⚠️  VNC Server not found!"
    echo "📦 Running setup script..."
    chmod +x setup.sh
    ./setup.sh
    
    if [ $? -ne 0 ]; then
        echo "❌ Setup failed. Please check the errors above."
        exit 1
    fi
fi

# Create VNC directory
mkdir -p ~/.vnc

# Set VNC password
echo "🔐 Setting up VNC password..."
echo "codespace" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Kill existing VNC sessions
echo "🧹 Cleaning up any existing VNC sessions..."
vncserver -kill :1 2>/dev/null || true
sleep 2

# Start VNC server with optimized settings
echo "🚀 Launching VNC Server..."
vncserver :1 -geometry 1920x1080 -depth 24 -localhost no

# Wait for VNC to start
sleep 3

# Check if VNC started successfully
if ! pgrep -x "Xvnc" > /dev/null; then
    echo "❌ Failed to start VNC server. Check logs:"
    cat ~/.vnc/*.log
    exit 1
fi

# Display connection information
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            ✅ VNC SERVER RUNNING SUCCESSFULLY              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📡 CONNECTION DETAILS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -n "$CODESPACE_NAME" ]; then
    PUBLIC_URL="${CODESPACE_NAME}-5901.app.github.dev"
    echo "🌐 Public URL: https://${PUBLIC_URL}"
    echo "🔌 VNC Address: ${PUBLIC_URL}:5901"
    echo "📍 Alternative: ${PUBLIC_URL}::5901"
else
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    echo "🔌 VNC Address: ${LOCAL_IP}:5901"
    echo "📍 Localhost: localhost:5901"
fi

echo "🔑 Password: codespace"
echo "🖥️  Display: :1"
echo "📏 Resolution: 1920x1080"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 RECOMMENDED VNC CLIENTS:"
echo "  • RealVNC Viewer → https://www.realvnc.com/download/viewer/"
echo "  • TigerVNC → https://tigervnc.org/"
echo "  • Remmina (Linux) → sudo apt install remmina"
echo ""
echo "⚙️  USEFUL COMMANDS:"
echo "  • Stop VNC: vncserver -kill :1"
echo "  • Change password: vncpasswd"
echo "  • View logs: cat ~/.vnc/*.log"
echo ""
echo "💡 Press Ctrl+C to stop monitoring (VNC will keep running)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Monitor VNC logs
tail -f ~/.vnc/*.log
