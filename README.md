# Binance-Masterclass-Demo-Show
Demo Show - Group 11
## Farming and Staking project
Please do create a new branch and commit your changes there.

We will review the code before merging it into `master`.

# Workflow Instructions

## Working on a new task
1. Switch to the `develop` branch
2. Pull the latest code from `develop`
3. Create a new branch
4. Push new branch to remote

### Commands
```
git checkout develop
git pull
git checkout -b <branch-name>
git push -u origin <branch-name>
```

## Creating a new pull request
1. Stage all your changes
2. Commit changes
3. Switch to the `develop` branch
4. Pull the latest code from `develop`
5. Switch back to your own branch
6. Merge `develop` to your branch
7. Fix conflicts** if any
8. Push changes to your branch
9. Go to https://github.com/MasterclassGroup11/DemoShow/branches and click on the "New Pull Request" button

### Commands
```
git add .
git commit -m "<your-message>"
git checkout develop
git pull
git checkout <your-branch>
git merge develop
# fix conflicts if any - then add, then commit
git push
# go to the branches and create a PR
```

## Fixing Conflicts
When fixing conflicts, ensure that there's no `<==== HEAD` anywhere in your code. If `__pycache__` folders are causing conflicts, you can just delete them.
