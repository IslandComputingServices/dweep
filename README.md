# dweep - ICS Development Workspace Setup Tool

**dweep** is the official workspace setup tool for Island Computing Services (ICS) development. It ensures every engineer follows consistent ICS standards and processes.

## Overview

dweep automates the creation of standardized development workspaces that include:
- ICS Core Standards integration
- Proper directory structure following ICS layered architecture
- Specification templates
- AI agent instructions
- Technology stack enforcement
- Multi-repository workspace support

## Requirements

- **macOS M3 and later**
- **Git** - Version control
- **GitHub CLI (gh)** - GitHub integration  
- **Amazon Q CLI (q)** - AI agent interaction

## Installation

### Quick Install
```bash
curl -fsSL https://raw.githubusercontent.com/IslandComputingServices/dweep/main/install.sh | bash
```

### Manual Install
```bash
git clone https://github.com/IslandComputingServices/dweep.git
cd dweep
chmod +x dweep install.sh
./install.sh
```

### Verify Installation
```bash
dweep --version
```

## Usage

### Create New Workspace
```bash
dweep create <workspace-name> [options]
```

**Options:**
- `--type <type>` - Workspace type (system, service, library)
- `--tech-stack <stack>` - Technology stack (smithy, typescript, python)
- `--github-org <org>` - GitHub organization (default: IslandComputingServices)

**Examples:**
```bash
# Create system workspace for Island Management Service
dweep create IslandsManagementService --type system --tech-stack smithy

# Create service workspace
dweep create UserAuthenticationService --type service --tech-stack typescript

# Create library workspace  
dweep create CommonUtilities --type library --tech-stack python
```

### Workspace Structure Created

```
{WorkspaceName}/
├── ICSCoreStandards/           # ICS standards (auto-downloaded)
├── packages/                   # All packages/repositories for this system
│   ├── data-access-layer/      # Data Access Layer repositories
│   ├── business-layer/         # Business Logic Layer repositories  
│   ├── api-layer/              # API Layer repositories
│   ├── presentation-layer/     # Presentation Layer repositories
│   └── shared/                 # Shared libraries and common types
├── specifications/             # System-wide specifications
├── docs/                       # System documentation
├── scripts/                    # Build and deployment scripts
├── AI_AGENT_INSTRUCTIONS.md    # AI agent guidance
└── WORKSPACE_STRUCTURE.md      # Workspace documentation
```

### Repository Management

#### Clone Repository to Workspace
```bash
cd /path/to/workspace
dweep clone <repository-url> [target-directory]
```

#### Create New Repository in Workspace
```bash
cd /path/to/workspace  
dweep repo create <repo-name> --layer <layer> --type <type>
```

**Layers:**
- `data-access-layer` - Data access repositories
- `business-layer` - Business logic repositories
- `api-layer` - API repositories  
- `presentation-layer` - Frontend repositories
- `shared` - Shared libraries

**Types:**
- `service` - Service implementation
- `model` - Data/API models
- `library` - Utility libraries
- `interface` - Shared interfaces

### Workspace Validation
```bash
cd /path/to/workspace
dweep validate
```

Checks:
- ICS Core Standards compliance
- Directory structure adherence
- Required files presence
- AI agent instructions validity

### Update Workspace Standards
```bash
cd /path/to/workspace
dweep update
```

Updates:
- ICS Core Standards to latest version
- AI agent instructions
- Specification templates

## Configuration

### Global Configuration
```bash
dweep config set github.org IslandComputingServices
dweep config set default.tech-stack smithy
dweep config set workspace.base-path ~/IslandComputing/workspaces
```

### Workspace-Specific Configuration
Create `.dweep/config.json` in workspace root:
```json
{
  "workspace_type": "system",
  "tech_stack": "smithy", 
  "github_org": "IslandComputingServices",
  "standards_version": "latest"
}
```

## Examples

### Complete Workflow Example
```bash
# 1. Create workspace
dweep create IslandsManagementService --type system --tech-stack smithy

# 2. Navigate to workspace
cd ~/IslandComputing/workspaces/IslandsManagementService

# 3. Create model repository
dweep repo create IslandManagementServiceModel --layer api-layer --type model

# 4. Clone existing repository
dweep clone https://github.com/IslandComputingServices/ICSCoreStandards.git

# 5. Validate workspace
dweep validate

# 6. Update standards
dweep update
```

