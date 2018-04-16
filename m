From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 1/3] perf/core: store context switch out type into
 Perf trace
Date: Mon, 16 Apr 2018 11:28:45 -0300
Message-ID: <20180416142845.GA18171@kernel.org>
References: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
 <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
 <20180409092603.GY4043@hirez.programming.kicks-ass.net>
 <17c73937-5fdc-7323-366d-edb2f483b30c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17c73937-5fdc-7323-366d-edb2f483b30c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Apr 16, 2018 at 11:29:03AM +0300, Alexey Budankov escreveu:
> Hi Arnaldo,
> 
> On 09.04.2018 12:26, Peter Zijlstra wrote:
> > On Mon, Apr 09, 2018 at 10:25:32AM +0300, Alexey Budankov wrote:
> >>
> >> Store preempting context switch out event into Perf trace as a part of 
> >> PERF_RECORD_SWITCH[_CPU_WIDE] record.
> >>
> >> Percentage of preempting and non-preempting context switches help 
> >> understanding the nature of workloads (CPU or IO bound) that are running 
> >> on a machine;
> >>
> >> The event is treated as preemption one when task->state value of the 
> >> thread being switched out is TASK_RUNNING. Event type encoding is 
> >> implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;
> >> 	
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Acme, I'm thinking you should route this, since most of the changes are
> > actually to the tool.
> 
> This is just to make sure it doesn't sneak out of your attention 
> in hope the plan is still the same as Peter mentioned above.
> 
> Thanks,
> Alexey

Applying, rebuilding a kernel with this and testing,

- Arnaldo
