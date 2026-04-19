import urllib.request
import json

CURRENT_VERSION = "v1"
REPO = "yeppoip/Push-terminal"

print("Checking for updates...")

try:
    url = f"https://api.github.com/repos/{REPO}/releases/latest"
    req = urllib.request.Request(url, headers={"User-Agent": "Push-Terminal"})
    with urllib.request.urlopen(req) as response:
        data = json.loads(response.read().decode())
        latest = data["tag_name"]
        name = data["name"]
        body = data["body"]

    if latest == CURRENT_VERSION:
        print(f"You are up to date! ({CURRENT_VERSION})")
    else:
        print(f"Update available: {latest} ({name})")
        print(f"You have: {CURRENT_VERSION}")
        print(f"\nChangelog:\n{body}")
        print(f"\nDownload: https://github.com/{REPO}/releases/latest")

except Exception as e:
    print(f"Failed to check for updates: {e}")