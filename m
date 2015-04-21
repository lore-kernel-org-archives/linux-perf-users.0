From: Andi Kleen <andi@firstfloor.org>
Subject: Re: What helps with stacks?
Date: Tue, 21 Apr 2015 13:06:34 -0700
Message-ID: <87sibtmek5.fsf@tassilo.jf.intel.com>
References: <loom.20150421T215002-474@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48574 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbbDUUGj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 21 Apr 2015 16:06:39 -0400
In-Reply-To: <loom.20150421T215002-474@post.gmane.org> (Daniel Speyer's
	message of "Tue, 21 Apr 2015 19:54:28 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel Speyer <dspeyer@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Daniel Speyer <dspeyer@gmail.com> writes:

> Hello all,
>
> I'm trying to get stack traces for a bunch of events using perf record and
> having trouble with them getting cut off.  I'm using --callgraph dwarf,
> which helps a little, and I recompiled libc with --fno-omit-frame-pointer,
> which doesn't seem to have helped at all.  Very often, the bottom of the
> stack is in libc, often __epoll_wait_nocancel.  Stacks for
> sched:sched_switch events seem to be worse than cycles or sched:sched_wakeup
> events, but it isn't 100%.  Is there anything else I could try?


If you have a Haswell/Broadwell system and uptodate perf (4.0) you can also
use --call-graph lbr

This uses a new hardware mechanism that can handle many situations
where the old ones failed (but also has some situations where
it has to give up)

-andi


-- 
ak@linux.intel.com -- Speaking for myself only
