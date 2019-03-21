From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/44] perf evlist: Introduce side band thread
Date: Thu, 21 Mar 2019 15:51:39 -0300
Message-ID: <20190321185142.11441-42-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Stanislav Fomichev <sdf@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patch introduces side band thread that captures extended
information for events like PERF_RECORD_BPF_EVENT.

This new thread uses its own evlist that uses ring buffer with very low
watermark for lower latency.

To use side band thread, we need to:

1. add side band event(s) by calling perf_evlist__add_sb_event();
2. calls perf_evlist__start_sb_thread();
3. at the end of perf run, perf_evlist__stop_sb_thread().

In the next patch, we use this thread to handle PERF_RECORD_BPF_EVENT.

Committer notes:

Add fix by Jiri Olsa for when te sb_tread can't get started and then at
the end the stop_sb_thread() segfaults when joining the (non-existing)
thread.

That can happen when running 'perf top' or 'perf record' as a normal
user, for instance.

Further checks need to be done on top of this to more graciously handle
these possible failure scenarios.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-15-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |   9 +++
 tools/perf/builtin-top.c    |   9 +++
 tools/perf/util/evlist.c    | 119 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  12 ++++
 tools/perf/util/evsel.h     |   6 ++
 5 files changed, 155 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e79faccd7842..6f645fd72fed 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1137,6 +1137,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
+	struct perf_evlist *sb_evlist = NULL;
 	int fd;
 
 	atexit(record__sig_exit);
@@ -1237,6 +1238,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1487,6 +1493,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 out_delete_session:
 	perf_session__delete(session);
+
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
 	return status;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c2ea22c4ea67..3ce8a8db6c1d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1501,6 +1501,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_END()
 	};
+	struct perf_evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1636,8 +1637,16 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (perf_evlist__start_sb_thread(sb_evlist, target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
 	status = __cmd_top(&top);
 
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
+
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
 	perf_session__delete(top.session);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..ec78e93085de 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -19,6 +19,7 @@
 #include "debug.h"
 #include "units.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 #include <signal.h>
 #include <unistd.h>
 
@@ -1856,3 +1857,121 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
 	}
 	return leader;
 }
+
+int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+			      struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb,
+			      void *data)
+{
+	struct perf_evsel *evsel;
+	bool new_evlist = (*evlist) == NULL;
+
+	if (*evlist == NULL)
+		*evlist = perf_evlist__new();
+	if (*evlist == NULL)
+		return -1;
+
+	if (!attr->sample_id_all) {
+		pr_warning("enabling sample_id_all for all side band events\n");
+		attr->sample_id_all = 1;
+	}
+
+	evsel = perf_evsel__new_idx(attr, (*evlist)->nr_entries);
+	if (!evsel)
+		goto out_err;
+
+	evsel->side_band.cb = cb;
+	evsel->side_band.data = data;
+	perf_evlist__add(*evlist, evsel);
+	return 0;
+
+out_err:
+	if (new_evlist) {
+		perf_evlist__delete(*evlist);
+		*evlist = NULL;
+	}
+	return -1;
+}
+
+static void *perf_evlist__poll_thread(void *arg)
+{
+	struct perf_evlist *evlist = arg;
+	bool draining = false;
+	int i;
+
+	while (draining || !(evlist->thread.done)) {
+		if (draining)
+			draining = false;
+		else if (evlist->thread.done)
+			draining = true;
+
+		if (!draining)
+			perf_evlist__poll(evlist, 1000);
+
+		for (i = 0; i < evlist->nr_mmaps; i++) {
+			struct perf_mmap *map = &evlist->mmap[i];
+			union perf_event *event;
+
+			if (perf_mmap__read_init(map))
+				continue;
+			while ((event = perf_mmap__read_event(map)) != NULL) {
+				struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+
+				if (evsel && evsel->side_band.cb)
+					evsel->side_band.cb(event, evsel->side_band.data);
+				else
+					pr_warning("cannot locate proper evsel for the side band event\n");
+
+				perf_mmap__consume(map);
+			}
+			perf_mmap__read_done(map);
+		}
+	}
+	return NULL;
+}
+
+int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+				 struct target *target)
+{
+	struct perf_evsel *counter;
+
+	if (!evlist)
+		return 0;
+
+	if (perf_evlist__create_maps(evlist, target))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (perf_evsel__open(counter, evlist->cpus,
+				     evlist->threads) < 0)
+			goto out_delete_evlist;
+	}
+
+	if (perf_evlist__mmap(evlist, UINT_MAX))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (perf_evsel__enable(counter))
+			goto out_delete_evlist;
+	}
+
+	evlist->thread.done = 0;
+	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
+		goto out_delete_evlist;
+
+	return 0;
+
+out_delete_evlist:
+	perf_evlist__delete(evlist);
+	evlist = NULL;
+	return -1;
+}
+
+void perf_evlist__stop_sb_thread(struct perf_evlist *evlist)
+{
+	if (!evlist)
+		return;
+	evlist->thread.done = 1;
+	pthread_join(evlist->thread.th, NULL);
+	perf_evlist__delete(evlist);
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 744906dd4887..dcb68f34d2cd 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -54,6 +54,10 @@ struct perf_evlist {
 				       struct perf_sample *sample);
 	u64		first_sample_time;
 	u64		last_sample_time;
+	struct {
+		pthread_t		th;
+		volatile int		done;
+	} thread;
 };
 
 struct perf_evsel_str_handler {
@@ -87,6 +91,14 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 
 int perf_evlist__add_dummy(struct perf_evlist *evlist);
 
+int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+			      struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb,
+			      void *data);
+int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+				 struct target *target);
+void perf_evlist__stop_sb_thread(struct perf_evlist *evlist);
+
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cc578e02e08f..0f2c6c93d721 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -73,6 +73,8 @@ struct perf_evsel_config_term {
 
 struct perf_stat_evsel;
 
+typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -151,6 +153,10 @@ struct perf_evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	const char		*pmu_name;
+	struct {
+		perf_evsel__sb_cb_t	*cb;
+		void			*data;
+	} side_band;
 };
 
 union u64_swap {
-- 
2.20.1
