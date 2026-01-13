# Enjin ![Logo](https://i.postimg.cc/4dhtMG8V/Chat-GPT-Image-Jan-13-2026-09-16-07-AM.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)

**Enjin** is a portable, lightweight Windows development environment for PHP developers. Run multiple **PHP versions** and manage multiple projects easily, with **portable MySQL/MariaDB** support.

---

## Demo Video

[![Enjin Demo](https://img.youtube.com/vi/iyH5ek-Asv4/0.jpg)](https://www.youtube.com/watch?v=iyH5ek-Asv4)

---

## Features

- **Fully Portable:** Run from USB or cloud folder.
- **Multi-PHP Support:** Switch between PHP 7.4, 8.0, 8.1, etc.
- **Interactive Runner:** `run.bat` guides folder & PHP selection.
- **Portable Database Support:** MySQL/MariaDB without installation.
- **Clean Structure:** Manual control, simple folder layout.

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

1. Download & extract to `G:\enjin\`.
2. Create a project folder in `root`.
3. Double-click `run.bat`.
4. Follow prompts to select project and PHP version.

---

## Configuration (`config.ini`)

```ini
SERVER_ROOT=G:\enjin\
SERVER_DOC_ROOT=G:\enjin\root\
DEFAULT_HOST=localhost
DEFAULT_PORT=8000
```

---

## Advanced Configuration

**Add new PHP version**: Download ZIP from [php.net](https://windows.php.net/download/), extract into `php`, configure `php.ini`.

**Install portable MySQL**: Extract ZIP into `database`, create `data` folder, initialize with:

```bash
mysqld --initialize-insecure --datadir="G:\enjin\database\mysql81\data"
```

---

## Sponsorship

[![Donate](https://img.shields.io/badge/Donate-PayPal-gold.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=tuhiny2k5@gmail.com&item_name=Enjin+Donation)

---

## Hire Me

**Stack:** PHP, MySQL, Laravel, CodeIgniter, Vue.js, React.js, AngularJS

**Contact:** [GitHub](https://github.com/archivetuhin), [Email](mailto:tuhiny2k5@gmail.com), [WhatsApp](https://wa.me/8801837742506)

---

## License

MIT License. Free for modification and redistribution.

**Created by [archivetuhin](https://github.com/archivetuhin)**
