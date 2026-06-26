const { chromium } = require('playwright');
const path = require('path');

const HTML_DIR = String.raw`D:\cat_teacher_app\store-assets\screenshots\html`;
const OUT_DIR = String.raw`D:\cat_teacher_app\store-assets\screenshots`;

const files = [
  '01-home.html',
  '02-textbook.html',
  '03-chat.html',
  '04-photo-scan.html',
  '05-voice.html',
  '06-lecture.html',
];

(async () => {
  const browser = await chromium.launch({ headless: true });
  
  for (const file of files) {
    const name = file.replace('.html', '');
    const htmlPath = path.join(HTML_DIR, file);
    const outPath = path.join(OUT_DIR, name + '.png');
    
    console.log(`Capturing: ${name}...`);
    
    const context = await browser.newContext({
      viewport: { width: 1080, height: 1920 },
      deviceScaleFactor: 1,
    });
    
    const page = await context.newPage();
    await page.goto('file:///' + htmlPath.replace(/\\/g, '/'), { waitUntil: 'networkidle' });
    
    // Give fonts time to render
    await page.waitForTimeout(500);
    
    await page.screenshot({
      path: outPath,
      type: 'png',
      fullPage: false,
    });
    
    console.log(`  -> Saved: ${outPath}`);
    await context.close();
  }
  
  await browser.close();
  console.log('\nAll screenshots captured successfully!');
})().catch(err => {
  console.error('Error:', err.message);
  process.exit(1);
});
