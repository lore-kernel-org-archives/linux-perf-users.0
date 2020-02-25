From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v2 3/3] perf vendor events amd: update Zen1 events to V2
Date: Tue, 25 Feb 2020 16:53:21 -0600
Message-ID: <73b5b731-9597-1243-485a-788437500c7a@amd.com>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-4-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200225192815.50388-4-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Vijay,

Thanks for your resubmission.

On 2/25/20 1:28 PM, Vijay Thakkar wrote:
> [1]: Processor Programming Reference (PPR) for AMD Family 17h Models
> 01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
> [2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
> Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.

Events such as the FPU pipe assignment ones are not
included in the above docs.  So can you add this one
to your list of references, since it has them listed?:

OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018

> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
> @@ -6,6 +6,34 @@
>      "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",

Omit the trailing " to Pipe 3.", since this one's umask
represents all pipes.  Feel free to add "all pipes" instead.
I realize this isn't a line you're adding, but since we're
here, we might as well fix it.

>      "UMask": "0xf0"
>    },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual3",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3."
This one is ok.

> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual2",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",

That trailing part of the string should say ..." to Pipe 2." , not Pipe 3.

> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual1",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x20"
> +  },

That trailing part of the string should say ..." to Pipe 1." , not Pipe 3.

> +  {
> +    "EventName": "fpu_pipe_assignment.dual0",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",

That trailing part of the string should say ..." to Pipe 0." , not Pipe 3.

> +    "UMask": "0x10"
> +  },
>    {
>      "EventName": "fpu_pipe_assignment.total",
>      "EventCode": "0x00",
> @@ -13,6 +41,34 @@
>      "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",

Omit the trailing " to Pipe 3.", since this one's umask represents all pipes.

>      "UMask": "0xf"
>    },
> +  {
> +    "EventName": "fpu_pipe_assignment.total3",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps on pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",

Please concatenate " Total3: Total number uOps assigned to Pipe 3." to the above string.

> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.total2",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps on pipe 2.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",

same here, but for pipe 2.

> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.total1",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps on pipe 1.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",

and here.

> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.total0",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps  on pipe 0.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
> +    "UMask": "0x1"
> +  },

and here.

> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
> @@ -37,6 +37,24 @@
>      "EventCode": "0x40",
>      "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
>    },
> +  {
> +    "EventName": "ls_mab_alloc.dc_prefetcher",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache prefetcher miss.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.stores",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache store miss.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.loads",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache load miss.",
> +    "UMask": "0x01"
> +  },

Hm, PMCx041 didn't exist when I wrote commit 0e3b74e26280
"perf/x86/amd: Update generic hardware cache events for Family 17h",
and their counts don't seem to match up very well when running
various workloads.  The microarchitecture is likely to have changed
in this area from families prior to 17h, so a MAB alloc can likely
count different events than what is presumed here: a Data cache
load/store/prefetch miss.

I think it's safer to just leave the PPR text "LS MAB Allocates
by Type" as-is, instead of assuming they are L1 load/store misses.
What do you think?

I'll review patches 1-2 tomorrow.

Thanks,

Kim
