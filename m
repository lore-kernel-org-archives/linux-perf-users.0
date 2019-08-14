From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/28] perf tools: Add aux-output config term
Date: Wed, 14 Aug 2019 15:40:45 -0300
Message-ID: <20190814184051.3125-23-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Expose the aux_output attribute flag to the user to configure, by adding a
config term 'aux-output'. For events that support it, selection of
'aux-output' causes the generation of AUX records instead of event records.
This requires that an AUX area event is also provided.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-7-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 2 ++
 tools/perf/util/evsel.c                  | 3 +++
 tools/perf/util/evsel.h                  | 2 ++
 tools/perf/util/parse-events.c           | 8 ++++++++
 tools/perf/util/parse-events.h           | 1 +
 tools/perf/util/parse-events.l           | 1 +
 6 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d5e58e0a2bca..c6f9f31b6039 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -60,6 +60,8 @@ OPTIONS
 	  - 'name' : User defined event name. Single quotes (') may be used to
 		    escape symbols in the name from parsing by shell and tool
 		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
+	  - 'aux-output': Generate AUX records instead of events. This requires
+			  that an AUX area event is also provided.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 897a97af2d81..5da40511546b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -833,6 +833,9 @@ static void apply_config_terms(struct evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_PERCORE:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT:
+			attr->aux_output = term->val.aux_output ? 1 : 0;
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3cf35aa782b9..8a316dd54cd0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -52,6 +52,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
 	PERF_EVSEL__CONFIG_TERM_PERCORE,
+	PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT,
 };
 
 struct perf_evsel_config_term {
@@ -70,6 +71,7 @@ struct perf_evsel_config_term {
 		char	*branch;
 		unsigned long max_events;
 		bool	percore;
+		bool	aux_output;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2cfec3b7a982..9101568946d2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -963,6 +963,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
+	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
 };
 
 static bool config_term_shrinked;
@@ -1083,6 +1084,9 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1133,6 +1137,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1225,6 +1230,9 @@ do {								\
 			ADD_CONFIG_TERM(PERCORE, percore,
 					term->val.num ? true : false);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 48111b8fc232..616ca1eda0eb 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -76,6 +76,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
+	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index ca6098874fe2..7469497cd28e 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -284,6 +284,7 @@ no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
+aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-- 
2.21.0
