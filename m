From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf supporting function reordering?
Date: Tue, 18 Mar 2014 00:39:51 +0100
Message-ID: <20140317233951.GH22728@two.firstfloor.org>
References: <5327215C.7010005@redhat.com>
 <87wqfsdbqv.fsf@tassilo.jf.intel.com>
 <5327409A.3040309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:43703 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbaCQXjw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Mar 2014 19:39:52 -0400
Content-Disposition: inline
In-Reply-To: <5327409A.3040309@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Mar 17, 2014 at 02:36:10PM -0400, William Cohen wrote:
> On 03/17/2014 12:35 PM, Andi Kleen wrote:
> > William Cohen <wcohen@redhat.com> writes:
> > 
> >> Has there been any thought about perf supporting function reordering? 
> > 
> > See autofdo http://gcc.gnu.org/wiki/AutoFDO and
> > http://gcc.gnu.org/ml/gcc-patches/2011-09/msg01440.html
> > 
> > It's not in any standard compiler unfortunately.
> > 
> > Standard gcc can do it with profile feedback, but not for the standard kernel.
> 
> You mean GCC's "-freorder-functions"? That is rather coarse.  According to the link below it only groups functions into hot and cold sections.

No the IPA passes group the whole program by the global callgraph
(either per unit or globally with LTO)
It also has special support for grouping C++ constructors.

> 
> For the kernel code demand paging and iTLB misses are less of an issue.  Is modules code loaded into hugepages or do they use normal sized pages?  If the modules are using normal sized pages, then wouldn't some of the large modules (for example kvm, i915 and nouveau) benefit from function reordering?


Today the modules use small pages.
Some 2.4 kernels put them actually into the direct (2MB) mapping.
That could be done again.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
