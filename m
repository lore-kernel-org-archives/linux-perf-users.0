From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Thu, 23 Nov 2017 11:42:20 -0300
Message-ID: <20171123144220.GB8789@kernel.org>
References: <3344812.IFj9h2T05j@agathebauer>
 <215895928.dRJQAAs51a@agathebauer>
 <20171120234438.GA22397@krava>
 <6754554.PRelPk1P9n@milian-kdab2>
 <20171123140931.GA5575@krava>
 <20171123142100.GA7066@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752892AbdKWOmX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 09:42:23 -0500
Content-Disposition: inline
In-Reply-To: <20171123142100.GA7066@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

Em Thu, Nov 23, 2017 at 03:21:00PM +0100, Jiri Olsa escreveu:
> On Thu, Nov 23, 2017 at 03:09:31PM +0100, Jiri Olsa wrote:
> > On Thu, Nov 23, 2017 at 02:40:36PM +0100, Milian Wolff wrote:
> > > On Tuesday, November 21, 2017 12:44:38 AM CET Jiri Olsa wrote:
> > > > On Mon, Nov 20, 2017 at 09:24:42PM +0100, Milian Wolff wrote:
> > > > > On Montag, 20. November 2017 15:29:08 CET Jiri Olsa wrote:
> > > > > > On Mon, Nov 20, 2017 at 03:00:46PM +0100, Milian Wolff wrote:
> > > > > > > Hey all,
> > > > > > > 
> > > > > > > colleagues of mine just brought this inconvenient perf stat behavior
> > > > > > > to my
> > > > > > > attention:
> > > > > > > 
> > > > > > > $ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1
> > > > > > > 
> > > > > > >  Performance counter stats for 'system wide':
> > > > > > >        4004.501439      cpu-clock (msec)          #    4.000 CPUs
> > > > > > >        utilized
> > > > > > >        4004.526474      task-clock (msec)         #    4.000 CPUs
> > > > > > >        utilized
> > > > > > >        945,906,029      cycles                    #    0.236 GHz
> > > > > > >        461,861,241      instructions              #    0.49  insn per
> > > > > > >        cycle
> > > > > > >        
> > > > > > >        1.001247082 seconds time elapsed
> > > > > > > 
> > > > > > > This shows that cpu-clock and task-clock are incremented also for the
> > > > > > > idle
> > > > > > > processes. Is there some trick to exclude that time, such that the CPU
> > > > > > > utilization drops below 100% when doing `perf stat -a`?
> > > > > > 
> > > > > > I dont think it's the idle process you see, I think it's the managing
> > > > > > overhead before the 'sleep 1' task goes actualy to sleep
> > > > > > 
> > > > > > there's some user space code before it gets into the sleep syscall,
> > > > > > and there's some possible kernel scheduling/syscall/irq code with
> > > > > > events already enabled and counting
> > > > > 
> > > > > Sorry for being unclear: I was talking about the task-clock and cpu-clock
> > > > > values which you omitted from your measurements below. My example also
> > > > > shows that the counts for cycles and instructions are fine. But the
> > > > > cpu-clock and task-clock are useless as they always sum up to essentially
> > > > > `$nproc*$runtime`. What I'm hoping for are fractional values for the "N
> > > > > CPUs utilized".
> > > > ugh my bad.. anyway by using -a you create cpu counters
> > > > which never unschedule, so those times will be same
> > > > as the 'sleep 1' run length

Humm, what role perf_event_attr.exclude_idle has here?

> > > > 
> > > > but not sure now how to get the real utilization.. will check
> > > 
> > > did you have a chance to check the above? I'd be really interested in knowing 
> > > whether there is an existing workaround. If not, would it be feasible to patch 
> > > perf to get the desired behavior? I'd be willing to look into this. This would 
> > > probably require changes on the kernel side though, or how could this be 
> > > fixed?
> > 
> > hi,
> > I haven't found any good way yet.. I ended up with following
> > patch to allow attach counters to idle process, which got
> > me the count/behaviour you need (with few tools changes in
> > my perf/idle branch)
> > 
> > but I'm not sure it's the best idea ;-) there might
> > be better way.. CC-ing Ingo, Peter and Alexander
> 
> also I was thinking we might add 'idle' line into perf top ;-)
> shouldn't be that hard once we have the counter

Humm...

What is wrong with perf_event_attr.exclude_idle? :-)

From include/uapi/linux/perf_event.h:

                                exclude_idle   :  1, /* don't count when idle */


