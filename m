From: Andi Kleen <ak@linux.intel.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Thu, 8 Nov 2018 16:54:23 -0800
Message-ID: <20181109005423.GZ6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <2102566.fCj8pZGm78@agathebauer>
 <20181106202411.GU6218@tassilo.jf.intel.com>
 <1584560.aXQ729uQp3@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1584560.aXQ729uQp3@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> - Independently, when I add a custom printk manually in `arch/x86/events/
> intel/ds.c` at the end of `setup_pebs_sample_data`, then I'm never seeing any 
> differences between SP in iregs/pebs/regs. Shouldn't it also be recorded via 
> PEBS? Or is it just chance that I'm never seeing any difference in 
> setup_pebs_sample_data between iregs->sp and regs->sp?

It will depend on the workload.

> 
> - Generally, how do we want to handle this bug? If `--intr-regs` would 
> actually record a different IP than stored in uregs in the perf.data file, 
> then we could use that as a fallback for unwinding, when it fails the first 
> time. Or should we always unwind from that IP? How do we mark the "actual" 
> frame/IP then, if that differs?

I don't think the regs include IP currently? Would need to add it.
Then could report everything from the original stack in intr-regs,
and this would address that problem.

Yes it might be useful to add some indication to the sample that
there is a potential divergence between the backtrace and the IP.
Would also need to report that in perf report then.

-Andi
