From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Two questions on perf dwarf callchains
Date: Fri, 17 Jan 2014 11:21:23 +0100
Message-ID: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:55685 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaAQKV1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jan 2014 05:21:27 -0500
Received: by mail-ee0-f47.google.com with SMTP id d49so1248016eek.6
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2014 02:21:25 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Mauro Andreolini <mauro.andreolini@gmail.com>

Hi all,

I have installed a textual Arch Linux guest (the hypervisor
is KVM) and I am playing with perf and dwarf callchains.
In particular, I am trying to get meaningful stacktraces
for a simple command such as "ls -lR /".

Here is what I did.
* recompile the kernel with
  CONFIG_DEBUG_INFO=y
  CONFIG_FRAME_POINTER=Y
* recompile the C library with symbols (-g)
* recompile all other dependencies of "ls" (ldd /usr/bin/ls)
  with symbols (on my system, that would be libcap, libacl,
  libattr)
* recompile the coreutils package with symbols

After that, I executed the following commands:
perf record --call-graph dwarf -g -- ls -lR /
<wait 10s; hit CTRL-C>
perf report --call-graph --stdio

I hit two problems.
Problem n.1: perf report warns me about missing kernel symbols.

No kallsyms or vmlinux with build-id 4c6ab941f31dde04c2a481430218994849927c8d was found
[ext4] with build id 4c6ab941f31dde04c2a481430218994849927c8d not found, continuing without symbols
No kallsyms or vmlinux with build-id 21f163b0a8a8b924efdd173b8f83ad723d378958 was found
[drm] with build id 21f163b0a8a8b924efdd173b8f83ad723d378958 not found, continuing without symbols
No kallsyms or vmlinux with build-id d0bd7dd69886c2dccde18dee760b6d39cc0b5a55 was found[qxl] with build id d0bd7dd69886c2dccde18dee760b6d39cc0b5a55 not found, continuing without symbols
No kallsyms or vmlinux with build-id 8d13e6f0c4d4f8b4628c8c4bd6c660b0a00576df was found[ttm] with build id 8d13e6f0c4d4f8b4628c8c4bd6c660b0a00576df not found, continuing without symbols
...
#
# Samples: 4K of event 'cpu-clock'
# Event count (approx.): 1201250000
#
# Overhead  Command      Shared Object
Symbol
# ........  .......  .................  .................................
...
     7.12%       ls  [qxl]              [k] 0x0000000000009b20 <--- HERE
                 |
                 |--4.09%-- 0xffffffffa048c2c2
                 |          |
                 |          |--42.86%-- 0xffffffffa048ee8b
                 |          |          0xffffffffa048ba8f
                 |          |          bit_bmove
                 |          |          fbcon_redraw_blit.isra.22
                 |          |          fbcon_scroll
                 |          |          scrup
                 |          |          lf
                 |          |          do_con_trol
                 |          |          do_con_write.part.18
                 |          |          con_write
                 |          |          do_output_char
                 |          |          n_tty_write
                 |          |          tty_write
                 |          |          vfs_write
                 |          |          sys_write
                 |          |          system_call_fastpath
                 |          |          __GI___libc_write

For example, the 0x0000000000009b20 address should refer to some
function in the qxl module for which no symbol was generated. As far as
I could understand, perf does not seem to be able to extract symbol
information from compressed modules. I had to decompress the qxl.ko.gz
file to get perf report to print the function names.
Is this expected behaviour? How do I get perf to automatically extract
symbols from compressed files?

Problem n.2: sometimes perf prints bogus callchains (in particular
when the various printf() variants are involved).

                 |--1.46%-- 0xffffffffa048a275
                 |          0xffffffffa048c110
                 |          0xffffffffa04909e7
                 |          |
                 |          |--80.00%-- 0xffffffffa0490afa
                 |          |          0xffffffffa048ee8b
                 |          |          0xffffffffa048ba8f
                 |          |          bit_bmove
                 |          |          fbcon_redraw_blit.isra.22
                 |          |          fbcon_scroll
                 |          |          scrup
                 |          |          lf
                 |          |          do_con_trol
                 |          |          do_con_write.part.18
                 |          |          con_write
                 |          |          do_output_char
                 |          |          n_tty_write
                 |          |          tty_write
                 |          |          vfs_write
                 |          |          sys_write
                 |          |          system_call_fastpath
                 |          |          __GI___libc_write
                 |          |          |
                 |          |          |--50.00%-- vfprintf
                 |          |          |          0x0        <---HERE
                 |          |          |
                 |          |          |--25.00%-- main
                 |          |          |          __libc_start_main
                 |          |          |          _start
                 |          |          |          0x0        <---HERE
                 |          |          |
                 |          |           --25.00%-- 0x7facc1df12a0 HERE

To which function would 0x7facc1df12a0 match? It does not even seem to
be in the mapped address space of "ls". I am clueless.

Thanks for your time.
Bye
Mauro
