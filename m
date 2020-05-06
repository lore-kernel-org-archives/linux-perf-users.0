From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 81/91] perf script: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:24 -0300
Message-ID: <20200506152234.21977-82-acme@kernel.org>
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

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 53 +++++++++++++------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fee56474377b..56d7bcd12671 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -351,10 +351,8 @@ static const char *output_field2str(enum perf_output_field field)
 
 #define PRINT_FIELD(x)  (output[output_type(attr->type)].fields & PERF_OUTPUT_##x)
 
-static int perf_evsel__do_check_stype(struct evsel *evsel,
-				      u64 sample_type, const char *sample_msg,
-				      enum perf_output_field field,
-				      bool allow_user_set)
+static int evsel__do_check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg,
+				 enum perf_output_field field, bool allow_user_set)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	int type = output_type(attr->type);
@@ -383,16 +381,13 @@ static int perf_evsel__do_check_stype(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__check_stype(struct evsel *evsel,
-				   u64 sample_type, const char *sample_msg,
-				   enum perf_output_field field)
+static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg,
+			      enum perf_output_field field)
 {
-	return perf_evsel__do_check_stype(evsel, sample_type, sample_msg, field,
-					  false);
+	return evsel__do_check_stype(evsel, sample_type, sample_msg, field, false);
 }
 
-static int perf_evsel__check_attr(struct evsel *evsel,
-				  struct perf_session *session)
+static int perf_evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	bool allow_user_set;
@@ -404,32 +399,28 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 					       HEADER_AUXTRACE);
 
 	if (PRINT_FIELD(TRACE) &&
-		!perf_session__has_traces(session, "record -R"))
+	    !perf_session__has_traces(session, "record -R"))
 		return -EINVAL;
 
 	if (PRINT_FIELD(IP)) {
-		if (perf_evsel__check_stype(evsel, PERF_SAMPLE_IP, "IP",
-					    PERF_OUTPUT_IP))
+		if (evsel__check_stype(evsel, PERF_SAMPLE_IP, "IP", PERF_OUTPUT_IP))
 			return -EINVAL;
 	}
 
 	if (PRINT_FIELD(ADDR) &&
-		perf_evsel__do_check_stype(evsel, PERF_SAMPLE_ADDR, "ADDR",
-					   PERF_OUTPUT_ADDR, allow_user_set))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_ADDR, "ADDR", PERF_OUTPUT_ADDR, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(DATA_SRC) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC",
-					PERF_OUTPUT_DATA_SRC))
+	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC", PERF_OUTPUT_DATA_SRC))
 		return -EINVAL;
 
 	if (PRINT_FIELD(WEIGHT) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT",
-					PERF_OUTPUT_WEIGHT))
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
 		return -EINVAL;
 
 	if (PRINT_FIELD(SYM) &&
-		!(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
 		pr_err("Display of symbols requested but neither sample IP nor "
 			   "sample address\navailable. Hence, no addresses to convert "
 		       "to symbols.\n");
@@ -441,7 +432,7 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 		return -EINVAL;
 	}
 	if (PRINT_FIELD(DSO) &&
-		!(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
 		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
@@ -458,33 +449,27 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 		return -EINVAL;
 	}
 	if ((PRINT_FIELD(PID) || PRINT_FIELD(TID)) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID",
-					PERF_OUTPUT_TID|PERF_OUTPUT_PID))
+	    evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID", PERF_OUTPUT_TID|PERF_OUTPUT_PID))
 		return -EINVAL;
 
 	if (PRINT_FIELD(TIME) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_TIME, "TIME",
-					PERF_OUTPUT_TIME))
+	    evsel__check_stype(evsel, PERF_SAMPLE_TIME, "TIME", PERF_OUTPUT_TIME))
 		return -EINVAL;
 
 	if (PRINT_FIELD(CPU) &&
-		perf_evsel__do_check_stype(evsel, PERF_SAMPLE_CPU, "CPU",
-					   PERF_OUTPUT_CPU, allow_user_set))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_CPU, "CPU", PERF_OUTPUT_CPU, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(IREGS) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS",
-					PERF_OUTPUT_IREGS))
+	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS", PERF_OUTPUT_IREGS))
 		return -EINVAL;
 
 	if (PRINT_FIELD(UREGS) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS",
-					PERF_OUTPUT_UREGS))
+	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS", PERF_OUTPUT_UREGS))
 		return -EINVAL;
 
 	if (PRINT_FIELD(PHYS_ADDR) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR",
-					PERF_OUTPUT_PHYS_ADDR))
+	    evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR))
 		return -EINVAL;
 
 	return 0;
-- 
2.21.1
