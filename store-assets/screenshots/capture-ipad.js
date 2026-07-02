const { chromium } = require('playwright');
const path = require('path');

const HTML_DIR = String.raw`D:\cat_teacher_app\store-assets\screenshots\html`;
const OUT_DIR = String.raw`D:\cat_teacher_app\store-assets\screenshots\ipad`;

const files = [
  { html: 'ipad-home.html', out: 'ipad-01-home.png' },
  { html: 'ipad-chat.html', out: 'ipad-02-chat.png' },
  { html: 'ipad-lecture.html', out: 'ipad-03-lecture.png' },
];

(async () => {
  const browser = await chromium.launch({ headless: true });
  
  for (const { html, out } of files) {
    const htmlPath = path.join(HTML_DIR, html);
    const outPath = path.join(OUT_DIR, out);
    
    console.log(`Capturing: ${out}...`);
    
    const context = await browser.newContext({
      viewport: { width: 2048, height: 2732 },
      deviceScaleFactor: 1,
    });
    
    const page = await context.newPage();
    await page.goto('file:///' + htmlPath.replace(/\\/g, '/'), { waitUntil: 'networkidle' });
    
    await page.waitForTimeout(800);
    
    await page.screenshot({
      path: outPath,
      type: 'png',
      fullPage: false,
    });
    
    console.log(`  -> Saved: ${outPath} (2048x2732)`);
    await context.close();
  }
  
  await browser.close();
  console.log('\nAll iPad screenshots captured successfully!');
})().catch(err => {
  console.error('Error:', err.message);
  process.exit(1);
});
