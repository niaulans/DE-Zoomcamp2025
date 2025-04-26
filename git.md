### Tips 
1. Pull latest change from remote 
```bash
git pull origin master  # or the relevant branch
```
2. Create a branch for each feature or task
```bash
git checkout -b feature-xyz  # Replace 'feature-xyz' with the name of your feature/task
```
3. Commit change regularly
```bash
git add .
git commit -m "Add feature XYZ"
```
4. Before pushing, pull latest changes again 
```bash 
git pull origin master  # or the relevant branch
```
5. Handling conflicts (if any)
Mark as resolved
```bash
git add <conflicted_file>
```
Continue rebase or commit
```bash
git rebase --continue
```
6. Push change to remote
```bash
git push origin feature-xyz  # Replace with your branch name
```
If you did a rebase, use --force-with-lease to ensure you don’t overwrite others' changes:
```bash 
git push --force-with-lease origin feature-xyz
```
7. Always check status 
```bash
git status
git log --oneline
```
8. Use Pull Requests (PR) or Merge Requests (MR)
If you’re working on GitHub, GitLab, or Bitbucket, use Pull Requests (PR) or Merge Requests (MR) to merge your branch into the main branch (master or main). This allows team members to review your code before it gets merged and helps avoid large conflicts.

