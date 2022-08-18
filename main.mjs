import path from 'path'
import {fileURLToPath} from 'url'
import * as childProcess from 'child_process'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const script = `${__dirname}/entrypoint.sh`

childProcess.spawnSync(script, {
    shell: 'sh',
    stdio: 'inherit'
})
