From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v3 3/3] perf vendor events amd: update Zen1 events to V2
Date: Tue, 3 Mar 2020 11:04:23 -0600
Message-ID: <77552e9e-7fca-7186-24cc-6a8a87d4b7b6@amd.com>
References: <20200228175639.39171-1-vijaythakkar@me.com>
 <20200228175639.39171-4-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228175639.39171-4-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Vijay,

On 2/28/20 11:56 AM, Vijay Thakkar wrote:
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
> @@ -3,16 +3,72 @@
>      "EventName": "fpu_pipe_assignment.dual",
>      "EventCode": "0x00",
>      "BriefDescription": "Total number multi-pipe uOps.",

Please concatenate .."assigned to all pipes", like you did in the publicDescription:

> -    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to all pipes.",
>      "UMask": "0xf0"
>    },
<snip>
>    {
>      "EventName": "fpu_pipe_assignment.total",
>      "EventCode": "0x00",
>      "BriefDescription": "Total number uOps.",

Same here.

> -    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to all pipes.",
>      "UMask": "0xf"
>    },

The rest looks good to me, and so does patch 1/3 still.

Thanks,

Kim
