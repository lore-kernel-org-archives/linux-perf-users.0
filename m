From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v7 1/5] perf report: properly handle branch count in match_chain
Date: Mon, 23 Oct 2017 20:39:14 +0200
Message-ID: <2141037.2yycCXbTRa@agathebauer>
References: <20171019113836.5548-1-milian.wolff@kdab.com> <1895125.rrirNAUR4a@agathebauer> <87she9hp4w.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:52850 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbdJWSk3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 14:40:29 -0400
In-Reply-To: <87she9hp4w.fsf@linux.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

On Montag, 23. Oktober 2017 17:15:11 CEST Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
> > perf record -b --call-graph dwarf <some binary>
> > perf report --branch-history --no-children --stdio
> > 
> > I see predicted and iter values as before, so I think nothing is breaking.
> > But I'm somewhat unsure. Can someone paste an example source code and the
> > perf commands to get some meaningful avg_cycles? Or does this depend on a
> > newer Intel CPU? I have currently only a Intel(R) Core(TM) i7-5600U CPU @
> > 2.60GHz available.
> 
> Branch cycles requires at least a Skylake or Goldmont CPU, so yes.
> 
> For testing on other systems you can fake them however with some variant
> of this patch
> 
> http://lkml.iu.edu/hypermail//linux/kernel/1505.1/01135.html

I've rebased that against master:

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 25d143053ab5..d128e66fe8af 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2407,7 +2407,7 @@ void hist__account_cycles(struct branch_stack *bs, 
struct addr_location *al,
 	struct branch_info *bi;
 
 	/* If we have branch cycles always annotate them. */
-	if (bs && bs->nr && bs->entries[0].flags.cycles) {
+	if (bs && bs->nr /* && bs->entries[0].flags.cycles */) {
 		int i;
 
 		bi = sample__resolve_bstack(sample, al);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 94d8f1ccedd9..e54741308e6c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1824,6 +1824,8 @@ struct branch_info *sample__resolve_bstack(struct 
perf_sample *sample,
 		ip__resolve_ams(al->thread, &bi[i].to, bs->entries[i].to);
 		ip__resolve_ams(al->thread, &bi[i].from, bs->entries[i].from);
 		bi[i].flags = bs->entries[i].flags;
+		if (bi[i].flags.cycles == 0)
+			bi[i].flags.cycles = 123;
 	}
 	return bi;
 }

And then I ran again the two perf commands quoted above, but still cannot see 
any avg_cycles. Am I missing something else? Or could you or someone else with 
access to the proper hardware maybe test this?

I'd still be interested in seeing source code for an example binary as well as 
the perf commands that should be used.

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
