From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/37] perf script: Handle missing fields with -F +..
Date: Mon, 25 Feb 2019 18:20:24 -0300
Message-ID: <20190225212035.24781-27-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When using -F + syntax to add a field the existing defaults are
currently all marked user_set. This can cause errors when some field is
missing in the perf.data

This patch tracks the actually user set fields separately, so that we don't
error out in this case.

Before:

  % perf record true
  % perf script -F +metric
  Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
  %

After:

  5 perf record true
  % perf script -F +metric
              perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
  ...
  %

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5b1543f42290..2d8cb1d1682c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -149,6 +149,7 @@ static struct {
 	unsigned int print_ip_opts;
 	u64 fields;
 	u64 invalid_fields;
+	u64 user_set_fields;
 } output[OUTPUT_TYPE_MAX] = {
 
 	[PERF_TYPE_HARDWARE] = {
@@ -345,7 +346,7 @@ static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
 	if (attr->sample_type & sample_type)
 		return 0;
 
-	if (output[type].user_set) {
+	if (output[type].user_set_fields & field) {
 		if (allow_user_set)
 			return 0;
 		evname = perf_evsel__name(evsel);
@@ -2632,10 +2633,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
 						   all_output_options[i].str, event_type(j));
 				} else {
-					if (change == REMOVE)
+					if (change == REMOVE) {
 						output[j].fields &= ~all_output_options[i].field;
-					else
+						output[j].user_set_fields &= ~all_output_options[i].field;
+					} else {
 						output[j].fields |= all_output_options[i].field;
+						output[j].user_set_fields |= all_output_options[i].field;
+					}
 					output[j].user_set = true;
 					output[j].wildcard_set = true;
 				}
-- 
2.20.1
