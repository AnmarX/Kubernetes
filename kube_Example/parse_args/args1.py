#!/usr/bin/env python3
import argparse
import subprocess

def run_shell_command(command):
    """Run a shell command and return its output or error."""
    try:
        result = subprocess.run(
            command,
            shell=True,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return e.stderr.strip()

def main():
    parser = argparse.ArgumentParser(
        description="A simple CLI tool that executes a shell command and captures its output."
    )
    parser.add_argument("command", help="The shell command to execute (e.g., \"echo 'Hello, World!'\")")
    args = parser.parse_args()

    output = run_shell_command(args.command)
    print("\n--- Command Output ---")
    print(output)

if __name__ == "__main__":
    main()
