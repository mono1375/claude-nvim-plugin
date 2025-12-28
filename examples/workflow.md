# Claude Neovim Plugin - Workflow Examples

## Example 1: Learning a New Framework

**Scenario:** You're learning FastAPI and want to create a REST API.

```bash
# 1. Create new project
mkdir my-api && cd my-api
nvim main.py
```

**In Neovim:**

```vim
" Step 1: Learn basics
<Space>ca
" Ask: "What is FastAPI and how do I create a simple API?"
" Read response in split

" Step 2: Generate starter code
<Space>cg
" Enter: "Create a basic FastAPI app with one GET endpoint that returns Hello World"
" Copy generated code to main.py

" Step 3: Add more features
<Space>ca
" Ask: "How do I add a POST endpoint to accept JSON data in FastAPI?"

" Step 4: Review your work
<Space>cr
" Get feedback on your code

" Step 5: Explain complex parts
v (select async code)
<Space>ce
" Ask: "Why do we use async/await here?"
```

---

## Example 2: Debugging a Bug

**Scenario:** Your Python code has a bug you can't figure out.

```python
# Buggy code in app.py
def calculate_average(numbers):
    total = 0
    for num in numbers:
        total += num
    return total / len(numbers)  # Bug: crashes on empty list
```

**Debugging workflow:**

```vim
" Step 1: Select the buggy function
V5j  " Visual line mode, select 5 lines
<Space>ce
" Ask: "What's wrong with this code? It crashes sometimes."

" Claude responds: "The function will raise ZeroDivisionError
" when the list is empty because len(numbers) will be 0"

" Step 2: Ask for fix
<Space>ca
" Ask: "How do I fix the division by zero error in calculate_average?"

" Step 3: Generate fixed version
<Space>cg
" Enter: "Rewrite calculate_average with proper error handling"

" Step 4: Review final code
<Space>cr
```

---

## Example 3: Code Review Before Pull Request

**Scenario:** You've finished a feature and want to ensure quality before PR.

```bash
nvim src/user_auth.py
```

**Review workflow:**

```vim
" Step 1: Full file review
<Space>cr
" Get comprehensive review

" Step 2: Address each issue
" For each suggestion from Claude:

" - Select problematic code
v (movement)
<Space>ce
" Ask: "How should I refactor this?"

" - Make changes

" Step 3: Review security
<Space>ca
" Ask: "Are there any security issues in this authentication code?"

" Step 4: Check best practices
<Space>ca
" Ask: "Does this code follow Python best practices?"

" Step 5: Final review
<Space>cr

" Step 6: Commit
:q
# In terminal:
git add src/user_auth.py
git commit -m "Add user authentication with security review"
```

---

## Example 4: Refactoring Legacy Code

**Scenario:** You have old, messy code that needs refactoring.

```python
# legacy.py - messy code
def process_data(d):
    r = []
    for i in d:
        if i > 0:
            r.append(i * 2)
    return r
```

**Refactoring workflow:**

```vim
" Step 1: Understand what it does
V4j  " Select function
<Space>ce
" Ask: "Explain what this function does"

" Step 2: Ask for modern version
<Space>ca
" Ask: "How can I rewrite this function to be more Pythonic?"

" Step 3: Generate refactored version
<Space>cg
" Enter: "Refactor process_data using list comprehension and type hints"

" Step 4: Compare and learn
" Keep split open with suggestion
" Implement changes
" Ask follow-up questions

" Step 5: Review refactored code
<Space>cr
```

---

## Example 5: Learning from Open Source

**Scenario:** You're reading a complex open source project.

```bash
git clone https://github.com/some/project
cd project
nvim src/core/engine.py
```

**Learning workflow:**

```vim
" Step 1: Get overview
<Space>cr
" Understand file structure

" Step 2: Explain confusing patterns
v (select decorator)
<Space>ce
" Ask: "What does this decorator do?"

v (select class)
<Space>ce
" Ask: "Explain this design pattern"

" Step 3: Understand algorithms
v (select complex algorithm)
<Space>ce
" Ask: "Explain this algorithm step by step"

" Step 4: Learn idioms
v (select Python idiom)
<Space>ce
" Ask: "Why is this pattern used instead of a simple loop?"

" Step 5: Document your learnings
<Space>ca
" Ask: "Summarize the key concepts in this file"
```

