# Network Lab - GitHub Codespace

A portable cloud environment for testing network designs with containerlab and Netbox.

## What This Is

- **Containerlab devices:** Virtual Cisco routers that behave like real hardware
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

Wait ~30 seconds, then access Netbox at:
- **URL:** http://localhost:8000
- **Username:** admin@netbox.local
- **Password:** admin

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
# Password: admin

# Router 2
ssh admin@192.168.100.12
# Password: admin
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

- Data persists in Codespace storage (until you delete the codespace)
- Netbox port 8000 is forwarded for web access
- Containerlab devices are accessible via SSH
- Treat these like real devices — because they behave like them
