#!/bin/sh

interface=$(sed -n '1p' /root/666-main/settings.cfg)
firmware=$(sed -n '2p' /root/666-main/settings.cfg)

# capture the output of uname -m
machine_arch=$(uname -m)

# choose script based on the architecture
if echo "$machine_arch" | grep -q "arch64"; then
    script_name="pppwn_arch64"
elif echo "$machine_arch" | grep -q "armv7"; then
    script_name="pppwn_armv7"
elif echo "$machine_arch" | grep -q "x86_64"; then
    script_name="pppwn_x86_64"
elif echo "$machine_arch" | grep -q "mips"; then
    script_name="pppwn_mips"
else
    echo "Unsupported architecture: $machine_arch"
    exit 1
fi

# kill any previous instance
/root/666-main/kill.sh

# Construct and execute the command with the chosen script
/root/666-main/${script_name} --interface $interface --fw $firmware --stage1 /root/666-main/stage1_$firmware.bin --stage2 /root/666-main/stage2_$firmware.bin --auto-retry 
