Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F18186E2D;
	Thu, 27 Feb 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633440; cv=none; b=cYCK+B0oM+Q2Wq+wIX5z02hT178AlLqMW79sbJLkLoe60RYALJuT2zF4yyy/3QMKs7LhIWIQcKL3NmJyAlUDdLa46kE8OScVudlzr0JVEW+Mxi/5e+TGR7VGfdoB6NghUKS7NldxUHnR9HGUA37MHFCSjUMqZpCKwMhJLRTJ9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633440; c=relaxed/simple;
	bh=oEIKXLa+lC5gpgRN/t7bIplihoQJx5CcIDuHuxDQYsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsV5gbH6txjg6FQgZWPzVihcUZVLBmQmEDXFUvlR5x+3Y7MNeHWK2wXepcihJjvfZshnvk2oG+Z7XfxVC7DxONf6ZC8XHojaqBBlE97Q4+y1x9CIeKO8W2Dk3ScWJ1y4ayBv3WPSpzDdWKZVfquIyudTWAARbU/fyM4JhQ9ZhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxEu948t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxEu948t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD80C4CEE5;
	Thu, 27 Feb 2025 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740633439;
	bh=oEIKXLa+lC5gpgRN/t7bIplihoQJx5CcIDuHuxDQYsc=;
	h=From:To:Cc:Subject:Date:From;
	b=uxEu948txvDodPuxC23TYrHwvLHoqpA283ysFZi5RfyXIyK5zisx5kbvnqzAzMLAm
	 z2ckgEQaCH8dbfJdEknns1U0xZoDWaXwByOWvBD/Kkgl1rJ5m+ecEdI6sTV5o+Mgev
	 es8jIMCEYxFuWy3uDiwj1laPDd0yCamG2abAIPthB2JdgG4/skW/8xEIDzUUnZ0D3Q
	 0vzI1320k0xX56RZGqbeomkfxOiVmwKQgDxDTXuCYZJF+SblxlCH+SRwZtKUGfTzn7
	 WtUXwVuSl0x1U0MegrRinJ7jrMPUdZpkRxKALkaqCFhNuywnjNGdMlJvjkpipitsPA
	 nHryE4OGw1R6Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2] perf tools: Skip BPF sideband event for userspace profiling
Date: Wed, 26 Feb 2025 21:17:18 -0800
Message-ID: <20250227051718.1176930-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF sideband information is tracked using a separate thread and
evlist.  But it's only useful for profiling kernel and we can skip it
when users profile their application only in userspace.

It seems it already fails to open the sideband event in that case.
Let's remove the noise in the verbose output anyway.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) add evlist__setup_sb_evlist()

 tools/perf/builtin-record.c       | 24 +++++++++---------------
 tools/perf/builtin-top.c          | 20 ++++----------------
 tools/perf/util/evlist.c          | 14 ++++++++++++++
 tools/perf/util/evlist.h          |  4 ++++
 tools/perf/util/sideband_evlist.c | 31 +++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0e45bd64185403ae..ab6bef710a689f7f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2166,23 +2166,14 @@ static int record__setup_sb_evlist(struct record *rec)
 		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
 		rec->thread_id = pthread_self();
 	}
