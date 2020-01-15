From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 3/3] perf vendor events amd: update Zen1 events to V2
Date: Wed, 15 Jan 2020 12:19:15 -0600
Message-ID: <4411225b-1bb3-a273-bd74-7923f91006ff@amd.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-4-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191227125536.1091387-4-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 12/27/19 6:55 AM, Vijay Thakkar wrote:

> [1]: Processor Programming Reference (PPR) for AMD Family 17h Models
> 01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
> [2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
> Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.

I'm a fan of providing links to the documents; saves reviewers some time searching for them.

> -  {
> -    "EventName": "ex_ret_cond_misp",
> -    "EventCode": "0xd2",
> -    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
> -  },

Ack, this is in the 54945_PPR_Family_17h_Models_00h-0Fh document, which describes zen1, yet I get zeroes out of the hardware, which technically could mean that Zen has a 100% prediction rate, but I doubt it, given the workload I gave it was very unpredictable :)

> +    "EventName": "fpu_pipe_assignment.dual3",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual2",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual1",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual0",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x1"
> +  },

The UMasks for these .dualN event masks are wrong: they need to be left-shifted by 4 bits.

> +    "EventName": "ls_mab_alloc.loads",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache load miss.",
> +    "UMask": "0x40"

and this UMask should be 1.

This concludes my review of this version of this patchseries, sorry it took so long, and I didn't do a fully exhaustive review of #2 of 3.  If you post a v2 of the series, I'll be quicker to review that.

Thanks,

Kim
