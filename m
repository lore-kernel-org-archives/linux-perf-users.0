From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: Add check_period pmu callback
Date: Mon, 11 Feb 2019 11:11:39 +0100
Message-ID: <20190211101139.GV32511@hirez.programming.kicks-ass.net>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
 <alpine.DEB.2.21.1902011125290.25915@macbook-air>
 <20190201173816.GA19907@krava>
 <alpine.DEB.2.21.1902021255370.5674@macbook-air>
 <20190204123532.GA4794@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204123532.GA4794@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 04, 2019 at 01:35:32PM +0100, Jiri Olsa wrote:
> Vince (and later on Ravi) reported crash in BTS code during
> fuzzing with following backtrace:
> 
>   general protection fault: 0000 [#1] SMP PTI
>   ...
>   RIP: 0010:perf_prepare_sample+0x8f/0x510
>   ...
>   Call Trace:
>    <IRQ>
>    ? intel_pmu_drain_bts_buffer+0x194/0x230
>    intel_pmu_drain_bts_buffer+0x160/0x230
>    ? tick_nohz_irq_exit+0x31/0x40
>    ? smp_call_function_single_interrupt+0x48/0xe0
>    ? call_function_single_interrupt+0xf/0x20
>    ? call_function_single_interrupt+0xa/0x20
>    ? x86_schedule_events+0x1a0/0x2f0
>    ? x86_pmu_commit_txn+0xb4/0x100
>    ? find_busiest_group+0x47/0x5d0
>    ? perf_event_set_state.part.42+0x12/0x50
>    ? perf_mux_hrtimer_restart+0x40/0xb0
>    intel_pmu_disable_event+0xae/0x100
>    ? intel_pmu_disable_event+0xae/0x100
>    x86_pmu_stop+0x7a/0xb0
>    x86_pmu_del+0x57/0x120
>    event_sched_out.isra.101+0x83/0x180
>    group_sched_out.part.103+0x57/0xe0
>    ctx_sched_out+0x188/0x240
>    ctx_resched+0xa8/0xd0
>    __perf_event_enable+0x193/0x1e0
>    event_function+0x8e/0xc0
>    remote_function+0x41/0x50
>    flush_smp_call_function_queue+0x68/0x100
>    generic_smp_call_function_single_interrupt+0x13/0x30
>    smp_call_function_single_interrupt+0x3e/0xe0
>    call_function_single_interrupt+0xf/0x20
>    </IRQ>
> 
> The reason is that while event init code does several checks
> for BTS events and prevents several unwanted config bits for
> BTS event (like precise_ip), the PERF_EVENT_IOC_PERIOD allows
> to create BTS event without those checks being done.
> 
> Following sequence will cause the crash:
>   - create 'almost' BTS event with precise_ip and callchains,
>     (perf command line -e option equiv.):
> 
>     -e cpu/branch-instructions/up -c 2 -g
> 
>   - change the period of that event to '1', which will turn
>     it to BTS event, with precise_ip and callchains
> 
> That will immediately cause crash in perf_prepare_sample
> function because precise_ip events are expected to come
> in with callchain data initialized, but that's not the
> case for intel_pmu_drain_bts_buffer caller.
> 
> Adding a check_period callback to be called before the period
> is changed via PERF_EVENT_IOC_PERIOD. It will deny the change
> if the event would become BTS. Plus adding also the limit_period
> check as well.
> 
> Cc: Vince Weaver <vincent.weaver@maine.edu>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks Jiri!
