// Starts the bot when the hosting panel insists on running a Node entry point.
// The real program is the self-contained .NET binary next to this file; start.sh sets up
// the emoji font and the data folder, then runs it.
const { spawn } = require('node:child_process');

const child = spawn('sh', ['start.sh'], { stdio: 'inherit' });
child.on('exit', (code, signal) => process.exit(signal ? 1 : (code ?? 0)));
child.on('error', (error) => {
  console.error('Could not start the bot:', error.message);
  process.exit(1);
});
for (const signal of ['SIGINT', 'SIGTERM']) {
  process.on(signal, () => child.kill(signal));
}
