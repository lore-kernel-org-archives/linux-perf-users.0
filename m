From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/30] perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC} with --delay
Date: Tue, 28 Nov 2017 12:01:52 -0300
Message-ID: <20171128150220.5064-3-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we use an initial delay, e.g.: 'perf record --delay 1000', we do not
enable the events until that delay has passed after we started the workload,
including the tracking event, i.e. the one for which we have attr.mmap, etc,
enabled to ask the kernel to generate the PERF_RECORD_{MMAP,COMM,EXEC} metadata
events that will then allow us to resolve addresses in samples to the map, dso
and symbol. There will be a shadow that even synthesizing samples won't cover,
i.e. the workload that we start and other processes forking while we
wait for the initial delay to expire.

So use a dummy event to be the tracking one and make it be enabled on exec.

Before:

  # perf record --delay 1000 stress --cpu 1 --timeout 5
  stress: info: [9029] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [9029] successful run completed in 5s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.624 MB perf.data (15908 samples) ]
  # perf script | head
      :9031 9031 32001.826888:       1 cycles:ppp: ffffffff831aa30d event_function (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826893:       1 cycles:ppp: ffffffff8300d1a0 intel_bts_enable_local (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826895:       7 cycles:ppp: ffffffff83023870 sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826897:     103 cycles:ppp: ffffffff8300c331 intel_pmu_handle_irq (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826899:    1615 cycles:ppp: ffffffff830231f8 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826902:   26724 cycles:ppp: ffffffff8384c6a7 native_irq_return_iret (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826913:  329739 cycles:ppp:     7fb2a5410932 [unknown] ([unknown])
      :9031 9031 32001.827033: 1225451 cycles:ppp:     7fb2a5410930 [unknown] ([unknown])
      :9031 9031 32001.827474: 1391725 cycles:ppp:     7fb2a5410930 [unknown] ([unknown])
      :9031 9031 32001.827978: 1233697 cycles:ppp:     7fb2a5410928 [unknown] ([unknown])
  #

After:

  # perf record --delay 1000 stress --cpu 1 --timeout 5
  stress: info: [9741] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [9741] successful run completed in 5s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.751 MB perf.data (15976 samples) ]
  # perf script | head
     stress  9742 32110.959106:          1 cycles:ppp:  ffffffff831b26f6 __perf_event_task_sched_in (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959110:       1 cycles:ppp: ffffffff8300c2e9 intel_pmu_handle_irq (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959112:       7 cycles:ppp: ffffffff830231e0 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959115:     101 cycles:ppp: ffffffff83023870 sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959117:    1533 cycles:ppp: ffffffff830231f8 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959119:   23992 cycles:ppp: ffffffff831b0900 ctx_sched_in (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959129:  329406 cycles:ppp:     7f4b1b661930 __random_r (/usr/lib64/libc-2.25.so)
     stress 9742 32110.959249: 1288322 cycles:ppp:     5566e1e7cbc9 hogcpu (/usr/bin/stress)
     stress 9742 32110.959712: 1464046 cycles:ppp:     7f4b1b66179e __random (/usr/lib64/libc-2.25.so)
     stress 9742 32110.960241: 1266918 cycles:ppp:     7f4b1b66195b __random_r (/usr/lib64/libc-2.25.so)
  #

Reported-by: Bram Stolk <b.stolk@gmail.com>
Tested-by: Bram Stolk <b.stolk@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 6619a53ef757 ("perf record: Add --initial-delay option")
Link: http://lkml.kernel.org/n/tip-nrdfchshqxf7diszhxcecqb9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3d7f33e19df2..5f78ce943407 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -339,6 +339,22 @@ static int record__open(struct record *rec)
 	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
+	/*
+	 * For initial_delay we need to add a dummy event so that we can track
+	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
+	 * real events, the ones asked by the user.
+	 */
+	if (opts->initial_delay) {
+		if (perf_evlist__add_dummy(evlist))
+			return -ENOMEM;
+
+		pos = perf_evlist__first(evlist);
+		pos->tracking = 0;
+		pos = perf_evlist__last(evlist);
+		pos->tracking = 1;
+		pos->attr.enable_on_exec = 1;
+	}
+
 	perf_evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, pos) {
-- 
2.13.6
