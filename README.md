# <p align="center">Enjin</p>
<p align="center"><img src="https://i.postimg.cc/4dhtMG8V/Chat-GPT-Image-Jan-13-2026-09-16-07-AM.png" alt="Enjin Logo" width="120"></p>

<p align="center">
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)]()
[![PHP Versions](https://img.shields.io/badge/PHP-7.4%7C8.0%7C8.1-lightgrey.svg)]()
</p>

---

## 📖 Table of Contents
1. [About](#about)
2. [Demo](#demo)
3. [Features](#features)
4. [Folder Structure](#folder-structure)
5. [Quick Start](#quick-start)
6. [Configuration](#configuration)
7. [Advanced Configuration](#advanced-configuration)
8. [Sponsorship](#sponsorship)
9. [Hire Me](#hire-me)
10. [License](#license)

---

## About
**Enjin** is a portable, lightweight Windows development environment for PHP developers. It allows you to run multiple **PHP versions** and manage multiple projects easily, with **portable MySQL/MariaDB** support.

Perfect for testing legacy and modern PHP applications side-by-side on a USB drive or external disk.

---

## Demo
[![Enjin Demo](https://img.youtube.com/vi/iyH5ek-Asv4/0.jpg)](https://www.youtube.com/watch?v=iyH5ek-Asv4)
*Watch the full tutorial on [YouTube](https://www.youtube.com/watch?v=iyH5ek-Asv4).* 

---

## Features
| Feature | Description |
|---------|-------------|
| 🚀 Fully Portable | Run from USB or cloud folder. No installation required. |
| 🔢 Multi-PHP Support | Easily switch between PHP 7.4, 8.0, 8.1, etc. |
| ⚙️ Interactive Runner | `run.bat` guides you through folder & PHP selection. |
| 💾 Portable Database | Pre-configured MySQL/MariaDB without installing services. |
| 🛠️ Clean Structure | Manual project control; simple folder layout. |

---

## Folder Structure
```text
G:\enjin\
│
├─ php\
│  ├─ php81\
│  │  ├─ php.exe
│  │  └─ ext\
│  ├─ php82\
│  └─ ...
│
├─ root\
│  ├─ my_app\
│  └─ index.php
│
├─ database\
│  ├─ mysql57\
│  ├─ mysql80\
│  └─ ...
│
├─ run.bat
└─ config.ini
```

---

## Quick Start
1. **Download & Extract:** Extract to `G:\enjin\`.
2. **Create Project Folder:** In `root`, create your project folder and add PHP files.
3. **Run Script:** Double-click `run.bat`.
4. **Interact:** Enter project folder, select PHP version, optionally set host/port.

---

## Configuration
Edit `config.ini` for global defaults:
```ini
SERVER_ROOT=G:\enjin\
SERVER_DOC_ROOT=G:\enjin\root\
DEFAULT_HOST=localhost
DEFAULT_PORT=8000
```

---

## Advanced Configuration
### Add New PHP Version
1. Download Thread Safe ZIP from [php.net](https://windows.php.net/download/).
2. Extract into `php` folder (e.g., `G:\enjin\php\php83\`).
3. Copy `php.ini-development` to `php.ini` and configure extensions if needed.
4. Restart `run.bat`.

### Install Portable MySQL
1. Download ZIP version of MySQL/MariaDB.
2. Extract to `database` folder.
3. Create a `data` folder.
4. Initialize database:
```bash
mysqld --initialize-insecure --datadir="G:\enjin\database\mysql81\data"
```

---

## Sponsorship
Support Enjin development:
[![Donate](https://img.shields.io/badge/Donate-PayPal-gold.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=tuhiny2k5@gmail.com&item_name=Enjin+Donation)

---

## Hire Me
**Stack:** PHP, MySQL, Laravel, CodeIgniter, Vue.js, React.js, AngularJS  
**Contact:** [GitHub](https://github.com/archivetuhin), [Email](mailto:tuhiny2k5@gmail.com), [WhatsApp](https://wa.me/8801837742506)

---

## License
MIT License. Free for modification and redistribution.  
**Created by [archivetuhin](https://github.com/archivetuhin)**
