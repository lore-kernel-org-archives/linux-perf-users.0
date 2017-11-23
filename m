From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Thu, 23 Nov 2017 16:12:05 +0100
Message-ID: <20171123151205.GA8342@krava>
References: <3344812.IFj9h2T05j@agathebauer>
 <215895928.dRJQAAs51a@agathebauer>
 <20171120234438.GA22397@krava>
 <6754554.PRelPk1P9n@milian-kdab2>
 <20171123140931.GA5575@krava>
 <20171123142100.GA7066@krava>
 <20171123144220.GB8789@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752445AbdKWPMI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 10:12:08 -0500
Content-Disposition: inline
In-Reply-To: <20171123144220.GB8789@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Thu, Nov 23, 2017 at 11:42:20AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 23, 2017 at 03:21:00PM +0100, Jiri Olsa escreveu:
> > On Thu, Nov 23, 2017 at 03:09:31PM +0100, Jiri Olsa wrote:
> > > On Thu, Nov 23, 2017 at 02:40:36PM +0100, Milian Wolff wrote:
> > > > On Tuesday, November 21, 2017 12:44:38 AM CET Jiri Olsa wrote:
> > > > > On Mon, Nov 20, 2017 at 09:24:42PM +0100, Milian Wolff wrote:
> > > > > > On Montag, 20. November 2017 15:29:08 CET Jiri Olsa wrote:
> > > > > > > On Mon, Nov 20, 2017 at 03:00:46PM +0100, Milian Wolff wrote:
> > > > > > > > Hey all,
> > > > > > > > 
> > > > > > > > colleagues of mine just brought this inconvenient perf stat behavior
> > > > > > > > to my
> > > > > > > > attention:
> > > > > > > > 
> > > > > > > > $ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1
> > > > > > > > 
> > > > > > > >  Performance counter stats for 'system wide':
> > > > > > > >        4004.501439      cpu-clock (msec)          #    4.000 CPUs
> > > > > > > >        utilized
> > > > > > > >        4004.526474      task-clock (msec)         #    4.000 CPUs
> > > > > > > >        utilized
> > > > > > > >        945,906,029      cycles                    #    0.236 GHz
> > > > > > > >        461,861,241      instructions              #    0.49  insn per
> > > > > > > >        cycle
> > > > > > > >        
> > > > > > > >        1.001247082 seconds time elapsed
> > > > > > > > 
> > > > > > > > This shows that cpu-clock and task-clock are incremented also for the
> > > > > > > > idle
> > > > > > > > processes. Is there some trick to exclude that time, such that the CPU
> > > > > > > > utilization drops below 100% when doing `perf stat -a`?
> > > > > > > 
> > > > > > > I dont think it's the idle process you see, I think it's the managing
> > > > > > > overhead before the 'sleep 1' task goes actualy to sleep
> > > > > > > 
> > > > > > > there's some user space code before it gets into the sleep syscall,
> > > > > > > and there's some possible kernel scheduling/syscall/irq code with
> > > > > > > events already enabled and counting
> > > > > > 
> > > > > > Sorry for being unclear: I was talking about the task-clock and cpu-clock
> > > > > > values which you omitted from your measurements below. My example also
> > > > > > shows that the counts for cycles and instructions are fine. But the
> > > > > > cpu-clock and task-clock are useless as they always sum up to essentially
> > > > > > `$nproc*$runtime`. What I'm hoping for are fractional values for the "N
> > > > > > CPUs utilized".
> > > > > ugh my bad.. anyway by using -a you create cpu counters
> > > > > which never unschedule, so those times will be same
> > > > > as the 'sleep 1' run length
> 
> Humm, what role perf_event_attr.exclude_idle has here?

it's used for omiting samples from idle process.. but looks
like it's enforced for software clock events

AFAICS it's not used in counting mode

jirka
