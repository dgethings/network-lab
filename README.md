# Network Lab - GitHub Codespace

A portable cloud environment for testing network designs with containerlab and Netbox.

## What This Is

- **Containerlab devices:** Virtual Nokia SR Linux routers (no licensing required)
- **Netbox:** Inventory management for your network
- **pyATS:** Test automation (already available in the environment)
- **Devcontainer:** Preconfigured tools (containerlab + docker-compose)

## Project Structure

```
network-lab/
├── .devcontainer/
│   └── devcontainer.json          # Codespace configuration
├── netbox/
│   └── docker-compose.yml         # Netbox + postgres + redis
├── containerlab/
│   └── lab1.yaml                  # Device topology
├── automation/
│   └── pyATS/
│       └── testbed.yml            # pyATS testbed definition
└── README.md
```

## Getting Started

### 1. Create GitHub Repo

```bash
cd /Users/dgethings/.openclaw/workspace/network-lab
git init
git add .
git commit -m "Initial commit"
# Create repo on GitHub, then:
git remote add origin <your-repo-url>
git push -u origin main
```

### 2. Open Codespace

On GitHub, click "Code" → "Codespaces" → "Create codespace on main".

### 3. Start Netbox

```bash
cd netbox
docker-compose up -d
```

Wait ~30 seconds for Netbox to start. Then:

**Access Netbox:**
- In your Codespace terminal, look for a notification like:
  ```
  Forwarded port 8000
  https://brave-space-puma-8000.app.github.dev
  ```
- Or go to the **Ports** tab in VS Code (bottom panel) and click the forwarded URL
- **Username:** admin@netbox.local
- **Password:** admin

**The URL format is:** `https://<codespace-name>-8000.app.github.dev`

### 4. Deploy Network Lab

```bash
cd ../containerlab
containerlab deploy -t lab1.yaml
```

This will:
- Pull Cisco IOS-XR container images
- Start 2 routers (r1, r2)
- Connect them via point-to-point link

### 5. Access Devices

SSH into the routers:

```bash
# Router 1
ssh admin@192.168.100.11
# Password: NokiaSrl1!

# Router 2
ssh admin@192.168.100.12
# Password: NokiaSrl1!
```

### 6. Run pyATS Tests

```bash
cd ../automation/pyATS
pyATS run testbed.yml --job-file <your-test-script>
```

## Network Topology

```
      +-----+       +-----+
      | r1  |-------| r2  |
      +-----+       +-----+

Management: 192.168.100.0/24
- r1: 192.168.100.11
- r2: 192.168.100.12

Data: 10.0.0.0/24
- r1: 10.0.0.1
- r2: 10.0.0.2
```

## Managing the Codespace

**Start:** Open via GitHub (Codespaces → Create codespace)
**Stop:** GitHub → Codespaces → "..." → Stop
**Delete:** GitHub → Codespaces → "..." → Delete when done

## Requirements

- **GitHub Codespace:** 4 cores / 8GB RAM (minimum)
- **Recommended:** 8 cores / 16GB RAM for 4+ devices

## Next Steps

- Add more devices to `lab1.yaml`
- Create pyATS test scripts for specific scenarios
- Integrate Netbox inventory with your automation
- Build larger topologies for design validation

## Notes

- **No licensing required** — Nokia SR Linux is free and open source
- Data persists in Codespace storage (until you delete the codespace)
- Netbox port 8000 is forwarded for web access
- Containerlab devices are accessible via SSH
- Treat these like real devices — because they behave like them
