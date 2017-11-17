From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/83] perf record: Fix -c/-F options for cpu event aliases
Date: Fri, 17 Nov 2017 17:15:16 -0300
Message-ID: <20171117201601.24110-39-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161733AbdKQUSX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:23 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andi Kleen <ak@linux.intel.com>

The Intel PMU event aliases have a implicit period= specifier to set the
default period.

Unfortunately this breaks overriding these periods with -c or -F,
because the alias terms look like they are user specified to the
internal parser, and user specified event qualifiers override the
command line options.

Track that they are coming from aliases by adding a "weak" state to the
term. Any weak terms don't override command line options.

I only did it for -c/-F for now, I think that's the only case that's
broken currently.

Before:

$ perf record -c 1000 -vv -e uops_issued.any
...
  { sample_period, sample_freq }   2000003

After:

$ perf record -c 1000 -vv -e uops_issued.any
...
  { sample_period, sample_freq }   1000

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171020202755.21410-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c        | 12 ++++++++----
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c |  2 ++
 tools/perf/util/parse-events.h |  3 +++
 tools/perf/util/pmu.c          |  5 +++++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f894893c203d..bfde6a7a80f2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -733,12 +733,16 @@ static void apply_config_terms(struct perf_evsel *evsel,
 	list_for_each_entry(term, config_terms, list) {
 		switch (term->type) {
 		case PERF_EVSEL__CONFIG_TERM_PERIOD:
-			attr->sample_period = term->val.period;
-			attr->freq = 0;
+			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
+				attr->sample_period = term->val.period;
+				attr->freq = 0;
+			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
-			attr->sample_freq = term->val.freq;
-			attr->freq = 1;
+			if (!(term->weak && opts->user_freq != UINT_MAX)) {
+				attr->sample_freq = term->val.freq;
+				attr->freq = 1;
+			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
 			if (term->val.time)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9277df96ffda..157f49e8a772 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -67,6 +67,7 @@ struct perf_evsel_config_term {
 		bool	overwrite;
 		char	*branch;
 	} val;
+	bool weak;
 };
 
 struct perf_stat_evsel;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a7fcd95961ef..170316795a18 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1116,6 +1116,7 @@ do {								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
 	__t->val.__name = __val;				\
+	__t->weak	= term->weak;				\
 	list_add_tail(&__t->list, head_terms);			\
 } while (0)
 
@@ -2410,6 +2411,7 @@ static int new_term(struct parse_events_term **_term,
 
 	*term = *temp;
 	INIT_LIST_HEAD(&term->list);
+	term->weak = false;
 
 	switch (term->type_val) {
 	case PARSE_EVENTS__TERM_TYPE_NUM:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index be337c266697..88108cd11b4c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -101,6 +101,9 @@ struct parse_events_term {
 	/* error string indexes for within parsed string */
 	int err_term;
 	int err_val;
+
+	/* Coming from implicit alias */
+	bool weak;
 };
 
 struct parse_events_error {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 07cb2ac041d7..80fb1593913a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -405,6 +405,11 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
 			parse_events_terms__purge(&list);
 			return ret;
 		}
+		/*
+		 * Weak terms don't override command line options,
+		 * which we don't want for implicit terms in aliases.
+		 */
+		cloned->weak = true;
 		list_add_tail(&cloned->list, &list);
 	}
 	list_splice(&list, terms);
-- 
2.13.6
