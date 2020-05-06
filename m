From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 72/91] perf evsel: Rename perf_evsel__has*() to evsel__has*()
Date: Wed,  6 May 2020 12:22:15 -0300
Message-ID: <20200506152234.21977-73-acme@kernel.org>
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

As those are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c   | 2 +-
 tools/perf/util/evsel.h   | 4 ++--
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/session.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b63d9eebe42f..909e993b4dcd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2159,7 +2159,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			return -EFAULT;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
-		if (perf_evsel__has_branch_hw_idx(evsel))
+		if (evsel__has_branch_hw_idx(evsel))
 			sz += sizeof(u64);
 		else
 			data->no_hw_idx = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a84a4f6bcf31..101cfff647c7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -372,12 +372,12 @@ for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
-static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
+static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
-static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
+static inline bool evsel__has_branch_hw_idx(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5ac32cabe4e6..da630e9339d3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2618,7 +2618,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (chain)
 		chain_nr = chain->nr;
 
-	if (perf_evsel__has_branch_callstack(evsel)) {
+	if (evsel__has_branch_callstack(evsel)) {
 		struct perf_env *env = perf_evsel__env(evsel);
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7f7d3a1989fd..c11d89e0ee55 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1059,7 +1059,7 @@ static void callchain__printf(struct evsel *evsel,
 	unsigned int i;
 	struct ip_callchain *callchain = sample->callchain;
 
-	if (perf_evsel__has_branch_callstack(evsel))
+	if (evsel__has_branch_callstack(evsel))
 		callchain__lbr_callstack_printf(sample);
 
 	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
@@ -1244,7 +1244,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		callchain__printf(evsel, sample);
 
 	if (evsel__has_br_stack(evsel))
-		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
+		branch_stack__printf(sample, evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		regs_user__printf(sample);
-- 
2.21.1
