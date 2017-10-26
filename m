From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 1/2] Add new elements for per-event-dump option
Date: Thu, 26 Oct 2017 10:46:07 -0300
Message-ID: <20171026134607.GI7045@kernel.org>
References: <1508921599-10832-1-git-send-email-yuzhoujian@didichuxing.com>
 <1508921599-10832-2-git-send-email-yuzhoujian@didichuxing.com>
 <20171026130143.GH7045@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026130143.GH7045@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, yuzhoujian@didichuxing.com, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Oct 26, 2017 at 10:01:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Oct 25, 2017 at 04:53:18PM +0800, yuzhoujian escreveu:
> > +	bool		per_event_dump;
> > +	const char	*last_evsel_name;
> >  	enum show_feature_header show_feat_hdr;
 
> Ditto, this should be in struct perf_script.
 
> I'm cooking a patch...

So, please take a look at my perf/core branch, I've reimplemented it the way I
had suggested, should work as you intended, and I added the missing entry to
tools/perf/Documentation/perf-script.txt, its man page:

[root@jouet ~]# mkdir tt
[root@jouet ~]# cd tt
[root@jouet tt]# perf sched record sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.450 MB perf.data (16177 samples) ]
[root@jouet tt]# perf evlist
sched:sched_switch
sched:sched_stat_wait
sched:sched_stat_sleep
sched:sched_stat_iowait
sched:sched_stat_runtime
sched:sched_process_fork
sched:sched_wakeup
sched:sched_wakeup_new
sched:sched_migrate_task
# Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
[root@jouet tt]# perf script | head
            perf 24359 [003] 203964.311770:       sched:sched_wakeup: perf:24360 [120] success=1 CPU:001
         swapper     0 [001] 203964.311778:       sched:sched_switch: swapper/1:0 [120] R ==> perf:24360 [120]
            perf 24359 [003] 203964.311804: sched:sched_stat_runtime: comm=perf pid=24359 runtime=716900 [ns] vruntime=9190193330 [ns]
            perf 24359 [003] 203964.311806:       sched:sched_switch: perf:24359 [120] S ==> swapper/3:0 [120]
         swapper     0 [000] 203964.312036:       sched:sched_wakeup: chrome:20356 [120] success=1 CPU:000
         swapper     0 [000] 203964.312041:       sched:sched_switch: swapper/0:0 [120] R ==> chrome:20356 [120]
          chrome 20356 [000] 203964.312079: sched:sched_stat_runtime: comm=chrome pid=20356 runtime=39381 [ns] vruntime=7598655260580 [ns]
            perf 24360 [001] 203964.312079: sched:sched_stat_runtime: comm=perf pid=24360 runtime=304174 [ns] vruntime=917028583 [ns]
          chrome 20356 [000] 203964.312086:       sched:sched_wakeup: kworker/0:23:12157 [120] success=1 CPU:000
          chrome 20356 [000] 203964.312096: sched:sched_stat_runtime: comm=chrome pid=20356 runtime=3531 [ns] vruntime=7598655264111 [ns]
[root@jouet tt]# ls
perf.data
[root@jouet tt]# perf script --per-event-dump
[root@jouet tt]# ls
perf.data                                perf.data.sched:sched_stat_runtime.dump  perf.data.sched:sched_wakeup.dump
perf.data.sched:sched_migrate_task.dump  perf.data.sched:sched_stat_sleep.dump    perf.data.sched:sched_wakeup_new.dump
perf.data.sched:sched_process_fork.dump  perf.data.sched:sched_stat_wait.dump
perf.data.sched:sched_stat_iowait.dump   perf.data.sched:sched_switch.dump
[root@jouet tt]# head -5 perf.data.sched:sched_switch.dump
         swapper     0 [001] 203964.311778:       sched:sched_switch: swapper/1:0 [120] R ==> perf:24360 [120]
            perf 24359 [003] 203964.311806:       sched:sched_switch: perf:24359 [120] S ==> swapper/3:0 [120]
         swapper     0 [000] 203964.312041:       sched:sched_switch: swapper/0:0 [120] R ==> chrome:20356 [120]
          chrome 20356 [000] 203964.312097:       sched:sched_switch: chrome:20356 [120] R ==> kworker/0:23:12157 [120]
    kworker/0:23 12157 [000] 203964.312110:       sched:sched_switch: kworker/0:23:12157 [120] t ==> chrome:20356 [120]
[root@jouet tt]# 
[root@jouet tt]# head -5 perf.data.sched:sched_stat_runtime.dump
            perf 24359 [003] 203964.311804: sched:sched_stat_runtime: comm=perf pid=24359 runtime=716900 [ns] vruntime=9190193330 [ns]
          chrome 20356 [000] 203964.312079: sched:sched_stat_runtime: comm=chrome pid=20356 runtime=39381 [ns] vruntime=7598655260580 [ns]
            perf 24360 [001] 203964.312079: sched:sched_stat_runtime: comm=perf pid=24360 runtime=304174 [ns] vruntime=917028583 [ns]
          chrome 20356 [000] 203964.312096: sched:sched_stat_runtime: comm=chrome pid=20356 runtime=3531 [ns] vruntime=7598655264111 [ns]
    kworker/0:23 12157 [000] 203964.312108: sched:sched_stat_runtime: comm=kworker/0:23 pid=12157 runtime=7327 [ns] vruntime=110992086009578 [ns]
[root@jouet tt]# 

- Arnaldo