---

## Example 6: Test-Driven Development

**Scenario:** Writing tests for a function.

```bash
nvim test_calculator.py
```

**TDD workflow:**

```vim
" Step 1: Generate test cases
<Space>cg
" Enter: "Create pytest test cases for a calculator add function"

" Step 2: Understand test structure
v (select test)
<Space>ce
" Ask: "Explain this pytest test structure"

" Step 3: Add edge cases
<Space>ca
" Ask: "What edge cases should I test for a calculator add function?"

" Step 4: Generate edge case tests
<Space>cg
" Enter: "Create pytest tests for edge cases: None inputs, overflow, type errors"

" Step 5: Review test coverage
<Space>cr
```

---

## Example 7: API Integration

**Scenario:** Integrating with a third-party API.

```bash
nvim api_client.py
```

**Integration workflow:**

```vim
" Step 1: Learn API basics
<Space>ca
" Ask: "How do I make authenticated requests to the GitHub API in Python?"

" Step 2: Generate client code
<Space>cg
" Enter: "Create a GitHub API client class with authentication and error handling"

" Step 3: Add specific endpoint
<Space>ca
" Ask: "How do I fetch repository issues from GitHub API?"

" Step 4: Handle errors
v (select error handling code)
<Space>ce
" Ask: "Is this error handling sufficient for production?"

" Step 5: Review security
<Space>ca
" Ask: "How should I securely store the API token?"

" Step 6: Final review
<Space>cr
```

---

## Example 8: Performance Optimization

**Scenario:** Code is slow and needs optimization.

```python
# slow_function.py
def process_users(users):
    results = []
    for user in users:
        for item in user.items:
            for tag in item.tags:
                if tag.active:
                    results.append(tag.name)
    return results
```

**Optimization workflow:**

```vim
" Step 1: Identify bottleneck
V8j
<Space>ce
" Ask: "What's the time complexity of this code? How can it be optimized?"

" Step 2: Get optimization suggestions
<Space>ca
" Ask: "What are the most effective ways to optimize this nested loop?"

" Step 3: Generate optimized version
<Space>cg
" Enter: "Rewrite process_users using list comprehension and filtering"

" Step 4: Compare approaches
<Space>ca
" Ask: "Compare nested loops vs list comprehension for this use case"

" Step 5: Review performance
<Space>cr
```

---

## Example 9: Documentation Writing

**Scenario:** Adding docstrings and comments.

```bash
nvim utils.py
```

**Documentation workflow:**

```vim
" Step 1: Select function
v (select function)
<Space>ce
" Ask: "Write a comprehensive docstring for this function"

" Copy docstring from response
" Paste into code

" Step 2: Generate examples
<Space>ca
" Ask: "Provide usage examples for this function"

" Step 3: Review documentation
<Space>cr

" Step 4: Add inline comments for complex parts
v (select complex code)
<Space>ce
" Ask: "What inline comments would help explain this?"
```

---

## Example 10: Multi-file Refactor

**Scenario:** Refactoring across multiple files.

```bash
nvim src/models.py
```

**Multi-file workflow:**

```vim
" File 1: models.py
<Space>cr
" Note suggestions

" File 2: views.py
:e src/views.py
<Space>ca
" Ask: "How will changing models.py affect this views.py file?"

" File 3: tests.py
:e tests/test_models.py
<Space>ca
" Ask: "What tests need to be updated if I change the User model?"

" Coordinate changes
<Space>ca
" Ask: "Create a checklist for refactoring the User model across models, views, and tests"

" Final review of each file
<Space>cr
```

---

## Tips for Effective Workflows

### 1. Start with Questions
Always begin with `<Space>ca` to understand before coding.

### 2. Generate, Then Customize
Use `<Space>cg` for boilerplate, then adapt to your needs.

### 3. Review Regularly
Run `<Space>cr` after major changes.

### 4. Explain What You Don't Understand
Select and `<Space>ce` on confusing code.

### 5. Keep Splits for Reference
Don't immediately close Claude's responses - keep them open for reference.

### 6. Iterate
Ask follow-up questions with `<Space>ca` to dive deeper.

### 7. Document Your Learning
Copy important explanations to comments or notes.

---

**These workflows show how Claude becomes your AI pair programmer!** 🚀
