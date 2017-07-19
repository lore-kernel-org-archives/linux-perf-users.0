From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/86] perf evsel: Allow asking for max precise_ip in new_cycles()
Date: Wed, 19 Jul 2017 11:29:03 -0300
Message-ID: <20170719142950.3747-40-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932177AbdGSOd7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:33:59 -0400
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
Link: http://lkml.kernel.org/n/tip-4zq1udecxa51gsapyfwej5fj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 7 +++++--
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 46c0faf6c502..f51c3314015c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -244,7 +244,7 @@ void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr)
 
 int perf_evlist__add_default(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evsel__new_cycles();
+	struct perf_evsel *evsel = perf_evsel__new_cycles(true);
 
 	if (evsel == NULL)
 		return -ENOMEM;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0e4cd6092564..df567e478a0e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -268,7 +268,7 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 	return evsel;
 }
 
-struct perf_evsel *perf_evsel__new_cycles(void)
+struct perf_evsel *perf_evsel__new_cycles(bool precise)
 {
 	struct perf_event_attr attr = {
 		.type	= PERF_TYPE_HARDWARE,
@@ -278,6 +278,9 @@ struct perf_evsel *perf_evsel__new_cycles(void)
 	struct perf_evsel *evsel;
 
 	event_attr_init(&attr);
+
+	if (!precise)
+		goto new_event;
 	/*
 	 * Unnamed union member, not supported as struct member named
 	 * initializer in older compilers such as gcc 4.4.7
@@ -292,7 +295,7 @@ struct perf_evsel *perf_evsel__new_cycles(void)
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
 	attr.sample_period = 0;
-
+new_event:
 	evsel = perf_evsel__new(&attr);
 	if (evsel == NULL)
 		goto out;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 219ad0cdb9f4..fb40ca3c6519 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -185,7 +185,7 @@ static inline struct perf_evsel *perf_evsel__newtp(const char *sys, const char *
 	return perf_evsel__newtp_idx(sys, name, 0);
 }
 
-struct perf_evsel *perf_evsel__new_cycles(void);
+struct perf_evsel *perf_evsel__new_cycles(bool precise);
 
 struct event_format *event_format__new(const char *sys, const char *name);
 
-- 
2.9.4
