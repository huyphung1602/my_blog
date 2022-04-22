---
title: "Reading Note: Version Control System"
tags: software
---

Version control/source control systems allow developers to track and control changes to code over time. These services often include the abilities:

- Make atomic revisions to code
- Branch/fork off of specific points
- Compare versions of code.

They are useful in determining the who, what, when, and why code changes are made.

## Benefits

**Document History**: The version control system also contains the information of the author, date, and notes on each change. The complete history will help us:

- Go back to the previous versions to define the root cause of a bug.
- Go back to a stable version in case we need to revert an incident on Production.

**Branching and Merging**:

- Branching allows a team member to work on the same file concurrently. The changes are independent without affecting the contribution of the collaborators.
- Merging allows team members to merge other members' independent works without conflicts.

**Traceability**: A version control system provides evidence of all revisions and changes over time.

- Traceability helps us to work effectively with legacy code.
- Traceability helps us to estimate future work with any accuracy.

## Types of Version Control System

- Local Version Control Systems
- Centralized Version Control Systems
- Distributed Version Control Systems

**Local Version Control Systems** maintain track of files in the local system. Every file is stored as a patch. Every patch set contains only the changes made to the file since its last version.

**Centralized Version Control Systems** tracked all the changes in the files under the centralized server. The centralized server includes all the information of versioned files and a list of clients that check out files from that central place.

In **Distributed Version Control Systems**, the clients clone the repository including its full history. If any server dies, any of the client repositories can be copied onto the server which helps restore the server.

Each clone can be considered as a full backup of all the data.

## Concepts related to Version Control System

**Repository** is the central defined place where all the team members work and store their code. It also maintains the history.

**Trunk** is where you keep your main line of development. It is the directory where all the developments take place. All the check-outs are committed by the team members.

**Tags** help create snapshots of the project. Creating tags will keep descriptive and memorable names to a specific version in the repository.

**Branches** are the copy of code derived from a certain point in the trunk. If the changes work according to plan, we will merge back the changes on a branch to the trunk.

**Working copy:** It is the snapshot of the repository where the team member is actively working on it. Each team member has their working copy.

**Commit changes:** Committing code is the process of storing changes from the working copy to the central server. Commit is an atomic operation. When successful commit changes are made, other team members can pull these changes to update their working copy.

## References

- <https://www.atlassian.com/git/tutorials/what-is-version-control>
- <https://reqtest.com/requirements-blog/what-are-benefits-of-version-control/>
- <https://blog.eduonix.com/software-development/learn-three-types-version-control-systems/>
- <https://www.geeksforgeeks.org/version-control-systems/>
