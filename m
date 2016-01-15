From: Gary Byers <gb@clozure.com>
Subject: odd error from "perf record"
Date: Fri, 15 Jan 2016 13:35:05 -0700
Message-ID: <569957F9.80700@clozure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from gyp.clozure.com ([74.50.56.54]:34353 "EHLO gyp.clozure.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbcAOUmu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 Jan 2016 15:42:50 -0500
Received: from [198.51.249.4] (c-73-26-142-247.hsd1.nm.comcast.net [73.26.142.247])
	(Authenticated sender: gb)
	by gyp.clozure.com (Postfix) with ESMTPSA id 1322340414
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Jan 2016 20:35:07 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi.

I happen to be using Ubuntu 15.10

[~] gb@abq> uname -a
Linux abq 4.2.0-23-generic #28-Ubuntu SMP Sun Dec 27 17:47:31 UTC 2015 
x86_64 x86_64 x86_64 GNU/Linux


I am trying to use perf to profile a 64-bit x86 Linux program. The 
program maps a large (512gb) chunk
of address space, but "only" about 20mb of that are mapped with 
permissions that allow any of read,
write, or execute access. (The atypical memory mapping is done for what 
I believe to be very good
reasons and I don't think that those reasons are directly relevant here.)

Some of the code that I an trying to profile is on pages that have read 
and execute permissions
and atypically "high" addresses, often of the form 0000300000xxxxxx,  If 
anyone reading this would
find it helpful, I can certainly provide a copy of /proc/<pid>/maps or 
similar for a typical instance
of the process.  As far as I know, few (if any) pages in the process are 
locked via mlock() or variants.

For the sake of argument, it may be helpful to think of that code as 
having been "JITted" there.  it is
not mapped from an ELF executable or library, and my later questions may 
have to do with the .map file
that I am trying to use to provide symbolic information

I have other issues that I would like to discuss in a followup message, 
but first:

When I call "perf record" on a running instance of the process, I often 
get an error
  gb@abq> [~] gb@abq> perf record -p 18310
Permission error mapping pages.
Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
or try again with a smaller value of -m/--mmap_pages.
(current value: 4294967295,0)
[~] gb@abq> cat /proc/sys/kernel/perf_event_mlock_kb
516

If I try again with an explicit -m argument,I get a similar but slightly 
different error:
[~] gb@abq> perf record -m 8 -p 18310

Permission error mapping pages.
Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
or try again with a smaller value of -m/--mmap_pages.
(current value: 8,0)

If I run 'perf record ..." as root, I get past this point but run into 
other issues that
I will try to discuss in a later message and running as root is not 
always possible for my
uaers

The code in question (and its source) are freely available and the 
source is licensed under an LGPL variant.

I'd be glad to provide that and any other help that anyone needs, and 
thanks for any help
that anyone can provide,
