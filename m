From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Two questions on perf dwarf callchains
Date: Sat, 18 Jan 2014 05:42:03 +0100
Message-ID: <20140118044203.GR20765@two.firstfloor.org>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
 <87d2jq1i7q.fsf@tassilo.jf.intel.com>
 <1390001852.8555.8.camel@nb-andreolini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:41054 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbaAREmF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jan 2014 23:42:05 -0500
Content-Disposition: inline
In-Reply-To: <1390001852.8555.8.camel@nb-andreolini>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mauro Andreolini <mauro.andreolini@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

> Thanks for your time. Right now I am using gcc 4.8.2 20131219
> (prerelease) and libunwind 1.1. I noticed the following
> compile flags: "-O2 -g -fvar-tracking-assignments". I thought that
> maybe optimizations like function inlining and the like would not play
> together with debugging info, so I changed them to "-Og -g3
> -fvar-tracking-assignments" and recompiled anything, albeit with no
> luck. I must be missing something big here. How can I be sure to give
> correct dwarf unwind information?

The dwarf information should be present unless explicitely disabled.
It's either a libunwind or compiler problem. You could file a gcc bug
I suppose. Also check if gdb can backtrace through it. If that works
it's likely unwind.

unwind problems are unfortunately somewhat common (but most seem to
be in handwritten assembler)

You'll also notice that dwarf unwind profiling is very expensive in overhead.
I usually avoid it because of that.

If you have a Haswell system one alternative is the LBR callstack 
patchkit on Linux kernel (unfortunately not merged so far)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
