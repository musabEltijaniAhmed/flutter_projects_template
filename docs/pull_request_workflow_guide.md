# Pull Request & Branch Workflow Management Guide (.md)

This comprehensive guide explains how to manage Git workflows, enforce branch protection, and handle Pull Requests (PRs) professionally within software teams. It includes detailed CLI commands and instructions for Android Studio.

---

## 🧭 Project Workflow Overview

1. Fetch all remote branches.
2. Create or switch to a feature branch.
3. Work on code.
4. Push changes to remote.
5. Open Pull Request (PR) to `dev`.
6. Review, test, approve or request changes.
7. Merge into `dev` (then later into `pre-release` → `main` by admin).

---

## 🔄 Step 1: Fetch All Remote Branches

### 🧪 Command:

```bash
git fetch --all
```

### 📱 Android Studio:

* Go to **VCS → Git → Fetch**
* Or use the Git widget in the bottom toolbar → click the dropdown → **Fetch All**

This ensures your local Git knows about **all branches** on remote.

---

## 🌿 Step 2: Switch/Create Feature Branch

### 🧪 Command:

```bash
git checkout -b feature/your-feature-name origin/dev
```

### 📱 Android Studio:

* Go to Git tab → Click on Branch name (bottom-right) → **+ New Branch from dev**

---

## 🧪 Step 3: Test and Merge dev Updates into Your Branch (optional)

### 🧪 Command:

```bash
git checkout feature/your-feature-name
git pull origin dev
```

(Resolve any conflicts if needed)

### 📱 Android Studio:

* Git tab → Select dev → Right-click → **Merge into current**
* Resolve conflicts if any → Commit Merge

---

## ☁️ Step 4: Push Your Feature

### 🧪 Command:

```bash
git push origin feature/your-feature-name
```

### 📱 Android Studio:

* VCS → Git → Push (or use ⬆️ icon in top toolbar)

---

## 📩 Step 5: Create Pull Request to `dev`

1. Go to GitHub → Your Repo
2. GitHub usually detects your pushed branch and suggests creating a PR.
3. Make sure the **base** is `dev`, not `main`.
4. Add title and description.
5. Assign reviewers.

### PR Options:

* ✅ **Create Draft PR**: Use this if work is in progress.
* ✅ **Ready for Review**: Makes it visible for merging.

---

## 🔍 Step 6: Code Review, Testing, and Discussion

### ✅ Reviewers can:

* Comment on lines.
* Use **"Request changes"** or **"Approve"**.

### PR Options Explained:

| Option            | Description                                   |
| ----------------- | --------------------------------------------- |
| `Approve`         | Accept the PR for merging.                    |
| `Request Changes` | Reviewer blocks merge until updates are done. |
| `Comment`         | General feedback without blocking.            |

### 🔁 How to Test Code Before Approving:

1. Pull the branch locally:

```bash
git fetch origin pull/ID/head:pr-test
```

2. Checkout:

```bash
git checkout pr-test
```

3. Run app, check for exceptions.

---

## 🔀 Step 7: Merge PR into `dev`

You will see options like:

| Merge Method              | Use When                              |
| ------------------------- | ------------------------------------- |
| **Create a merge commit** | Default. Keeps full history.          |
| **Squash and merge**      | For small/one-commit PRs.             |
| **Rebase and merge**      | Keeps linear history. Advanced usage. |

After merge:

* PR is closed.
* Code lands in `dev`.

---

## 🔐 Protecting dev/main/pre-release Branches

Use **Rulesets** as explained earlier in the file. For `main` and `pre-release`, allow merge only from `dev` or by admins.

---

## 🧰 Final Tips

* Always double-check base branch when creating a PR.
* Use **branch naming** like `feature/`, `hotfix/`, `bugfix/`.
* PR should always be reviewed, tested, and commented.
* Avoid merging to `main` directly – use `pre-release` for staging first.

---

Continue expanding with more examples or linking to automation (e.g. GitHub Actions for testing).
