From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: remount of tracefs required
Date: Tue, 4 Aug 2015 12:27:46 -0300
Message-ID: <20150804152746.GA3126@kernel.org>
References: <5297956.5blcApkzlY@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44882 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315AbbHDP1s (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 11:27:48 -0400
Content-Disposition: inline
In-Reply-To: <5297956.5blcApkzlY@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Aug 04, 2015 at 04:44:53PM +0200, Milian Wolff escreveu:
> on ArchLinux with Linux 4.1.3, perf 4.1.0, I get:
> 
> $ perf trace
> Error:  No permissions to read 
> /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
> Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'
> $ sudo mount -o remount,mode=755 /sys/kernel/debug
> $ perf trace
> Error:  No permissions to read 
> /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
> Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'
> 
> This is b/c Arch uses tracefs, and running
> 
> $ sudo mount -o remount,mode=755 /sys/kernel/debug/tracefs
> 
> fixes the issue for me. Could someone please amend the error message? Do I 
> also need to remount debugfs, or is tracefs sufficient for using more advanced 
> perf tools?

Well:

  [acme@zoo linux]$ perf trace ls
  Error:	No permissions to read
  /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
  Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'

  [acme@zoo linux]$ ls -la /sys/kernel/debug
  ls: cannot open directory /sys/kernel/debug: Permission denied
  [acme@zoo linux]$

So, I can't access debugfs, that is where the canonical mount point for
tracefs is, so the message can be read as well as: "hey, let me get to
where tracefs is".

Once that is done:

  [acme@zoo linux]$ sudo mount -o remount,mode=755 /sys/kernel/debug
  [sudo] password for acme: 
  [acme@zoo linux]$ ls -la /sys/kernel/debug
  total 0
  drwxr-xr-x. 32 root root 0 Aug  4 08:35 .
  drwxr-xr-x. 10 root root 0 Aug  4 08:35 ..
  drwxr-xr-x.  2 root root 0 Aug  4 08:35 acpi
  <SNIP>
  drwxr-xr-x.  2 root root 0 Aug  4 08:35 zswap
  [acme@zoo linux]$ ls -la /sys/kernel/debug/tracing/
  ls: cannot open directory /sys/kernel/debug/tracing/: Permission denied
  [acme@zoo linux]$

So, if I try:

  [acme@zoo linux]$ trace usleep 1
  Error:	No permissions to read
  /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
  Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'

  [acme@zoo linux]$

It asks for that same remount to be done, this time for tracefs, once
that is done:

  [acme@zoo linux]$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
  [acme@zoo linux]$ trace usleep 1
     0.086 (0.001 ms): usleep/10122 brk(                                                              ) = 0x556309717000
     0.101 (0.003 ms): usleep/10122 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1) = 0x7f6f856ab000
  <SNIP>
  [acme@zoo linux]$

It works.

I guess what fixes what you report is this cset:

  commit ab85785aa13c36440a91a8e9f7616357de411a1f
  Author: Arnaldo Carvalho de Melo <acme@redhat.com>
  Date:   Mon Jul 6 08:51:41 2015 -0300

    tools lib api debugfs: Check for tracefs when reporting errors
    
    Now that we have two mountpoints, one for debugfs and another, for
    tracefs, we end up needing to check permissions for both, so, on
    a system with default config we were always asking the user to
    check the permission of the debugfs mountpoint, even when it was
    already sufficient. Fix it.

-----------

[acme@zoo linux]$ git describe ab85785aa13c36440a91a8e9f7616357de411a1f
v4.2-rc1-17-gab85785aa13c

So, can you try running the perf tools, built from the latest 4.2-rc codebase
to see if it behaves as you expect?

- Arnaldo
