From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 1/5] perf report: properly handle branch count in match_chain
Date: Mon, 23 Oct 2017 08:15:11 -0700
Message-ID: <87she9hp4w.fsf@linux.intel.com>
References: <20171019113836.5548-1-milian.wolff@kdab.com>
        <20171019113836.5548-2-milian.wolff@kdab.com>
        <1895125.rrirNAUR4a@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:4703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdJWPPM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 11:15:12 -0400
In-Reply-To: <1895125.rrirNAUR4a@agathebauer> (Milian Wolff's message of "Thu,
        19 Oct 2017 13:42:18 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Milian Wolff <milian.wolff@kdab.com> writes:
>
> perf record -b --call-graph dwarf <some binary>
> perf report --branch-history --no-children --stdio
>
> I see predicted and iter values as before, so I think nothing is breaking. But 
> I'm somewhat unsure. Can someone paste an example source code and the perf 
> commands to get some meaningful avg_cycles? Or does this depend on a newer 
> Intel CPU? I have currently only a Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz 
> available.

Branch cycles requires at least a Skylake or Goldmont CPU, so yes.

For testing on other systems you can fake them however with some variant
of this patch

http://lkml.iu.edu/hypermail//linux/kernel/1505.1/01135.html

-Andi
