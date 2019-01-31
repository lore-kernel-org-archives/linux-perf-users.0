From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Thu, 31 Jan 2019 12:27:38 -0800
Message-ID: <CAM_iQpVtyCR=BTBkpDtbEFJ8REczpvYRTGPQnBsV=8rznXn6fg@mail.gmail.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com> <20190125160056.GG6118@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125160056.GG6118@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Jan 25, 2019 at 8:02 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
> > [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126), lowering kernel.perf_event_max_sample_rate to 63750
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920), lowering kernel.perf_event_max_sample_rate to 48250
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175), lowering kernel.perf_event_max_sample_rate to 38000
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538), lowering kernel.perf_event_max_sample_rate to 29500
>
> These are fairly normal.
>
> > [Fri Jan 25 10:32:44 2019] ------------[ cut here ]------------
> > [Fri Jan 25 10:32:44 2019] perfevents: irq loop stuck!
>
> I believe it's always possible to cause an irq loop. This happens when
> the PMU is programmed to cause PMIs on multiple counters
> too quickly. Maybe should just recover from it without printing such
> scary messages.

Yeah, a loop stuck looks really scary inside an NMI handler.
Should I just go ahead to send a patch to remove this warning?
Or probably turn it into a pr_info()?

>
> Right now the scary message is justified because it resets the complete
> PMU. Perhaps need to be a bit more selective resetting on only
> the events that loop.
>
> > [Fri Jan 25 10:32:44 2019] WARNING: CPU: 1 PID: 0 at arch/x86/events/intel/core.c:2440 intel_pmu_handle_irq+0x158/0x170
>
> This looks independent.
>
> I would apply the following patch (cut'n'pasted, so may need manual apply)
> and then run with
>

I would like to help as we keep seeing this warning for a rather long time,
but unfortunately the reproducer provided by Ravi doesn't trigger any warning
or crash here. Maybe I don't use a right hardware to trigger it?

[    0.132136] Performance Events: PEBS fmt2+, Broadwell events,
16-deep LBR, full-width counters, Intel PMU driver.
[    0.133003] ... version:                3
[    0.134001] ... bit width:              48
[    0.135001] ... generic registers:      4
[    0.136001] ... value mask:             0000ffffffffffff
[    0.137001] ... max period:             00007fffffffffff
[    0.138001] ... fixed-purpose events:   3
[    0.139001] ... event mask:             000000070000000f


Thanks!
