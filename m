From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/91] perf evsel: Add support for synthesized branch stack sample type
Date: Wed,  6 May 2020 12:21:46 -0300
Message-ID: <20200506152234.21977-44-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Allow for a synthesized branch stack to be added to samples. As with
synthesized call chains, the sample type cannot be changed because it is
needed to continue to parse events. So add and use helper function
evsel__has_br_stack() to indicate a branch stack, whether original or
synthesized.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h   | 10 ++++++++++
 tools/perf/util/session.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a463bc65b001..bf999e3c50c7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -417,6 +417,16 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
+static inline bool evsel__has_br_stack(const struct evsel *evsel)
+{
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded branch
+	 * stack or a branch stack synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK ||
+	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
+}
+
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0b0bfe5bef17..2b5a08a92ce5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1243,7 +1243,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+	if (evsel__has_br_stack(evsel))
 		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
-- 
2.21.1