### Working with AI Agent
```bash
# Start Q CLI in workspace (AI agent has access to ICS standards)
cd /path/to/workspace
q chat

# AI agent automatically loads:
# - ICS Core Standards
# - AI_AGENT_INSTRUCTIONS.md
# - Workspace structure context
```

## Troubleshooting

### Common Issues

**Permission Denied:**
```bash
chmod +x dweep
```

**GitHub Authentication:**
```bash
gh auth login
```

**Missing Dependencies:**
```bash
# Install GitHub CLI
brew install gh

# Install Amazon Q CLI  
curl -sSL https://d2yblsmsllhwdu.cloudfront.net/q/install | bash
```

### Debug Mode
```bash
dweep --debug create <workspace-name>
```

## Support

- **Documentation**: [ICS Core Standards](https://github.com/IslandComputingServices/ICSCoreStandards)
- **Issues**: [GitHub Issues](https://github.com/IslandComputingServices/dweep/issues)
- **Discussions**: [GitHub Discussions](https://github.com/IslandComputingServices/dweep/discussions)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## License

Copyright © 2025 Island Computing Services. All rights reserved.
cd dweep
sudo cp dweep /usr/local/bin/dweep
sudo chmod +x /usr/local/bin/dweep
```

## Usage

### Setup New Workspace
```bash
dweep -setup workspace
```

Interactive setup will ask for:
1. **Workspace Type:**
   - New Service (microservice/API)
   - New Worker (background processing)
   - New Website (frontend application)
   - Existing System (checkout existing codebase)

2. **System Name:** e.g., `IslandManagementService`

3. **Workspace Name:** Auto-suggested as `{SystemName}-{username}`

### List Workspaces
```bash
dweep -list
```

### Help
```bash
dweep -help
```

## Workspace Structure

Each workspace created by dweep follows this structure:

```
~/workspaces/{WorkspaceName}/
├── ICSCoreStandards/           # ICS standards (auto-downloaded)
├── specifications/             # Specification templates
│   ├── api-model-specification.md
│   ├── architecture-specification.md
│   ├── design-specification.md
│   └── data-model-specification.md
├── src/                       # Source code (created by AI agent)
├── docs/                      # Documentation
├── scripts/                   # Build and deployment scripts
├── AI_AGENT_INSTRUCTIONS.md   # AI agent guidance
└── .dweep/                    # Workspace metadata
    ├── workspace_type
    ├── system_name
    ├── created_at
    └── dweep_version
```

## Development Process

dweep enforces the ICS development process:

### Phase 1: Specification Creation (REQUIRED)
1. **API Model Specification** - Define API contracts and data structures
2. **Architecture Specification** - Define system architecture and layers
3. **Design Specification** - Define design patterns and components
4. **Data Model Specification** - Define data models and ADTs

**All specifications MUST be approved before proceeding to implementation.**

### Phase 2: Interface Generation
1. Generate shared interfaces between layers:
   - API Layer ↔ Business Logic Layer
   - Business Logic Layer ↔ Data Access Layer
2. Finalize all contracts and types

### Phase 3: Implementation
1. Implement layers in order:
   - **Data Access Layer** (using Data Models + ADTs)
   - **Business Logic Layer** (using ADTs + Common Types)
   - **API Layer** (using API Models + Common Types)

## AI Agent Integration

dweep creates AI agent instructions that enforce ICS standards:

### Initial Specification Creation
```bash
cd ~/workspaces/{WorkspaceName}
q chat "Create initial specifications for {system_type} following ICS standards"
```

### Interface Generation
```bash
q chat "Generate shared interfaces and contracts based on approved specifications"
```

### Layer Implementation
```bash
q chat "Implement [layer] following approved specifications and interfaces"
```

## Technology Stack (Approved)

### Backend Services
- **Java 17+** with Spring Boot
- **PostgreSQL** for data persistence
- **Redis** for caching

### Frontend Applications
- **React 18+** with TypeScript
- **Next.js** for SSR/SSG
- **Tailwind CSS** for styling

### Infrastructure
- **Docker** for containerization
- **Kubernetes** for orchestration

## Standards Enforcement

dweep ensures compliance with:

### ICS Core Standards
- **Architecture Standards** - SOA principles, layer separation
- **API Design Standards** - AWS compatibility, field naming
- **Design Standards** - Pattern usage, modularity
- **Development Process** - Specification-driven development
- **Testing Standards** - Coverage requirements, TDD
- **Quality Standards** - Automated validation

### AI Agent Constraints
- **MUST NOT** create new types without specification approval
- **MUST NOT** skip specification phase
- **MUST NOT** implement across multiple layers simultaneously
- **MUST** use existing contracts and types only
- **MUST** follow 4-layer architecture
- **MUST** maintain AWS API compatibility

## Examples

### Creating a New Service
```bash
$ dweep -setup workspace

=== ICS Workspace Setup ===

Select workspace type:
1) New Service (microservice/API)
2) New Worker (background processing)
3) New Website (frontend application)
4) Existing System (checkout existing codebase)

