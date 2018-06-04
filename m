From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3]: perf record: enable arbitrary event names thru name=
 modifier
Date: Mon, 4 Jun 2018 09:56:02 +0200
Message-ID: <20180604075600.GA10484@krava>
References: <c194b060-761d-0d50-3b21-bb4ed680002d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c194b060-761d-0d50-3b21-bb4ed680002d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jun 04, 2018 at 09:50:56AM +0300, Alexey Budankov wrote:
> 
> Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> trace using name= modifier e.g. like this:
> 
> perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> 
> Below is how it looks like in the report output. Please note explicit escaped 
> quoting at cmdline string in the header so that thestring can be directly reused
> for another collection in shell:
> 
> perf report --header
> 
> # ========
> ...
> # cmdline : /root/abudanko/kernel/tip/tools/perf/perf record -v -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex 
> # event : name = OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM, , type = 4, size = 112, config = 0x100003c, { sample_period, sample_freq } = 3500000, sample_type = IP|TID|TIME, disabled = 1, inh
> ...
> # ========
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 24K of event 'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM'
> # Event count (approx.): 86492000000
> #
> # Overhead  Command  Shared Object     Symbol                                        
> # ........  .......  ................  ..............................................
> #
>     14.75%  futex    [kernel.vmlinux]  [k] __entry_trampoline_start
> ...
> 
> perf stat -e cpu/name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\',period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> 
> 10000000 process context switches in 16678890291ns (1667.9ns/ctxsw)
> 
>  Performance counter stats for './futex':
> 
>     88,095,770,571      CPU_CLK_UNHALTED.THREAD:cmask=0x1                                   
> 
>       16.679542407 seconds time elapsed
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v3:
> - updated event name syntax in perf list docs;
> - added name modifier description into perf record docs;
> 

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
