---
title: 《Bioinformatics Data Skills》目录一览
date: '2018-04-29'
slug: content-of-bioinformatics-data-skills
categories: 
  - books
tags: 
  - bioinformatics
  - books
---

## 概览

>This book is the answer to a question I asked myself two years ago: “What book would
I want to read first when getting started in bioinformatics?” --- [Vince Buffalo](https://github.com/vsbuffalo/)

- Part I, containing one chapter on ideology; 
- Part II, which covers the basics of getting started with a bioinformatics project; 
- Part III, which covers bioinformatics data skills

## 目录

```
Preface
    The Approach of This Book
    Why This Book Focuses on Sequencing Data
    Audience
    The Difficulty Level of Bioinformatics Data Skills
    Assumptions This Book Makes
    Supplementary Material on GitHub
    Computing Resources and Setup
    Organization of This Book
    Code Conventions
    Conventions Used in This Book
    Using Code Examples
    Safari® Books Online
    How to Contact Us
    Acknowledgments
I. Ideology: Data Skills for Robust and Reproducible Bioinformatics
1. How to Learn Bioinformatics
    Why Bioinformatics? Biology’s Growing Data
    Learning Data Skills to Learn Bioinformatics
    New Challenges for Reproducible and Robust Research
    Reproducible Research
    Robust Research and the Golden Rule of Bioinformatics
    Adopting Robust and Reproducible Practices Will Make Your Life Easier, Too
    Recommendations for Robust Research
        Pay Attention to Experimental Design
        Write Code for Humans, Write Data for Computers
        Let Your Computer Do the Work For You
        Make Assertions and Be Loud, in Code and in Your Methods
        Test Code, or Better Yet, Let Code Test Code
        Use Existing Libraries Whenever Possible
        Treat Data as Read-Only
        Spend Time Developing Frequently Used Scripts into Tools
        Let Data Prove That It’s High Quality
    Recommendations for Reproducible Research
        Release Your Code and Data
        Document Everything
        Make Figures and Statistics the Results of Scripts
        Use Code as Documentation
    Continually Improving Your Bioinformatics Data Skills
II. Prerequisites: Essential Skills for Getting Started with a Bioinformatics Project
2. Setting Up and Managing a Bioinformatics Project
    Project Directories and Directory Structures
    Project Documentation
    Use Directories to Divide Up Your Project into Subprojects
    Organizing Data to Automate File Processing Tasks
    Markdown for Project Notebooks
        Markdown Formatting Basics
        Using Pandoc to Render Markdown to HTML
3. Remedial Unix Shell
    Why Do We Use Unix in Bioinformatics? Modularity and the Unix Philosophy
    Working with Streams and Redirection
        Redirecting Standard Out to a File
        Redirecting Standard Error
        Using Standard Input Redirection
    The Almighty Unix Pipe: Speed and Beauty in One
        Pipes in Action: Creating Simple Programs with Grep and Pipes
        Combining Pipes and Redirection
        Even More Redirection: A tee in Your Pipe
    Managing and Interacting with Processes
        Background Processes
        Killing Processes
        Exit Status: How to Programmatically Tell Whether Your Command Worked
    Command Substitution
4. Working with Remote Machines
    Connecting to Remote Machines with SSH
    Quick Authentication with SSH Keys
    Maintaining Long-Running Jobs with nohup and tmux
        nohup
    Working with Remote Machines Through Tmux
        Installing and Configuring Tmux
        Creating, Detaching, and Attaching Tmux Sessions
        Working with Tmux Windows
5. Git for Scientists
    Why Git Is Necessary in Bioinformatics Projects
    Git Allows You to Keep Snapshots of Your Project
    Git Helps You Keep Track of Important Changes to Code
    Git Helps Keep Software Organized and Available After People Leave
    Installing Git
    Basic Git: Creating Repositories, Tracking Files, and Staging and Committing Changes
    Git Setup: Telling Git Who You Are
        git init and git clone: Creating Repositories
        Tracking Files in Git: git add and git status Part I
        Staging Files in Git: git add and git status Part II
        git commit: Taking a Snapshot of Your Project
        Seeing File Differences: git diff
        Seeing Your Commit History: git log
        Moving and Removing Files: git mv and git rm
        Telling Git What to Ignore: .gitignore
        Undoing a Stage: git reset
    Collaborating with Git: Git Remotes, git push, and git pull
        Creating a Shared Central Repository with GitHub
        Authenticating with Git Remotes
        Connecting with Git Remotes: git remote
        Pushing Commits to a Remote Repository with git push
        Pulling Commits from a Remote Repository with git pull
        Working with Your Collaborators: Pushing and Pulling
        Merge Conflicts
        More GitHub Workflows: Forking and Pull Requests
    Using Git to Make Life Easier: Working with Past Commits
        Getting Files from the Past: git checkout
        Stashing Your Changes: git stash
        More git diff: Comparing Commits and Files
        Undoing and Editing Commits: git commit --amend
    Working with Branches
        Creating and Working with Branches: git branch and git checkout
        Merging Branches: git merge
        Branches and Remotes
    Continuing Your Git Education
6. Bioinformatics Data
    Retrieving Bioinformatics Data
        Downloading Data with wget and curl
            wget
            Curl
        Rsync and Secure Copy
    Data Integrity
        SHA and MD5 Checksums
Looking at Differences Between Data
Compressing Data and Working with Compressed Data
    gzip
    Working with Gzipped Compressed Files
Case Study: Reproducibly Downloading Data

III. Practice: Bioinformatics Data Skills
7. Unix Data Tools
    Unix Data Tools and the Unix One-Liner Approach: Lessons from Programming Pearls
    When to Use the Unix Pipeline Approach and How to Use It Safely
    Inspecting and Manipulating Text Data with Unix Tools
        Inspecting Data with Head and Tail
        less
        Plain-Text Data Summary Information with wc, ls, and awk
        Working with Column Data with cut and Columns
        Formatting Tabular Data with column
        The All-Powerful Grep
        Decoding Plain-Text Data: hexdump
        Sorting Plain-Text Data with Sort
        Finding Unique Values in Uniq
        Join
        Text Processing with Awk
        Bioawk: An Awk for Biological Formats
        Stream Editing with Sed
    Advanced Shell Tricks
        Subshells
        Named Pipes and Process Substitution
    The Unix Philosophy Revisited

8. A Rapid Introduction to the R Language
    Getting Started with R and RStudio
    R Language Basics
        Simple Calculations in R, Calling Functions, and Getting Help in R
        Variables and Assignment
        Vectors, Vectorization, and Indexing
            Vector types
            Factors and classes in R
    Working with and Visualizing Data in R
        Loading Data into R
        Exploring and Transforming Dataframes
        Exploring Data Through Slicing and Dicing: Subsetting Dataframes
        Exploring Data Visually with ggplot2 I: Scatterplots and Densities
        Exploring Data Visually with ggplot2 II: Smoothing
        Binning Data with cut
        Merging and Combining Data: Matching Vectors and Merging Dataframes
        Using ggplot2 Facets
        More R Data Structures: Lists
        Writing and Applying Functions to Lists with lapply
            Using lapply
            Writing functions
            Digression: Debugging R Code
            More list apply functions: sapply
        Working with the Split-Apply-Combine Pattern
        Exploring Dataframes with dplyr
        Working with Strings
    Developing Workflows with R Scripts
        Control Flow: if, for, and while
        Working with R Scripts
        Workflows for Loading and Combining Multiple Files
        Exporting Data
    Further R Directions and Resources
9. Working with Range Data
    A Crash Course in Genomic Ranges and Coordinate Systems
    An Interactive Introduction to Range Data with GenomicRanges
        Installing and Working with Bioconductor Packages
        Storing Generic Ranges with IRanges
        Basic Range Operations: Arithmetic, Transformations, and Set Operations
        Finding Overlapping Ranges
        Finding Nearest Ranges and Calculating Distance
        Run Length Encoding and Views
            Run-length encoding and coverage
            Going from run-length encoded sequences to ranges with slice
            Advanced IRanges: Views
        Storing Genomic Ranges with GenomicRanges
        Grouping Data with GRangesList
        Working with Annotation Data: GenomicFeatures and rtracklayer
        Retrieving Promoter Regions: Flank and Promoters
        Retrieving Promoter Sequence: Connection GenomicRanges with Sequence Data
        Getting Intergenic and Intronic Regions: Gaps, Reduce, and Setdiffs in Practice
        Finding and Working with Overlapping Ranges
        Calculating Coverage of GRanges Objects
    Working with Ranges Data on the Command Line with BEDTools
        Computing Overlaps with BEDTools Intersect
        BEDTools Slop and Flank
        Coverage with BEDTools
        Other BEDTools Subcommands and pybedtools
10. Working with Sequence Data
    The FASTA Format
    The FASTQ Format
    Nucleotide Codes
    Base Qualities
    Example: Inspecting and Trimming Low-Quality Bases
    A FASTA/FASTQ Parsing Example: Counting Nucleotides
    Indexed FASTA Files
11. Working with Alignment Data
    Getting to Know Alignment Formats: SAM and BAM
        The SAM Header
        The SAM Alignment Section
        Bitwise Flags
        CIGAR Strings
        Mapping Qualities
    Command-Line Tools for Working with Alignments in the SAM Format
        Using samtools view to Convert between SAM and BAM
        Samtools Sort and Index
        Extracting and Filtering Alignments with samtools view
            Extracting alignments from a region with samtools view
            Filtering alignments with samtools view
    Visualizing Alignments with samtools tview and the Integrated Genomics Viewer
        Pileups with samtools pileup, Variant Calling, and Base Alignment Quality
    Creating Your Own SAM/BAM Processing Tools with Pysam
        Opening BAM Files, Fetching Alignments from a Region, and Iterating Across Reads
        Extracting SAM/BAM Header Information from an AlignmentFile Object
        Working with AlignedSegment Objects
        Writing a Program to Record Alignment Statistics
        Additional Pysam Features and Other SAM/BAM APIs
12. Bioinformatics Shell Scripting, Writing Pipelines, and Parallelizing Tasks
    Basic Bash Scripting
        Writing and Running Robust Bash Scripts
            A robust Bash header
            Running Bash scripts
        Variables and Command Arguments
            Command-line arguments
        Conditionals in a Bash Script: if Statements
        Processing Files with Bash Using for Loops and Globbing
    Automating File-Processing with find and xargs
        Using find and xargs
        Finding Files with find
        find’s Expressions
        find’s -exec: Running Commands on find’s Results
        xargs: A Unix Powertool
        Using xargs with Replacement Strings to Apply Commands to Files
        xargs and Parallelization
    Make and Makefiles: Another Option for Pipelines
13. Out-of-Memory Approaches: Tabix and SQLite
    Fast Access to Indexed Tab-Delimited Files with BGZF and Tabix
        Compressing Files for Tabix with Bgzip
        Indexing Files with Tabix
        Using Tabix
    Introducing Relational Databases Through SQLite
        When to Use Relational Databases in Bioinformatics
        Installing SQLite
        Exploring SQLite Databases with the Command-Line Interface
        Querying Out Data: The Almighty SELECT Command
            Limiting results with LIMIT
            Selecting columns with SELECT
            Ordering rows with ORDER BY
            Filtering which rows with WHERE
        SQLite Functions
        SQLite Aggregate Functions
            Grouping rows with GROUP BY
        Subqueries
        Organizing Relational Databases and Joins
            Organizing relational databases
            Inner joins
            Left outer joins
        Writing to Databases
            Creating tables
            Inserting records into tables
            Indexing
        Dropping Tables and Deleting Databases
        Interacting with SQLite from Python
            Connecting to SQLite databases and creating tables from Python
            Loading data into a table from Python
        Dumping Databases
14. Conclusion
    Where to Go From Here?
Glossary
Bibliography
Index
```

## 电子书

[Bioinformatics Data Skills](http://bioinfo.rjh.com.cn/download/books/2015_Bioinformatics_data_skills.pdf)
