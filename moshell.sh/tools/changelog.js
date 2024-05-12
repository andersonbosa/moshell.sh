#!/usr/bin/env node

const { execSync } = require('node:child_process')
const { dirname, join, resolve } = require('node:path')
const fs = require('node:fs')
const os = require('node:os')
const https = require('node:https')

// Defines the absolute path of the script file and the script directory
const ABSOLUTE_SCRIPT_FILE_PATH = process.argv[1]
const ABSOLUTE_SCRIPT_DIR_PATH = dirname(ABSOLUTE_SCRIPT_FILE_PATH)
const { GOOGLE_GEMINI_API_KEY } = process.env

function getLastNthReleaseCommit (nth) {
  if (!nth) throw new Error('nth is required')
  const RELEASE_VERSION_GREP_REGEX = 'release([0-9]\\+\\.[0-9]\\+\\.[0-9]\\+)'
  const awkQueryFirstItemOnTheRow = `NR==${nth}`
  const gitLogCommand = `git log --pretty=format:%H --grep="${RELEASE_VERSION_GREP_REGEX}" | awk ${awkQueryFirstItemOnTheRow}`
  const lastReleaseCommit = execSync(gitLogCommand).toString().trim()
  return lastReleaseCommit
}

// Adds header levels based on the Commit key
function parseCommitFormat (commitHash, _author, date, message) {
  const linkToRepository = "https://github.com/andersonbosa/moshell.sh"
  const isRelease = message.startsWith("release")
  if (isRelease) {
    return `## ${date} - ${message} ${os.EOL}${os.EOL}> - [Commit ${commitHash}](${linkToRepository}/commit/${commitHash})${os.EOL}TBD`
  } else {
    return `- ${message}`
  }
}

function isSemanticCommit (commitMessage) {
  const semanticCommitKeys = ['feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore', 'perf', 'build', 'ci', 'revert', 'release']
  const verifyCommit = key => commitMessage?.toLowerCase().startsWith(key.toLowerCase())
  return semanticCommitKeys.some(verifyCommit)
}

// Analyzes an input line and converts it into a changelog format
function parseLineToChangelog (acc, line) {
  const [commitHash, author, date, message] = line.split(",")

  if (!isSemanticCommit(message)) return acc

  const changelogEntry = parseCommitFormat(commitHash, author, date, message)

  return [...acc, changelogEntry]
}


async function generateReleaseOverviewWithGoogleGemini (releaseContent, aditionalInfo = '') {
  if (!GOOGLE_GEMINI_API_KEY) {
    return ''
  }

  const prompt = `
Your mission is to write paragraph about this release using the context from the commits provided below. Write a brief resume about what happened. Don't add header to text neither don't use lists. Do not quote the current version, just focus on what was done. Do not talk about the version being updated.

\`\`\`
${releaseContent}
\`\`\`

${aditionalInfo}`

  const options = {
    hostname: 'generativelanguage.googleapis.com',
    path: '/v1beta/models/gemini-pro:generateContent?key=' + GOOGLE_GEMINI_API_KEY,
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  }

  const response = await new Promise((resolve, reject) => {
    const req = https.request(options, (response) => {
      let data = ''
      response.on('data', (chunk) => {
        data += chunk
      })
      response.on('end', () => {
        try {
          const responseData = JSON.parse(data)
          const contentOutput = responseData.candidates[0].content.parts[0].text
          resolve(contentOutput)
        } catch (error) {
          reject(new Error('Error parsing response: ' + error.message))
        }
      })
    })

    req.on('error', (e) => {
      reject(new Error('Error generating content: ' + e.message))
    })

    const requestBody = JSON.stringify({ contents: [{ parts: [{ text: prompt }] }] })

    req.write(requestBody)
    req.end()
  })

  return response
}

function getCommitsFromCurrentVersion (fromCommit, sinceCommit) {
  if (!fromCommit || !sinceCommit) throw new Error('fromCommit and sinceCommit are required')

  const gitLogCommand = `git log --pretty=format:%h,%an,%as,%s "${fromCommit}...${sinceCommit}"`
  const commitsFromTheCurrentVersion = execSync(gitLogCommand).toString().split(os.EOL)
  return commitsFromTheCurrentVersion
}

// Main function to generate Changelog
async function generateChangelog (outputPath = 'CHANGELOG.md') {
  const changelogFilePath = join(`${ABSOLUTE_SCRIPT_DIR_PATH}`, '../..', '/docs/CHANGELOG.md')

  let changelogFileContentBackup = ""
  if (fs.existsSync(changelogFilePath)) {
    changelogFileContentBackup = fs.readFileSync(changelogFilePath, 'utf-8')
  }

  // Limpa/inicializa o arquivo
  // fs.writeFileSync(changelogFilePath, '')

  const fromCommit = getLastNthReleaseCommit(1)
  const sinceCommit = getLastNthReleaseCommit(2)
  const commitsFromTheCurrentVersion = getCommitsFromCurrentVersion(fromCommit, sinceCommit)

  const changelogLines = commitsFromTheCurrentVersion.reduce(parseLineToChangelog, [])

  const changelogContentFromNewVersion = changelogLines.join(os.EOL)
  const geminiResponse = await generateReleaseOverviewWithGoogleGemini(changelogContentFromNewVersion)

  const changelogContent = changelogContentFromNewVersion
    .replace('TBD', `${os.EOL}${geminiResponse}${os.EOL}`)
    .concat(os.EOL)
    .concat(os.EOL)
    .concat(`${changelogFileContentBackup}`)

  fs.writeFileSync(outputPath, changelogContent)
  // fs.appendFileSync(changelogFilePath, `\n${changelogFileContentBackup}`)
}

const outputPath = process.argv[2]
generateChangelog(outputPath)
