From: Milian Wolff <mail@milianw.de>
Subject: Re: perf: remount of tracefs required
Date: Wed, 05 Aug 2015 16:17:42 +0200
Message-ID: <3948762.FVKqmXobpH@milian-kdab2>
References: <5297956.5blcApkzlY@milian-kdab2> <20150804152746.GA3126@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:40292 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbHEORp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 10:17:45 -0400
In-Reply-To: <20150804152746.GA3126@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org

On Tuesday 04 August 2015 12:27:46 Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 04, 2015 at 04:44:53PM +0200, Milian Wolff escreveu:
> > on ArchLinux with Linux 4.1.3, perf 4.1.0, I get:
> > 
> > $ perf trace
> > Error:  No permissions to read
> > /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
> > Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'
> > $ sudo mount -o remount,mode=755 /sys/kernel/debug
> > $ perf trace
> > Error:  No permissions to read
> > /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
> > Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'
> > 
> > This is b/c Arch uses tracefs, and running
> > 
> > $ sudo mount -o remount,mode=755 /sys/kernel/debug/tracefs
> > 
> > fixes the issue for me. Could someone please amend the error message? Do I
> > also need to remount debugfs, or is tracefs sufficient for using more
> > advanced perf tools?
> 
> Well:
> 
>   [acme@zoo linux]$ perf trace ls
>   Error:	No permissions to read
>   /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
>   Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'
> 
>   [acme@zoo linux]$ ls -la /sys/kernel/debug
>   ls: cannot open directory /sys/kernel/debug: Permission denied
>   [acme@zoo linux]$
> 
> So, I can't access debugfs, that is where the canonical mount point for
> tracefs is, so the message can be read as well as: "hey, let me get to
> where tracefs is".

Yes, at that point this message is correct.

> Once that is done:
> 
>   [acme@zoo linux]$ sudo mount -o remount,mode=755 /sys/kernel/debug
>   [sudo] password for acme:
>   [acme@zoo linux]$ ls -la /sys/kernel/debug
>   total 0
>   drwxr-xr-x. 32 root root 0 Aug  4 08:35 .
>   drwxr-xr-x. 10 root root 0 Aug  4 08:35 ..
>   drwxr-xr-x.  2 root root 0 Aug  4 08:35 acpi
>   <SNIP>
>   drwxr-xr-x.  2 root root 0 Aug  4 08:35 zswap
>   [acme@zoo linux]$ ls -la /sys/kernel/debug/tracing/
>   ls: cannot open directory /sys/kernel/debug/tracing/: Permission denied
>   [acme@zoo linux]$
> 
> So, if I try:
> 
>   [acme@zoo linux]$ trace usleep 1
>   Error:	No permissions to read
>   /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
>   Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'

This message I do not get, not even with my perf compiled from the v4.2-rc5 
tag. And it is exactly what I was asking for.

<snip>

> I guess what fixes what you report is this cset:
> 
>   commit ab85785aa13c36440a91a8e9f7616357de411a1f
>   Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>   Date:   Mon Jul 6 08:51:41 2015 -0300
> 
>     tools lib api debugfs: Check for tracefs when reporting errors
> 
>     Now that we have two mountpoints, one for debugfs and another, for
>     tracefs, we end up needing to check permissions for both, so, on
>     a system with default config we were always asking the user to
>     check the permission of the debugfs mountpoint, even when it was
>     already sufficient. Fix it.
> 
> -----------
> 
> [acme@zoo linux]$ git describe ab85785aa13c36440a91a8e9f7616357de411a1f
> v4.2-rc1-17-gab85785aa13c
> 
> So, can you try running the perf tools, built from the latest 4.2-rc
> codebase to see if it behaves as you expect?

This is not included in 4.2-rc5 as far as I can see:

$ git describe
v4.2-rc5-2-ga64d3e5
$ git show ab85785aa13c36440a91a8e9f7616357de411a1f
fatal: bad object ab85785aa13c36440a91a8e9f7616357de411a1f
$ git log --grep debugfs --oneline --author=Arnaldo
f816b3c tools lib fs debugfs: Check if debugfs is mounted when handling ENOENT
...

Thanks
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
