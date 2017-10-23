From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 1/5] perf report: properly handle branch count in match_chain
Date: Mon, 23 Oct 2017 13:39:39 -0700
Message-ID: <87lgk1ha44.fsf@linux.intel.com>
References: <20171019113836.5548-1-milian.wolff@kdab.com>
        <1895125.rrirNAUR4a@agathebauer> <87she9hp4w.fsf@linux.intel.com>
        <2141037.2yycCXbTRa@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31499 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdJWUjl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 16:39:41 -0400
In-Reply-To: <2141037.2yycCXbTRa@agathebauer> (Milian Wolff's message of "Mon,
        23 Oct 2017 20:39:14 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Milian Wolff <milian.wolff@kdab.com> writes:
>  		bi = sample__resolve_bstack(sample, al);
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 94d8f1ccedd9..e54741308e6c 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1824,6 +1824,8 @@ struct branch_info *sample__resolve_bstack(struct 
> perf_sample *sample,
>  		ip__resolve_ams(al->thread, &bi[i].to, bs->entries[i].to);
>  		ip__resolve_ams(al->thread, &bi[i].from, bs->entries[i].from);
>  		bi[i].flags = bs->entries[i].flags;
> +		if (bi[i].flags.cycles == 0)
> +			bi[i].flags.cycles = 123;
>  	}
>  	return bi;
>  }
>
> And then I ran again the two perf commands quoted above, but still cannot see 
> any avg_cycles. Am I missing something else? Or could you or someone else with 
> access to the proper hardware maybe test this?

The patch above was for annotate. For the call graphs you need to add
the fake cycles in the call graph path.

> I'd still be interested in seeing source code for an example binary as well as 
> the perf commands that should be used.

When supported, it works with any binary with -b
(see http://halobates.de/applicative-mental-models.pdf)

% cat tcall.c
volatile a = 10000, b = 100000, c;

__attribute__((noinline)) f2()
{
        c = a / b;
}

__attribute__((noinline)) f1()
{
        f2();
        f2();
}

main()
{
        int i;
        for (i = 0; i < 500000000; i++)
            f1();
}


% perf record -b  ./tcall

% perf report --branch-history --stdio
   78.68%  tcall.c:6              [.] f2                  tcall            
            |          
            |--39.56%--f1 tcall.c:12
            |          f2 tcall.c:7 (cycles:7)
            |          f2 tcall.c:6
            |          f1 tcall.c:12 (cycles:1)
            |          main tcall.c:17
            |          f2 tcall.c:7 (cycles:7)
            |          main tcall.c:18
            |          main tcall.c:17 (cycles:1)
            |          f1 tcall.c:11
            |          main tcall.c:18 (cycles:1)
            |          f2 tcall.c:6
            |          f1 tcall.c:11 (cycles:1)
            |          f1 tcall.c:12
            |          f2 tcall.c:7 (cycles:7)
            |          f2 tcall.c:6
            |          f1 tcall.c:12 (cycles:1)
            |          main tcall.c:17
            |          f2 tcall.c:7 (cycles:7)
            |          main tcall.c:18
            |          main tcall.c:17 (cycles:1)


-Andi
