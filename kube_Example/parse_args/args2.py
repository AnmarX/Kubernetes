#!/usr/bin/env python3
import argparse
import subprocess
import sys

def run_command(command):
    """Execute a shell command and stream output in real time."""
    print(f"\n🟢 Running: {command}\n")
    process = subprocess.Popen(
        command,
        shell=True,
        stdout=sys.stdout,
        stderr=sys.stderr
    )
    process.communicate()
    if process.returncode != 0:
        sys.exit(process.returncode)

def main():
    parser = argparse.ArgumentParser(
        description="A simple CLI tool that executes a shell command and streams its output in real time."
    )
    parser.add_argument("command", help="The shell command to execute (e.g., \"echo Hello, World!\")")
    args = parser.parse_args()

    run_command(args.command)

if __name__ == "__main__":
    main()
