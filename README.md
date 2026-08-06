# FluxOps – Continuous and Automated IT Operations

FluxOps is an educational DevOps command and deployment assistant for students and beginners. It helps you learn and use common Linux, Git, Docker, Jenkins, AWS CLI and Kubernetes commands through clear explanations, real examples and step-by-step deployment guides.

> **Tagline:** Continuous and Automated IT Operations

FluxOps is an educational frontend application. It does not execute terminal commands or modify cloud resources. All commands are shown as reference material for you to run manually in your own environment.

---

## Project Overview

FluxOps provides a searchable commands library, structured learning paths, Docker and AWS EC2 deployment guides, and troubleshooting solutions for common deployment errors. It is designed for the following workflow:

**GitHub repository → Ubuntu AWS EC2 → Docker image → Nginx container**

---

## Main Features

- Search for commands by title, command text, explanation, category or example
- Filter commands by category (Linux, Git, Docker, Jenkins, AWS CLI, Kubernetes)
- Copy commands to the clipboard with a single click
- Save favourite commands in LocalStorage
- Track learning progress across structured learning paths
- Follow a step-by-step Docker deployment guide
- Follow a beginner-friendly AWS EC2 setup checklist
- View solutions for common deployment errors
- Dark mode and light mode with a theme toggle
- Fully responsive design for desktop, tablet and mobile

---

## Technology Stack

- **React** – UI library
- **Vite** – build tool and dev server
- **TypeScript** – type-safe JavaScript
- **Tailwind CSS** – utility-first styling
- **React Router** – client-side routing
- **Lucide React** – icon library
- **LocalStorage** – saving favourites and progress
- **Nginx** – production container serving

No Supabase, Firebase, authentication, external databases, serverless functions, paid APIs or environment variables are used.

---

## Application Pages

| Page | Description |
|------|-------------|
| Home | Landing page with search, category cards, popular commands and learning-path preview |
| Commands | Searchable and filterable commands library |
| Docker Guide | Step-by-step Docker deployment guide with troubleshooting |
| EC2 Guide | Beginner-friendly AWS EC2 setup checklist |
| Learning Paths | Structured learning paths with progress tracking |
| Saved Commands | Your saved favourite commands |
| About | Information about FluxOps |

---

## Folder Structure

```
fluxops/
├── Dockerfile
├── .dockerignore
├── nginx.conf
├── deployment.yml
├── service.yml
├── index.html
├── package.json
├── vite.config.ts
├── tailwind.config.js
├── postcss.config.js
├── tsconfig.json
├── src/
│   ├── main.tsx
│   ├── App.tsx
│   ├── index.css
│   ├── components/
│   │   ├── Navbar.tsx
│   │   ├── MobileMenu.tsx
│   │   ├── Footer.tsx
│   │   ├── Layout.tsx
│   │   ├── SearchBar.tsx
│   │   ├── CategoryCard.tsx
│   │   ├── CommandCard.tsx
│   │   ├── CopyButton.tsx
│   │   ├── TerminalBlock.tsx
│   │   ├── ProgressCard.tsx
│   │   ├── TroubleshootingAccordion.tsx
│   │   ├── EmptyState.tsx
│   │   ├── PageHeading.tsx
│   │   └── ThemeToggle.tsx
│   ├── context/
│   │   └── ThemeContext.tsx
│   ├── data/
│   │   ├── commands.ts
│   │   ├── learningPaths.ts
│   │   └── troubleshooting.ts
│   ├── hooks/
│   │   ├── useSavedCommands.ts
│   │   ├── useLearningProgress.ts
│   │   └── useEC2Checklist.ts
│   └── pages/
│       ├── HomePage.tsx
│       ├── CommandsPage.tsx
│       ├── DockerGuidePage.tsx
│       ├── EC2GuidePage.tsx
│       ├── LearningPathsPage.tsx
│       ├── SavedCommandsPage.tsx
│       ├── AboutPage.tsx
│       └── NotFoundPage.tsx
```

---

## Local Installation

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd fluxops
npm install
npm run dev
```

The development server starts on the local port shown in your terminal.

---

## Development Command

```bash
npm run dev
```

---

## Production Build Command

```bash
npm run build
```

The production build is generated in the `dist` directory.

---

## GitHub Push Instructions

```bash
git init
git add .
git commit -m "Initial FluxOps project"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```

---

## Docker Build and Run Instructions

```bash
docker build -t fluxops:v1 .
docker run -d --name fluxops-container --restart always -p 80:80 fluxops:v1
docker ps
docker logs fluxops-container
```

Open the application in your browser at `http://localhost`.

---

## EC2 Deployment Instructions

1. Launch an Ubuntu EC2 instance.
2. Configure the security group to allow SSH (port 22) and HTTP (port 80).
3. Connect to the instance using SSH.
4. Update packages and install Git and Docker:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install git docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
newgrp docker
```

5. Clone the FluxOps repository and deploy:

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd fluxops
docker build -t fluxops:v1 .
docker run -d --name fluxops-container --restart always -p 80:80 fluxops:v1
```

6. Open the application using the EC2 public IPv4 address:

```
http://YOUR_EC2_PUBLIC_IP
```

---

## Kubernetes Deployment Instructions

```bash
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl get deployments
kubectl get pods
kubectl get services
```

The application is exposed on NodePort 30007.

---

## Troubleshooting

### Docker permission denied

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Port 80 already in use

```bash
sudo lsof -i :80
```

### Container name already exists

```bash
docker rm -f fluxops-container
```

### No space left on device

```bash
docker system df
docker system prune -a
```

### React Router returning 404 after refresh

Make sure `nginx.conf` contains the `try_files $uri $uri/ /index.html;` directive.

### EC2 public IP not opening

- Confirm the container is running with `docker ps`.
- Make sure port 80 is open in the EC2 security group.
- Allow port 80 through the firewall:

```bash
sudo ufw allow 80/tcp
```

---

## Screenshots

![Home Page](screenshots/home.png)
![Commands Library](screenshots/commands.png)
![Docker Guide](screenshots/docker-guide.png)
![EC2 Guide](screenshots/ec2-guide.png)
![Learning Paths](screenshots/learning-paths.png)
![Saved Commands](screenshots/saved-commands.png)
![About Page](screenshots/about.png)
![Dark Mode](screenshots/dark-mode.png)
![Light Mode](screenshots/light-mode.png)

---

© FluxOps. Built for learning DevOps.
