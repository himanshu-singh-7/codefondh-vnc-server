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
vncserver :1 -geometry 1920x1080 -depth 24 -localhost no 2>&1 | grep -v "Could not find any render nodes" | grep -v "Failed to initialize DRI3"

# Wait for VNC to start
sleep 5

# Check if VNC started successfully (check for either process name)
VNC_PID=$(pgrep -x "Xtigervnc" || pgrep -x "Xvnc")

if [ -z "$VNC_PID" ]; then
    echo "❌ VNC process not found. Checking logs..."
    tail -20 ~/.vnc/*.log 2>/dev/null || echo "No log files found"
    exit 1
fi

echo "✅ VNC Server process running (PID: $VNC_PID)"
echo ""

# Display connection information
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            ✅ VNC SERVER RUNNING SUCCESSFULLY              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📡 CONNECTION DETAILS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Get connection details
if [ -n "$CODESPACE_NAME" ]; then
    PUBLIC_URL="${CODESPACE_NAME}-5901.app.github.dev"
    echo "🌐 Public URL: https://${PUBLIC_URL}"
    echo "🔌 VNC Address: ${PUBLIC_URL}:5901"
    echo "📍 Alternative: ${PUBLIC_URL}::5901"
    echo ""
    echo "📋 COPY THIS ADDRESS TO YOUR VNC CLIENT:"
    echo "   ${PUBLIC_URL}:5901"
else
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    HOSTNAME=$(hostname)
    echo "🔌 VNC Address: ${LOCAL_IP}:5901"
    echo "🖥️  Hostname: ${HOSTNAME}:5901"
    echo "📍 Localhost: localhost:5901"
    echo ""
    echo "📋 COPY THIS ADDRESS TO YOUR VNC CLIENT:"
    echo "   ${LOCAL_IP}:5901"
fi

echo ""
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
echo "ℹ️  NOTE: Warnings about DRI3, DPMS, systemd are normal in containers"
echo "💡 Press Ctrl+C to stop monitoring (VNC will keep running)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Monitor VNC logs but filter out common warnings
echo "📊 Monitoring VNC logs (showing new activity only)..."
echo ""
tail -f ~/.vnc/*.log 2>/dev/null | grep -v "Could not find any render nodes" | grep -v "Failed to initialize DRI3" | grep -v "Failed to get a systemd proxy"#!/bin/bash

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
vncserver :1 -geometry 1920x1080 -depth 24 -localhost no 2>&1 | grep -v "Could not find any render nodes" | grep -v "Failed to initialize DRI3"

# Wait for VNC to start
sleep 5

# Check if VNC started successfully (check for either process name)
VNC_PID=$(pgrep -x "Xtigervnc" || pgrep -x "Xvnc")

if [ -z "$VNC_PID" ]; then
    echo "❌ VNC process not found. Checking logs..."
    tail -20 ~/.vnc/*.log 2>/dev/null || echo "No log files found"
    exit 1
fi

echo "✅ VNC Server process running (PID: $VNC_PID)"
echo ""

# Display connection information
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            ✅ VNC SERVER RUNNING SUCCESSFULLY              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📡 CONNECTION DETAILS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Get connection details
if [ -n "$CODESPACE_NAME" ]; then
    PUBLIC_URL="${CODESPACE_NAME}-5901.app.github.dev"
    echo "🌐 Public URL: https://${PUBLIC_URL}"
    echo "🔌 VNC Address: ${PUBLIC_URL}:5901"
    echo "📍 Alternative: ${PUBLIC_URL}::5901"
    echo ""
    echo "📋 COPY THIS ADDRESS TO YOUR VNC CLIENT:"
    echo "   ${PUBLIC_URL}:5901"
else
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    HOSTNAME=$(hostname)
    echo "🔌 VNC Address: ${LOCAL_IP}:5901"
    echo "🖥️  Hostname: ${HOSTNAME}:5901"
    echo "📍 Localhost: localhost:5901"
    echo ""
    echo "📋 COPY THIS ADDRESS TO YOUR VNC CLIENT:"
    echo "   ${LOCAL_IP}:5901"
fi

echo ""
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
echo "ℹ️  NOTE: Warnings about DRI3, DPMS, systemd are normal in containers"
echo "💡 Press Ctrl+C to stop monitoring (VNC will keep running)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Monitor VNC logs but filter out common warnings
echo "📊 Monitoring VNC logs (showing new activity only)..."
echo ""
tail -f ~/.vnc/*.log 2>/dev/null | grep -v "Could not find any render nodes" | grep -v "Failed to initialize DRI3" | grep -v "Failed to get a systemd proxy"#!/bin/bash

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
vncserver :1 -geometry 1920x1080 -depth 24 -localhost no 2>&1 | grep -v "Could not find any render nodes" | grep -v "Failed to initialize DRI3"

# Wait for VNC to start
sleep 5

# Check if VNC started successfully (check for either process name)
VNC_PID=$(pgrep -x "Xtigervnc" || pgrep -x "Xvnc")

if [ -z "$VNC_PID" ]; then
    echo "❌ VNC process not found. Checking logs..."
    tail -20 ~/.vnc/*.log 2>/dev/null || echo "No log files found"
    exit 1
fi

echo "✅ VNC Server process running (PID: $VNC_PID)"
echo ""

# Display connection information
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            ✅ VNC SERVER RUNNING SUCCESSFULLY              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📡 CONNECTION DETAILS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Get connection details
if [ -n "$CODESPACE_NAME" ]; then
    PUBLIC_URL="${CODESPACE_NAME}-5901.app.github.dev"
    echo "🌐 Public URL: https://${PUBLIC_URL}"
    echo "🔌 VNC Address: ${PUBLIC_URL}:5901"
    echo "📍 Alternative: ${PUBLIC_URL}::5901"
    echo ""
    echo "📋 COPY THIS ADDRESS TO YOUR VNC CLIENT:"
    echo "   ${PUBLIC_URL}:5901"
else
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    HOSTNAME=$(hostname)
    echo "🔌 VNC Address: ${LOCAL_IP}:5901"
    echo "🖥️  Hostname: ${HOSTNAME}:5901"
    echo "📍 Localhost: localhost:5901"
    echo ""
    echo "📋 COPY THIS ADDRESS TO YOUR VNC CLIENT:"
    echo "   ${LOCAL_IP}:5901"
fi

echo ""
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
echo "ℹ️  NOTE: Warnings about DRI3, DPMS, systemd are normal in containers"
echo "💡 Press Ctrl+C to stop monitoring (VNC will keep running)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Monitor VNC logs but filter out common warnings
echo "📊 Monitoring VNC logs (showing new activity only)..."
echo ""
tail -f ~/.vnc/*.log 2>/dev/null | grep -v "Could not find any render nodes" | grep -v "Failed to initialize DRI3" | grep -v "Failed to get a systemd proxy"