Enter choice (1-4): 1

Enter service name (e.g., IslandManagementService): UserManagementService
Workspace name [UserManagementService-vsirohi]: 

✓ Created workspace directory: ~/workspaces/UserManagementService-vsirohi
✓ Downloaded ICS Core Standards
✓ Created specification templates
✓ Created AI agent instructions
✓ Workspace setup complete!

=== Next Steps ===

1. Navigate to your workspace:
   cd ~/workspaces/UserManagementService-vsirohi

2. Review the ICS Core Standards:
   open ICSCoreStandards/README.md

3. Start with specifications (REQUIRED):
   q chat "Create initial specifications following ICS standards"

4. Review AI Agent Instructions:
   open AI_AGENT_INSTRUCTIONS.md

5. Follow the specification → interface → implementation process
```

### Listing Workspaces
```bash
$ dweep -list

[INFO] Existing workspaces in ~/workspaces:
  • UserManagementService-vsirohi (service)
  • IslandProvisioningWorker-vsirohi (worker)
  • IslandConsole-vsirohi (website)
[SUCCESS] Found 3 workspace(s)
```

## Configuration

dweep stores configuration in `~/.dweep/`:
- Workspace metadata
- Tool preferences
- Version information

## Troubleshooting

### Common Issues

**"Required tool 'git' is not installed"**
- Install Git: `brew install git` or https://git-scm.com/download/mac

**"Required tool 'gh' is not installed"**
- Install GitHub CLI: `brew install gh`

**"Required tool 'q' is not installed"**
- Install Amazon Q CLI: https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-cli.html

**"Git is not configured properly"**
- Configure Git with your credentials:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**"GitHub CLI is not authenticated"**
- Authenticate with GitHub:
```bash
gh auth login
```

**"Failed to download ICS Core Standards repository"**
- Check network connectivity
- Verify GitHub CLI authentication: `gh auth status`
- Test repository access: `gh repo view IslandComputingServices/ICSCoreStandards`
- Contact repository administrator for access permissions

**"Repository not found or access denied"**
- Ensure you have access to the ICS Core Standards repository
- Verify your GitHub account has proper permissions
- Check if repository URL is correct

**"Permission denied"**
- Run installation with sudo: `sudo ./install.sh`

### Git Configuration Issues

**Check Git Configuration:**
```bash
git config --global --list
```

**Reset Git Configuration:**
```bash
git config --global --unset user.name
git config --global --unset user.email
# Then reconfigure with correct values
```

**Check GitHub CLI Status:**
```bash
gh auth status
gh auth refresh
```

### Network and Access Issues

**Test Repository Access:**
```bash
gh repo view IslandComputingServices/ICSCoreStandards
git ls-remote https://github.com/IslandComputingServices/ICSCoreStandards.git
```

**Check Network Connectivity:**
```bash
ping github.com
curl -I https://github.com
```

### Support

For issues and feature requests:
- Create an issue: https://github.com/IslandComputingServices/dweep/issues
- Documentation: https://github.com/IslandComputingServices/ICSCoreStandards

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow ICS development standards
4. Submit a pull request

## License

Copyright (c) 2025 Island Computing Services. All rights reserved.

## Version History

- **v1.0.0** - Initial release with workspace setup and standards integration
