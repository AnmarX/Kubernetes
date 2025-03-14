import argparse
import subprocess
import sys

def run_command(command):
    """Execute a shell command and stream output in real time"""
    print(f"\n🟢 Running: {command}\n")
    process = subprocess.Popen(command, shell=True, stdout=sys.stdout, stderr=sys.stderr)
    process.communicate()
    if process.returncode != 0:
        sys.exit(process.returncode)

def main():
    parser = argparse.ArgumentParser(
        usage="python3 ImageBuildScript.py --image <IMAGE> -t <TAG>",
        description="🚀 A CLI tool to build, tag, and push a Docker image."
    )

    parser.add_argument("-i", "--image", required=True, metavar="", help="Docker image name (e.g., username/app)")

    parser.add_argument("-t", "--tag", required=True, metavar="", help="Docker image tag (e.g., latest, v1.0)")

    parser.add_argument("--path", default=".", metavar="", help="Path to the Dockerfile directory (default: current directory)")
    
    parser.add_argument("--no-cache", action="store_true", help="Build without cache")

    args = parser.parse_args()

    print(f"\n🔍 DEBUG INFO:")
    print(f"   args.image     = {args.image}")
    print(f"   args.tag       = {args.tag}")
    print(f"   args.path      = {args.path}")
    print(f"   args.no_cache  = {args.no_cache}\n")

    image_full_name = f"{args.image}:{args.tag}"

    # Step 1: Build the Docker Image
    build_command = f"docker build {'--no-cache' if args.no_cache else ''} -t {image_full_name} {args.path}"
    print(f"🛠 DEBUG: Running command: {build_command}")  
    run_command(build_command)

    # Step 2: Tag the Image (Tag it as "latest" too)
    latest_tag = f"{args.image}:{args.tag}"
    tag_command = f"docker tag {image_full_name} anmar000/{latest_tag}"
    print(f"🛠 DEBUG: Running command: {tag_command}")  
    run_command(tag_command)

    # Step 3: Push the Image to Repository
    push_command = f"docker push anmar000/{image_full_name}"
    print(f"🛠 DEBUG: Running command: {push_command}")  
    run_command(push_command)


    print(f"\n✅ Successfully Built and Pushed: {image_full_name} and {latest_tag}")

if __name__ == "__main__":
    main()
