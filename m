From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [PATCH 5/6] perf tools: add perf_evlist__terminate() for terminate
Date: Wed, 18 Dec 2019 15:54:54 +0800
Message-ID: <20191218075455.5106-6-tanxiaojun@huawei.com>
References: <20191218075455.5106-1-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191218075455.5106-1-tanxiaojun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com, James.Clark@arm.com, jeremy.linton@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, tanxiaojun@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Wei Li <liwei391@huawei.com>

In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
be set and the event list will be disabled by perf_evlist__disable()
once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be endless.

Mark the evlist's state as terminated, preparing for the following fix.

Signed-off-by: Wei Li <liwei391@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
---
 tools/perf/builtin-record.c |  1 +
 tools/perf/util/evlist.c    | 14 ++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 tools/perf/util/evsel.h     |  1 +
 4 files changed, 17 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fb19ef63cc35..5646949f8cc7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1716,6 +1716,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
 			evlist__disable(rec->evlist);
+			evlist__terminate(rec->evlist);
 			disabled = true;
 		}
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b9c7e5271611..b04794cd8586 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -377,6 +377,20 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 	return true;
 }
 
+void evlist__terminate(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		evsel__disable(pos);
+		pos->terminated = true;
+	}
+
+	evlist->enabled = false;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..9fbd0ce2a1c4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -206,6 +206,7 @@ void evlist__munmap(struct evlist *evlist);
 
 size_t evlist__mmap_size(unsigned long pages);
 
+void evlist__terminate(struct evlist *evlist);
 void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..8e8a2cb41de8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,7 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	bool			terminated;
 };
 
 struct perf_missing_features {
-- 
2.17.1
