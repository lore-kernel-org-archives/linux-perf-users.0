From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/34] perf annotate: Use perf_env when obtaining the arch name
Date: Thu, 14 Dec 2017 14:42:32 -0300
Message-ID: <20171214174247.16841-20-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754163AbdLNRnn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Dec 2017 12:43:43 -0500
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Paving the way to reuse these routines in other areas, like when
generating errno tables.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rh1qv051vb8gfdcswskrn53h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 17 ++++++++---------
 tools/perf/util/evsel.c    |  7 -------
 tools/perf/util/evsel.h    |  1 -
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bc34b28373f4..eac45ccd5c32 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1420,16 +1420,19 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
-static const char *annotate__norm_arch(const char *arch_name)
+static const char *perf_env__arch(struct perf_env *env)
 {
 	struct utsname uts;
+	char *arch_name;
 
-	if (!arch_name) { /* Assume we are annotating locally. */
+	if (!env) { /* Assume local operation */
 		if (uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
-	}
-	return normalize_arch((char *)arch_name);
+	} else
+		arch_name = env->arch;
+
+	return normalize_arch(arch_name);
 }
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
@@ -1630,14 +1633,10 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		.evsel		= evsel,
 	};
 	struct perf_env *env = perf_evsel__env(evsel);
-	const char *arch_name = NULL;
+	const char *arch_name = perf_env__arch(env);
 	struct arch *arch;
 	int err;
 
-	if (evsel)
-		arch_name = perf_evsel__env_arch(evsel);
-
-	arch_name = annotate__norm_arch(arch_name);
 	if (!arch_name)
 		return -1;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 541897049c6c..4718f0a460df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2835,13 +2835,6 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			 perf_evsel__name(evsel));
 }
 
-char *perf_evsel__env_arch(struct perf_evsel *evsel)
-{
-	if (evsel && evsel->evlist && evsel->evlist->env)
-		return evsel->evlist->env->arch;
-	return NULL;
-}
-
 struct perf_env *perf_evsel__env(struct perf_evsel *evsel)
 {
 	if (evsel && evsel->evlist)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0e961ce60a9c..846e41644525 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -446,7 +446,6 @@ typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv);
 
-char *perf_evsel__env_arch(struct perf_evsel *evsel);
 struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
 
 #endif /* __PERF_EVSEL_H */
-- 
2.13.6
