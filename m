From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Thu, 23 Nov 2017 15:21:00 +0100
Message-ID: <20171123142100.GA7066@krava>
References: <3344812.IFj9h2T05j@agathebauer>
 <215895928.dRJQAAs51a@agathebauer>
 <20171120234438.GA22397@krava>
 <6754554.PRelPk1P9n@milian-kdab2>
 <20171123140931.GA5575@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752945AbdKWOVD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 09:21:03 -0500
Content-Disposition: inline
In-Reply-To: <20171123140931.GA5575@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Thu, Nov 23, 2017 at 03:09:31PM +0100, Jiri Olsa wrote:
> On Thu, Nov 23, 2017 at 02:40:36PM +0100, Milian Wolff wrote:
> > On Tuesday, November 21, 2017 12:44:38 AM CET Jiri Olsa wrote:
> > > On Mon, Nov 20, 2017 at 09:24:42PM +0100, Milian Wolff wrote:
> > > > On Montag, 20. November 2017 15:29:08 CET Jiri Olsa wrote:
> > > > > On Mon, Nov 20, 2017 at 03:00:46PM +0100, Milian Wolff wrote:
> > > > > > Hey all,
> > > > > > 
> > > > > > colleagues of mine just brought this inconvenient perf stat behavior
> > > > > > to my
> > > > > > attention:
> > > > > > 
> > > > > > $ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1
> > > > > > 
> > > > > >  Performance counter stats for 'system wide':
> > > > > >        4004.501439      cpu-clock (msec)          #    4.000 CPUs
> > > > > >        utilized
> > > > > >        4004.526474      task-clock (msec)         #    4.000 CPUs
> > > > > >        utilized
> > > > > >        945,906,029      cycles                    #    0.236 GHz
> > > > > >        461,861,241      instructions              #    0.49  insn per
> > > > > >        cycle
> > > > > >        
> > > > > >        1.001247082 seconds time elapsed
> > > > > > 
> > > > > > This shows that cpu-clock and task-clock are incremented also for the
> > > > > > idle
> > > > > > processes. Is there some trick to exclude that time, such that the CPU
> > > > > > utilization drops below 100% when doing `perf stat -a`?
> > > > > 
> > > > > I dont think it's the idle process you see, I think it's the managing
> > > > > overhead before the 'sleep 1' task goes actualy to sleep
> > > > > 
> > > > > there's some user space code before it gets into the sleep syscall,
> > > > > and there's some possible kernel scheduling/syscall/irq code with
> > > > > events already enabled and counting
> > > > 
> > > > Sorry for being unclear: I was talking about the task-clock and cpu-clock
> > > > values which you omitted from your measurements below. My example also
> > > > shows that the counts for cycles and instructions are fine. But the
> > > > cpu-clock and task-clock are useless as they always sum up to essentially
> > > > `$nproc*$runtime`. What I'm hoping for are fractional values for the "N
> > > > CPUs utilized".
> > > ugh my bad.. anyway by using -a you create cpu counters
> > > which never unschedule, so those times will be same
> > > as the 'sleep 1' run length
> > > 
> > > but not sure now how to get the real utilization.. will check
> > 
> > Hey jirka,
> > 
> > did you have a chance to check the above? I'd be really interested in knowing 
> > whether there is an existing workaround. If not, would it be feasible to patch 
> > perf to get the desired behavior? I'd be willing to look into this. This would 
> > probably require changes on the kernel side though, or how could this be 
> > fixed?
> 
> hi,
> I haven't found any good way yet.. I ended up with following
> patch to allow attach counters to idle process, which got
> me the count/behaviour you need (with few tools changes in
> my perf/idle branch)
> 
> but I'm not sure it's the best idea ;-) there might
> be better way.. CC-ing Ingo, Peter and Alexander

also I was thinking we might add 'idle' line into perf top ;-)
shouldn't be that hard once we have the counter

jirka
