From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/15] perf data: Add mmap[2] events to CTF conversion
Date: Fri, 28 Jul 2017 17:00:20 -0300
Message-ID: <20170728200021.11389-15-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, Julien Desfossez <jdesfossez@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Geneviève Bastien <gbastien@versatic.net>

This adds the mmap and mmap2 events to the CTF trace obtained from perf
data.

These events will allow CTF trace visualization tools like Trace Compass
to automatically resolve the symbols of the callchain to the
corresponding function or origin library.

To include those events, one needs to convert with the --all option.
Here follows an output of babeltrace:

  $ sudo perf data convert --all --to-ctf myctftrace
  $ babeltrace ./myctftrace
  [19:00:00.000000000] (+0.000000000) perf_mmap2: { cpu_id = 0 },
 { pid = 638, tid = 638, start = 0x7F54AE39E000, filename =
 "/usr/lib/ld-2.25.so" }
  [19:00:00.000000000] (+0.000000000) perf_mmap2: { cpu_id = 0 }, { pid =
 638, tid = 638, start = 0x7F54AE565000, filename =
 "/usr/lib/libudev.so.1.6.6" }
  [19:00:00.000000000] (+0.000000000) perf_mmap2: { cpu_id = 0 }, { pid =
 638, tid = 638, start = 0x7FFC093EA000, filename = "[vdso]" }

Signed-off-by: Geneviève Bastien <gbastien@versatic.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Julien Desfossez <jdesfossez@efficios.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170727181205.24843-2-gbastien@versatic.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index eeb2590a3ddf..2346cecb8ea2 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -76,6 +76,8 @@ struct ctf_writer {
 	struct bt_ctf_event_class	*comm_class;
 	struct bt_ctf_event_class	*exit_class;
 	struct bt_ctf_event_class	*fork_class;
+	struct bt_ctf_event_class	*mmap_class;
+	struct bt_ctf_event_class	*mmap2_class;
 };
 
 struct convert {
@@ -915,6 +917,18 @@ __FUNC_PROCESS_NON_SAMPLE(exit,
 	__NON_SAMPLE_SET_FIELD(fork, u32, ptid);
 	__NON_SAMPLE_SET_FIELD(fork, u64, time);
 )
+__FUNC_PROCESS_NON_SAMPLE(mmap,
+	__NON_SAMPLE_SET_FIELD(mmap, u32, pid);
+	__NON_SAMPLE_SET_FIELD(mmap, u32, tid);
+	__NON_SAMPLE_SET_FIELD(mmap, u64_hex, start);
+	__NON_SAMPLE_SET_FIELD(mmap, string, filename);
+)
+__FUNC_PROCESS_NON_SAMPLE(mmap2,
+	__NON_SAMPLE_SET_FIELD(mmap2, u32, pid);
+	__NON_SAMPLE_SET_FIELD(mmap2, u32, tid);
+	__NON_SAMPLE_SET_FIELD(mmap2, u64_hex, start);
+	__NON_SAMPLE_SET_FIELD(mmap2, string, filename);
+)
 #undef __NON_SAMPLE_SET_FIELD
 #undef __FUNC_PROCESS_NON_SAMPLE
 
@@ -1254,6 +1268,19 @@ __FUNC_ADD_NON_SAMPLE_EVENT_CLASS(exit,
 	__NON_SAMPLE_ADD_FIELD(u64, time);
 )
 
+__FUNC_ADD_NON_SAMPLE_EVENT_CLASS(mmap,
+	__NON_SAMPLE_ADD_FIELD(u32, pid);
+	__NON_SAMPLE_ADD_FIELD(u32, tid);
+	__NON_SAMPLE_ADD_FIELD(u64_hex, start);
+	__NON_SAMPLE_ADD_FIELD(string, filename);
+)
+
+__FUNC_ADD_NON_SAMPLE_EVENT_CLASS(mmap2,
+	__NON_SAMPLE_ADD_FIELD(u32, pid);
+	__NON_SAMPLE_ADD_FIELD(u32, tid);
+	__NON_SAMPLE_ADD_FIELD(u64_hex, start);
+	__NON_SAMPLE_ADD_FIELD(string, filename);
+)
 #undef __NON_SAMPLE_ADD_FIELD
 #undef __FUNC_ADD_NON_SAMPLE_EVENT_CLASS
 
@@ -1271,6 +1298,12 @@ static int setup_non_sample_events(struct ctf_writer *cw,
 	ret = add_fork_event(cw);
 	if (ret)
 		return ret;
+	ret = add_mmap_event(cw);
+	if (ret)
+		return ret;
+	ret = add_mmap2_event(cw);
+	if (ret)
+		return ret;
 	return 0;
 }
 
@@ -1572,6 +1605,8 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
 		c.tool.fork = process_fork_event;
+		c.tool.mmap = process_mmap_event;
+		c.tool.mmap2 = process_mmap2_event;
 	}
 
 	err = perf_config(convert__config, &c);
-- 
2.9.4
