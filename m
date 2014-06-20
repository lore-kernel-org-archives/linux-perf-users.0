From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: Re: Use of PMU counters inside kernel?
Date: Fri, 20 Jun 2014 13:04:03 +0200
Message-ID: <20140620130403.5ed22a73@redhat.com>
References: <20140619125352.768e1ec9@redhat.com>
	<87d2e48uzk.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9143 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966249AbaFTLEd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Jun 2014 07:04:33 -0400
In-Reply-To: <87d2e48uzk.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Daniel Borkmann <dborkman@redhat.com>, Florian Westphal <fw@strlen.de>, Hannes Frederic Sowa <hannes@stressinduktion.org>, Richard Fowles <rfowles@redhat.com>

On Thu, 19 Jun 2014 14:11:59 -0700
Andi Kleen <andi@firstfloor.org> wrote:

> Jesper Dangaard Brouer <jbrouer@redhat.com> writes:
> 
> > I want to use/read the PMU counters for 'instructions' and 'cycles',
> > from within the kernel, to measure the overhead of different in-kernel
> > functions (and calc the pipeline efficiency ala perf-stat insns per cycle).
> >
> > What is the prefered way/API to read these counters, without
> > conflicting with the perf tool?
> >
> 
> perf_event_create_counter()

Thanks, guess you mean:
 perf_event_create_kernel_counter()


> > I basically just need a in-kernel API to turn in these counters, and
> > then I can just read them via the rdpcm instruction.
> 
> For RDPMC you would need extra support actually, as there is no 
> guarantee perf uses the fixed counter. In user space this 
> information is in the perf mmap page.

Hmm, so you are saying that I cannot rely on just reading the counters
with the "rdpmc" inctruction.  What should I then use?

I'm a little confused about the fixed counters, and the (to me) magic
number that is used to read them:

// From: https://github.com/andikleen/simple-pmu
enum {
	FIXED_SELECT = (1U << 30), /* == 0x40000000 */
	FIXED_INST_RETIRED_ANY = 0,
	FIXED_CPU_CLK_UNHALTED_CORE = 1,
	FIXED_CPU_CLK_UNHALTED_REF = 2,
};


> Also please be aware that RDPMC is not synchronizing.

What do you mean by "not synchronizing"?

I've read some where, that I can use the "rdmsr" instruction in the
kernel, and read the PCM register directly, to give me higher
accuracy.  Is that a bad idea?


Thanks for your feedback,
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Sr. Network Kernel Developer at Red Hat
  Author of http://www.iptv-analyzer.org
  LinkedIn: http://www.linkedin.com/in/brouer
