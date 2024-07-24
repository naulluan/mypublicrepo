import requests
import pandas as pd

# Define your GitLab URL and access token
GITLAB_URL = 'http://your-gitlab-instance.com'
ACCESS_TOKEN = 'your_access_token'

# Function to get all repositories
def get_all_repositories():
    url = f"{GITLAB_URL}/api/v4/projects"
    headers = {"PRIVATE-TOKEN": ACCESS_TOKEN}
    repositories = []
    page = 1

    while True:
        params = {'per_page': 100, 'page': page}
        response = requests.get(url, headers=headers, params=params)
        if response.status_code == 200:
            repos = response.json()
            if not repos:
                break
            repositories.extend(repos)
            page += 1
        else:
            print(f"Failed to fetch repositories. Status Code: {response.status_code}")
            break

    return repositories

# Function to get commits for a user in a specific repository
def get_commits(user, repo_id):
    url = f"{GITLAB_URL}/api/v4/projects/{repo_id}/repository/commits"
    headers = {"PRIVATE-TOKEN": ACCESS_TOKEN}
    params = {"author": user}
    response = requests.get(url, headers=headers, params=params)
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Failed to fetch commits for user {user} in repo {repo_id}. Status Code: {response.status_code}")
        return []

# Read the list of users from the CSV file
user_list = pd.read_csv('list.csv')

# Fetch all repositories
repositories = get_all_repositories()

# Fetch commits for each user and repository
commit_data = []

for user in user_list['username']:
    for repo in repositories:
        commits = get_commits(user, repo['id'])
        for commit in commits:
            commit_data.append({
                'user': user,
                'repo': repo['name'],
                'commit_id': commit['id'],
                'message': commit['message'],
                'created_at': commit['created_at']
            })

# Convert the commit data to a DataFrame and save it to a CSV file
commit_df = pd.DataFrame(commit_data)
commit_df.to_csv('commits.csv', index=False)

print("Commit data saved to commits.csv")
