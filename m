From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf supporting function reordering?
Date: Mon, 17 Mar 2014 09:35:20 -0700
Message-ID: <87wqfsdbqv.fsf@tassilo.jf.intel.com>
References: <5327215C.7010005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23051 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554AbaCQQfZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Mar 2014 12:35:25 -0400
In-Reply-To: <5327215C.7010005@redhat.com> (William Cohen's message of "Mon,
	17 Mar 2014 12:22:52 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

William Cohen <wcohen@redhat.com> writes:

> Has there been any thought about perf supporting function reordering? 

See autofdo http://gcc.gnu.org/wiki/AutoFDO and
http://gcc.gnu.org/ml/gcc-patches/2011-09/msg01440.html

It's not in any standard compiler unfortunately.

Standard gcc can do it with profile feedback, but not for the standard kernel.

> Any thoughts on making it easier for perf make this statistical
> callgraph information available and using it to do code reordering?  I
> have experimented with code reorder with user space postgres package
> and it did help performance about 5% improvement in IPC

Is the mechanism of the IPC improvement understood? 

My understanding from older tools that did this the main advantage of
pure reordering (not full profile feedback, which has many advantages) 
is mainly in startup time improvements and lowering the TLB overhead 
slightly, apart from slightly smaller working.

However this all does not apply to the kernel, which does not do demand
paging. In general modern CPUs are pretty good at prefetching code.

For the TLB issues the better strategy is likely just going for
large pages, as Kirill's MM work enables.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
