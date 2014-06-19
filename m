From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Use of PMU counters inside kernel?
Date: Thu, 19 Jun 2014 14:11:59 -0700
Message-ID: <87d2e48uzk.fsf@tassilo.jf.intel.com>
References: <20140619125352.768e1ec9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61448 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934695AbaFSVMJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 Jun 2014 17:12:09 -0400
In-Reply-To: <20140619125352.768e1ec9@redhat.com> (Jesper Dangaard Brouer's
	message of "Thu, 19 Jun 2014 12:53:52 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Daniel Borkmann <dborkman@redhat.com>, Florian Westphal <fw@strlen.de>, Hannes Frederic Sowa <hannes@stressinduktion.org>

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> I want to use/read the PMU counters for 'instructions' and 'cycles',
> from within the kernel, to measure the overhead of different in-kernel
> functions (and calc the pipeline efficiency ala perf-stat insns per cycle).
>
> What is the prefered way/API to read these counters, without
> conflicting with the perf tool?
>

perf_event_create_counter()


> I basically just need a in-kernel API to turn in these counters, and
> then I can just read them via the rdpcm instruction.

For RDPMC you would need extra support actually, as there is no 
guarantee perf uses the fixed counter. In user space this 
information is in the perf mmap page.

Also please be aware that RDPMC is not synchronizing.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