-#ifdef HAVE_LIBBPF_SUPPORT
-	if (!opts->no_bpf_event) {
-		if (rec->sb_evlist == NULL) {
-			rec->sb_evlist = evlist__new();
-
-			if (rec->sb_evlist == NULL) {
-				pr_err("Couldn't create side band evlist.\n.");
-				return -1;
-			}
-		}
 
-		if (evlist__add_bpf_sb_event(rec->sb_evlist, &rec->session->header.env)) {
-			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
-			return -1;
-		}
+	if (rec->sb_evlist == NULL) {
+		rec->sb_evlist = evlist__setup_sb_evlist(rec->evlist, opts,
+							 &rec->session->header.env);
+		if (IS_ERR(rec->sb_evlist))
+			return PTR_ERR(rec->sb_evlist);
 	}
-#endif
+
 	if (evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
@@ -2535,6 +2526,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_free_threads;
 	}
 
+	if (!evlist__needs_bpf_sb_event(rec->evlist))
+		opts->no_bpf_event = true;
+
 	err = record__setup_sb_evlist(rec);
 	if (err)
 		goto out_free_threads;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6440b5c1757d92ce..f727738faa154564 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1833,23 +1833,11 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-#ifdef HAVE_LIBBPF_SUPPORT
-	if (!top.record_opts.no_bpf_event) {
-		top.sb_evlist = evlist__new();
-
-		if (top.sb_evlist == NULL) {
-			pr_err("Couldn't create side band evlist.\n.");
-			status = -EINVAL;
-			goto out_delete_evlist;
-		}
-
-		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
-			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
-			status = -EINVAL;
-			goto out_delete_evlist;
-		}
+	top.sb_evlist = evlist__setup_sb_evlist(top.evlist, &top.record_opts, &perf_env);
+	if (IS_ERR(top.sb_evlist)) {
+		status = PTR_ERR(top.sb_evlist);
+		goto out_delete_evlist;
 	}
-#endif
 
 	if (evlist__start_sb_thread(top.sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0dd174e2debdbe8..43adf6b3d855771a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2594,3 +2594,17 @@ bool evlist__has_bpf_output(struct evlist *evlist)
 
 	return false;
 }
+
+bool evlist__needs_bpf_sb_event(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_dummy_event(evsel))
+			continue;
+		if (!evsel->core.attr.exclude_kernel)
+			return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index adddb1db1ad2b25d..1bba5c73b1425834 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -19,6 +19,7 @@
 struct pollfd;
 struct thread_map;
 struct perf_cpu_map;
+struct perf_env;
 struct record_opts;
 struct target;
 
@@ -117,6 +118,8 @@ struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide);
 int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
 			 evsel__sb_cb_t cb, void *data);
 void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data);
+struct evlist *evlist__setup_sb_evlist(struct evlist *evlist, struct record_opts *opts,
+				       struct perf_env *env);
 int evlist__start_sb_thread(struct evlist *evlist, struct target *target);
 void evlist__stop_sb_thread(struct evlist *evlist);
 
@@ -435,5 +438,6 @@ void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
 bool evlist__has_bpf_output(struct evlist *evlist);
+bool evlist__needs_bpf_sb_event(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 388846f17bc13fb9..e75a335e11676cdc 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include "util/bpf-event.h"
 #include "util/debug.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/mmap.h"
 #include "util/perf_api_probe.h"
+#include "util/record.h"
 #include <perf/mmap.h>
+#include <linux/err.h>
 #include <linux/perf_event.h>
 #include <limits.h>
 #include <pthread.h>
@@ -94,6 +97,34 @@ void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data)
       }
 }
 
+struct evlist *evlist__setup_sb_evlist(struct evlist *evlist, struct record_opts *opts,
+				       struct perf_env *env)
+{
+	struct evlist *sb_evlist = NULL;
+
+	if (!evlist__needs_bpf_sb_event(evlist))
+		opts->no_bpf_event = true;
+
+	if (opts->no_bpf_event)
+		return NULL;
+
+#ifdef HAVE_LIBBPF_SUPPORT
+	sb_evlist = evlist__new();
+	if (sb_evlist == NULL) {
+		pr_err("Couldn't create side band evlist.\n.");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (evlist__add_bpf_sb_event(sb_evlist, env)) {
+		pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+		evlist__delete(sb_evlist);
+		return ERR_PTR(-EINVAL);
+	}
+#endif
+
+	return sb_evlist;
+}
+
 int evlist__start_sb_thread(struct evlist *evlist, struct target *target)
 {
 	struct evsel *counter;
-- 
2.48.1.658.g4767266eb4-goog

