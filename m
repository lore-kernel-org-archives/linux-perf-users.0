From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/7] perf evlist: Allow reusing the side band thread for more purposes
Date: Mon, 27 Apr 2020 18:19:34 -0300
Message-ID: <20200427211935.25789-7-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. so far we had just one event in that side band thread, a dummy one
with attr.bpf_event set, so that 'perf record' can go ahead and ask the
kernel for further information about BPF programs being loaded.

Allow for more than one event to be there, so that we can use it as
well for the upcoming --switch-output-event feature.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 22 ++++++++++++++++++++++
 tools/perf/util/evlist.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1d0d36da223b..849058766757 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->core.attr.sample_id_all	  = 1;
+		evsel->core.attr.watermark	  = 1;
+		evsel->core.attr.wakeup_watermark = 1;
+		evsel->side_band.cb   = cb;
+		evsel->side_band.data = data;
+	}
+}
+
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target)
 {
@@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 	if (perf_evlist__create_maps(evlist, target))
 		goto out_delete_evlist;
 
+	if (evlist->core.nr_entries > 1) {
+		bool can_sample_identifier = perf_can_sample_identifier();
+
+		evlist__for_each_entry(evlist, counter)
+			perf_evsel__set_sample_id(counter, can_sample_identifier);
+
+		perf_evlist__set_id_pos(evlist);
+	}
+
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__open(counter, evlist->core.cpus,
 				     evlist->core.threads) < 0)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0f02408fff3e..1a8a979ae137 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -111,6 +111,7 @@ int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
-- 
2.21.1
