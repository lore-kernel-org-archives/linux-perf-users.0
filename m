From: William Cohen <wcohen@redhat.com>
Subject: Re: Perf supporting function reordering?
Date: Mon, 17 Mar 2014 14:36:10 -0400
Message-ID: <5327409A.3040309@redhat.com>
References: <5327215C.7010005@redhat.com> <87wqfsdbqv.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756847AbaCQSgN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Mar 2014 14:36:13 -0400
In-Reply-To: <87wqfsdbqv.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 03/17/2014 12:35 PM, Andi Kleen wrote:
> William Cohen <wcohen@redhat.com> writes:
> 
>> Has there been any thought about perf supporting function reordering? 
> 
> See autofdo http://gcc.gnu.org/wiki/AutoFDO and
> http://gcc.gnu.org/ml/gcc-patches/2011-09/msg01440.html
> 
> It's not in any standard compiler unfortunately.
> 
> Standard gcc can do it with profile feedback, but not for the standard kernel.

You mean GCC's "-freorder-functions"? That is rather coarse.  According to the link below it only groups functions into hot and cold sections.

http://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#Optimize-Options

> 
>> Any thoughts on making it easier for perf make this statistical
>> callgraph information available and using it to do code reordering?  I
>> have experimented with code reorder with user space postgres package
>> and it did help performance about 5% improvement in IPC
> 
> Is the mechanism of the IPC improvement understood? 

Most of the IPC performance improvement in the experiment could be explained by the reduction in the iTLB misses.

> 
> My understanding from older tools that did this the main advantage of
> pure reordering (not full profile feedback, which has many advantages) 
> is mainly in startup time improvements and lowering the TLB overhead 
> slightly, apart from slightly smaller working.

Yes, improved startup time, fewer itlb updates, and smaller working set are the expected results of function reordering.

> 
> However this all does not apply to the kernel, which does not do demand
> paging. In general modern CPUs are pretty good at prefetching code.
> 
> For the TLB issues the better strategy is likely just going for
> large pages, as Kirill's MM work enables.

For the kernel code demand paging and iTLB misses are less of an issue.  Is modules code loaded into hugepages or do they use normal sized pages?  If the modules are using normal sized pages, then wouldn't some of the large modules (for example kvm, i915 and nouveau) benefit from function reordering?

-Will
