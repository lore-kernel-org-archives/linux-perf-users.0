From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/86] perf evlist: Allow asking for max precise_ip in add_default()
Date: Wed, 19 Jul 2017 11:29:04 -0300
Message-ID: <20170719142950.3747-41-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932315AbdGSOeE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:34:04 -0400
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are cases where we want to leave attr.precise_ip as zero, such
as when using 'perf record --no-samples', where this would make the
kernel return -EINVAL.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-0u2m2a8rqw781r6m8svqyne8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 4 ++--
 tools/perf/util/evlist.h | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f51c3314015c..078b58511595 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -242,9 +242,9 @@ void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr)
 	}
 }
 
-int perf_evlist__add_default(struct perf_evlist *evlist)
+int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
 {
-	struct perf_evsel *evsel = perf_evsel__new_cycles(true);
+	struct perf_evsel *evsel = perf_evsel__new_cycles(precise);
 
 	if (evsel == NULL)
 		return -ENOMEM;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 8d601fbdd8d6..0843746bc389 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -115,7 +115,14 @@ void perf_evlist__delete(struct perf_evlist *evlist);
 
 void perf_evlist__add(struct perf_evlist *evlist, struct perf_evsel *entry);
 void perf_evlist__remove(struct perf_evlist *evlist, struct perf_evsel *evsel);
-int perf_evlist__add_default(struct perf_evlist *evlist);
+
+int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise);
+
+static inline int perf_evlist__add_default(struct perf_evlist *evlist)
+{
+	return __perf_evlist__add_default(evlist, true);
+}
+
 int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs);
 
-- 
2.9.4
