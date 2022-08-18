import path from 'path'
import {fileURLToPath} from 'url'
import * as childProcess from 'child_process'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const script = `${__dirname}/bin/slack-notify`

childProcess.spawnSync(script, {stdio: 'inherit'})
