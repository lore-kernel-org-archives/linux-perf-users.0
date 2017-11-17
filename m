From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/83] perf evlist: Add helper to check if attr.exclude_kernel is set in all evsels
Date: Fri, 17 Nov 2017 17:15:38 -0300
Message-ID: <20171117201601.24110-61-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759516AbdKQUTb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:31 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The warning about kptr_restrict needs to be emitted only when it is set
and we ask for kernel space samples, so add a helper to help with that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-fh7drty6yljei9gxxzer6eup@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 12 ++++++++++++
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ccb749f9a83f..b62e523a7035 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1786,3 +1786,15 @@ void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist,
 state_err:
 	return;
 }
+
+bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->attr.exclude_kernel)
+			return false;
+	}
+
+	return true;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e72ae64c11ac..491f69542920 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -312,4 +312,6 @@ perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
 
 struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
 					    union perf_event *event);
+
+bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.13.6