But it is not being set:

[root@jouet ~]# perf stat -vv -a -e cpu-clock,task-clock,cycles,instructions sleep 1
Using CPUID GenuineIntel-6-3D
intel_pt default config: tsc,pt,branch
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             112
  config                           0x1
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 11
------------------------------------------------------------
perf_event_attr:
  size                             112
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 15
------------------------------------------------------------
perf_event_attr:
  size                             112
  config                           0x1
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 19
cpu-clock: 0: 1001547771 1001547617 1001547617
cpu-clock: 1: 1001552938 1001552742 1001552742
cpu-clock: 2: 1001555120 1001554407 1001554407
cpu-clock: 3: 1001563889 1001563570 1001563570
cpu-clock: 4006219718 4006218336 4006218336
task-clock: 0: 1001603894 1001603894 1001603894
task-clock: 1: 1001616140 1001616140 1001616140
task-clock: 2: 1001617338 1001617338 1001617338
task-clock: 3: 1001621998 1001621998 1001621998
task-clock: 4006459370 4006459370 4006459370
cycles: 0: 71757776 1001642926 1001642926
cycles: 1: 23188411 1001651335 1001651335
cycles: 2: 24665622 1001654878 1001654878
cycles: 3: 79907293 1001659590 1001659590
cycles: 199519102 4006608729 4006608729
instructions: 0: 40314068 1001677791 1001677791
instructions: 1: 13525409 1001682314 1001682314
instructions: 2: 14247277 1001682655 1001682655
instructions: 3: 23286057 1001685112 1001685112
instructions: 91372811 4006727872 4006727872

 Performance counter stats for 'system wide':

       4006.219718      cpu-clock (msec)          #    3.999 CPUs utilized          
       4006.459370      task-clock (msec)         #    3.999 CPUs utilized          
       199,519,102      cycles                    #    0.050 GHz                    
        91,372,811      instructions              #    0.46  insn per cycle         

       1.001749823 seconds time elapsed

[root@jouet ~]# 

So the I tried the patch at the end of this messagem, but it doesn't
seem to affect software counters such as cpu-clock and task-clock:

[root@jouet ~]# perf stat --no-idle -a -e cpu-clock,task-clock,cycles,instructions sleep 1m

 Performance counter stats for 'system wide':

     240005.027025      cpu-clock (msec)          #    4.000 CPUs utilized          
     240005.150119      task-clock (msec)         #    4.000 CPUs utilized          
     2,658,680,286      cycles                    #    0.011 GHz                    
     1,109,111,339      instructions              #    0.42  insn per cycle         

      60.001361214 seconds time elapsed

[root@jouet ~]# perf stat --idle -a -e cpu-clock,task-clock,cycles,instructions sleep 1m

 Performance counter stats for 'system wide':

     240006.825047      cpu-clock (msec)          #    4.000 CPUs utilized          
     240006.964995      task-clock (msec)         #    4.000 CPUs utilized          
     2,784,702,480      cycles                    #    0.012 GHz                    
     1,210,285,863      instructions              #    0.43  insn per cycle         

      60.001806963 seconds time elapsed

[root@jouet ~]#

[root@jouet ~]# perf stat -vv --no-idle -a -e cpu-clock,task-clock,cycles,instructions sleep 1 |& grep exclude_idle
  exclude_idle                     1
  exclude_idle                     1
  exclude_idle                     1
  exclude_idle                     1
[root@jouet ~]# perf stat -vv -a -e cpu-clock,task-clock,cycles,instructions sleep 1 |& grep exclude_idle
[root@jouet ~]# perf stat --idle -vv -a -e cpu-clock,task-clock,cycles,instructions sleep 1 |& grep exclude_idle
[root@jouet ~]#

Time to look at the kernel...

- Arnaldo

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 59af5a8419e2..32860537e114 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -144,6 +144,7 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
 static int			run_count			=  1;
 static bool			no_inherit			= false;
+static bool			idle				= true;
 static volatile pid_t		child_pid			= -1;
 static bool			null_run			=  false;
 static int			detailed_run			=  0;
@@ -237,6 +238,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
 	attr->inherit = !no_inherit;
+	attr->exclude_idle = !idle;
 
 	/*
 	 * Some events get initialized with sample_(period/type) set,
@@ -1890,6 +1892,7 @@ static const struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_BOOLEAN(0, "idle", &idle, "Measure when idle"),
 	OPT_END()
 };
 
