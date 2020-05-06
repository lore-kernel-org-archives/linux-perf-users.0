From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 75/91] perf evsel: Rename perf_evsel__env() to evsel__env()
Date: Wed,  6 May 2020 12:22:18 -0300
Message-ID: <20200506152234.21977-76-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/evsel.c    | 2 +-
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/machine.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 025e190fd1c2..31575713ad0b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2382,7 +2382,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 
 static const char *errno_to_name(struct evsel *evsel, int err)
 {
-	struct perf_env *env = perf_evsel__env(evsel);
+	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 
 	return arch_syscalls__strerrno(arch_name, err);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index dc3342f5586b..d828c2d2edee 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2156,7 +2156,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		.evsel		= evsel,
 		.options	= options,
 	};
-	struct perf_env *env = perf_evsel__env(evsel);
+	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 	struct arch *arch;
 	int err;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5908cd8761d9..32d178a3f933 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2563,7 +2563,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
-struct perf_env *perf_evsel__env(struct evsel *evsel)
+struct perf_env *evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9de7efb83ffc..d76111c2d6a8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -401,7 +401,7 @@ static inline bool evsel__has_br_stack(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
 }
 
-struct perf_env *perf_evsel__env(struct evsel *evsel);
+struct perf_env *evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da630e9339d3..8ed2135893bb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2619,7 +2619,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		chain_nr = chain->nr;
 
 	if (evsel__has_branch_callstack(evsel)) {
-		struct perf_env *env = perf_evsel__env(evsel);
+		struct perf_env *env = evsel__env(evsel);
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
 						   root_al, max_stack,
-- 
2.21.1
