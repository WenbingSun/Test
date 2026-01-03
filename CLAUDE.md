# CLAUDE.md - AI Assistant Guide for WenbingSun/Test Repository

> **Last Updated**: 2026-01-03
> **Repository**: WenbingSun/Test
> **Purpose**: Test repository with Jenkins CI/CD pipeline

## Table of Contents

1. [Repository Overview](#repository-overview)
2. [Codebase Structure](#codebase-structure)
3. [Development Workflow](#development-workflow)
4. [Git Conventions](#git-conventions)
5. [CI/CD Pipeline](#cicd-pipeline)
6. [Best Practices for AI Assistants](#best-practices-for-ai-assistants)
7. [Common Tasks](#common-tasks)

---

## Repository Overview

This is a minimal test repository containing a Jenkins pipeline configuration. The repository serves as a testing ground for CI/CD workflows and development processes.

**Key Characteristics:**
- **Primary Language**: Groovy (Jenkinsfile)
- **CI/CD Platform**: Jenkins
- **Repository Type**: Test/Development
- **Remote**: Local proxy at `http://127.0.0.1:40866/git/WenbingSun/Test`

---

## Codebase Structure

```
/home/user/Test/
├── .git/                 # Git version control directory
├── Jenkinsfile          # Jenkins pipeline definition
└── CLAUDE.md           # This file - AI assistant documentation
```

### File Descriptions

#### Jenkinsfile (line 1-12)
**Purpose**: Defines the Jenkins CI/CD pipeline configuration.

**Current Implementation**:
- Simple pipeline with single stage: "Verify Branch"
- Echoes the `$GIT_BRANCH` environment variable
- Uses `agent any` (runs on any available Jenkins agent)

**Location**: `/home/user/Test/Jenkinsfile`

---

## Development Workflow

### Branch Strategy

This repository uses a **feature branch workflow** with specific naming conventions for AI-assisted development:

1. **Feature Branches**: Named with pattern `claude/claude-md-{session-id}`
   - Example: `claude/claude-md-mjyvvtwfre9zlmfh-DiDgT`
   - Session ID must match for successful push operations

2. **Main Branch**: Currently no main branch exists (repository is branch-only at this stage)

### Standard Development Cycle

```bash
# 1. Ensure you're on the correct feature branch
git branch

# 2. Make changes to files
# ... edit files ...

# 3. Stage changes
git add <files>

# 4. Commit with descriptive message
git commit -m "Description of changes"

# 5. Push to remote (with retry logic for network issues)
git push -u origin <branch-name>
```

---

## Git Conventions

### Commit Message Guidelines

Based on repository history, commit messages should be:
- **Concise**: Short, clear descriptions
- **Action-oriented**: Use verbs (add, update, change, fix)
- **Lowercase**: Prefer lowercase for simple commits

**Examples from history**:
```
✓ add Jenkinsfile
✓ update Jenkinsfile
✓ change Jenkinsfile
✓ typo
```

### Branch Naming Convention

**AI Assistant Branches**: `claude/claude-md-{session-id}-{unique-id}`
- MUST start with `claude/`
- MUST end with matching session ID
- Failure to match pattern results in 403 HTTP error on push

### Git Push Requirements

**CRITICAL**: Always use the following push strategy:
```bash
git push -u origin <branch-name>
```

**Retry Logic**: If push fails due to network errors, retry up to 4 times with exponential backoff:
- 1st retry: wait 2 seconds
- 2nd retry: wait 4 seconds
- 3rd retry: wait 8 seconds
- 4th retry: wait 16 seconds

---

## CI/CD Pipeline

### Jenkins Pipeline Structure

**File**: `Jenkinsfile`
**Type**: Declarative Pipeline
**Syntax**: Groovy DSL

#### Current Pipeline Stages

##### Stage 1: Verify Branch
- **Purpose**: Validate the branch being built
- **Action**: Outputs the `$GIT_BRANCH` environment variable
- **Use Case**: Ensures pipeline is running on expected branch

#### Jenkins Environment Variables

Available in pipeline context:
- `$GIT_BRANCH`: Current branch name
- Standard Jenkins variables (see Jenkins documentation)

### Adding New Pipeline Stages

When extending the Jenkinsfile, follow this structure:

```groovy
pipeline {
    agent any
    stages {
        stage('Verify Branch') {
            steps {
               echo "$GIT_BRANCH"
            }
        }
        stage('New Stage Name') {
            steps {
                // Add your steps here
                echo "Performing new stage actions"
            }
        }
    }
}
```

**Common Stage Types**:
- **Build**: Compile code, run build tools
- **Test**: Execute unit tests, integration tests
- **Deploy**: Deploy to environments
- **Quality**: Run linters, code analysis
- **Notify**: Send notifications on completion

---

## Best Practices for AI Assistants

### 1. File Operations

**Reading Files**:
- ALWAYS read a file before suggesting modifications
- Use the Read tool to understand current state
- Never propose changes to code you haven't seen

**Editing Files**:
- Prefer Edit tool over Write tool for existing files
- Preserve exact indentation and formatting
- Verify changes don't break pipeline syntax

### 2. Jenkinsfile Modifications

**Before Editing**:
1. Read the entire Jenkinsfile
2. Understand the pipeline flow
3. Consider impact on existing stages
4. Validate Groovy syntax

**Testing Pipeline Changes**:
- Pipeline syntax errors will fail on Jenkins
- Test locally if possible using Jenkins linter
- Make incremental changes, not wholesale rewrites

### 3. Git Operations

**Pre-commit Checklist**:
- [ ] Verify you're on the correct branch
- [ ] Read affected files before modification
- [ ] Use descriptive commit messages
- [ ] Push to correct branch with retry logic

**Push Safety**:
```bash
# Always verify branch before pushing
git branch --show-current

# Push with upstream tracking
git push -u origin $(git branch --show-current)
```

### 4. Communication

- Keep responses concise (this is CLI environment)
- Use markdown for formatting
- Avoid emojis unless explicitly requested
- Output text directly, not through echo/printf

### 5. Security Considerations

When modifying Jenkinsfile, avoid:
- ❌ Hardcoded credentials
- ❌ Command injection vulnerabilities
- ❌ Unsanitized user input
- ❌ Overly permissive agent configurations

Instead:
- ✓ Use Jenkins credentials binding
- ✓ Validate inputs
- ✓ Use specific agent labels when possible
- ✓ Follow principle of least privilege

---

## Common Tasks

### Task 1: Add a New Pipeline Stage

**Steps**:
1. Read current Jenkinsfile
2. Add new stage within `stages` block
3. Follow existing indentation pattern
4. Commit with message: "add [stage-name] stage to pipeline"
5. Push to feature branch

**Example**:
```groovy
stage('Run Tests') {
    steps {
        echo "Running tests..."
        // Add test commands here
    }
}
```

### Task 2: Update Existing Stage

**Steps**:
1. Read Jenkinsfile to locate target stage
2. Use Edit tool to modify stage content
3. Preserve Groovy syntax and formatting
4. Commit with message: "update [stage-name] stage"
5. Push changes

### Task 3: Add Environment Variables

**Steps**:
1. Add `environment` block after `agent`:
```groovy
pipeline {
    agent any
    environment {
        VARIABLE_NAME = 'value'
    }
    stages {
        // ...
    }
}
```

### Task 4: Create Documentation

**Guidelines**:
- Create `.md` files only when explicitly requested
- Place documentation in repository root
- Use clear, hierarchical structure
- Keep examples practical and relevant

### Task 5: Debug Pipeline Failures

**Approach**:
1. Review Jenkins console output
2. Check syntax errors in Groovy code
3. Verify environment variables are available
4. Test stages incrementally
5. Add debug `echo` statements as needed

---

## Repository Evolution

This repository is in early stages. As it grows, consider:

1. **Adding a README.md**: Document repository purpose for humans
2. **Creating src/ directory**: Organize source code
3. **Adding tests/**: Include test files and test stages
4. **Adding .gitignore**: Exclude unnecessary files
5. **Creating documentation/**: Additional docs as needed
6. **Adding package files**: If becoming a full application (package.json, requirements.txt, etc.)

### Future Pipeline Enhancements

Consider adding stages for:
- **Linting**: Code quality checks
- **Security Scanning**: Vulnerability detection
- **Artifact Archival**: Save build outputs
- **Parallel Execution**: Run independent stages concurrently
- **Post Actions**: Cleanup, notifications, reporting

---

## Quick Reference

### Current State Summary
- **Files**: 1 (Jenkinsfile)
- **Lines of Code**: 12
- **Pipeline Stages**: 1 (Verify Branch)
- **Active Branch**: `claude/claude-md-mjyvvtwfre9zlmfh-DiDgT`
- **Last Commits**: Typo fixes and Jenkinsfile updates

### Essential Commands

```bash
# View repository status
git status

# View commit history
git log --oneline -10

# Check current branch
git branch --show-current

# View file contents
cat Jenkinsfile

# Push changes with retry
git push -u origin $(git branch --show-current) || \
  (sleep 2 && git push -u origin $(git branch --show-current)) || \
  (sleep 4 && git push -u origin $(git branch --show-current))
```

### File Locations

- **Jenkinsfile**: `/home/user/Test/Jenkinsfile`
- **This Guide**: `/home/user/Test/CLAUDE.md`
- **Repository Root**: `/home/user/Test/`

---

## Troubleshooting

### Issue: Push fails with 403 error
**Solution**: Verify branch name starts with `claude/` and ends with correct session ID

### Issue: Pipeline syntax error
**Solution**: Validate Groovy syntax, check for:
- Missing closing braces `}`
- Incorrect indentation
- Typos in stage/steps keywords

### Issue: Branch doesn't exist
**Solution**: Create branch locally first:
```bash
git checkout -b claude/claude-md-{session-id}
```

### Issue: Network errors on push
**Solution**: Use retry logic with exponential backoff (see Git Conventions section)

---

## Maintenance

**Update this file when**:
- Repository structure changes significantly
- New files or directories are added
- Pipeline stages are added/modified
- New conventions are established
- Dependencies are introduced

**Review Schedule**: Update after major changes or monthly, whichever comes first.

---

**Document Version**: 1.0
**Created**: 2026-01-03
**AI Assistant**: Claude (Sonnet 4.5)
**Repository Path**: `/home/user/Test/`
