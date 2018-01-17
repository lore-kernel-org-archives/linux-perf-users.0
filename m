From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/32] perf trace: No need to set PERF_SAMPLE_IDENTIFIER explicitely
Date: Wed, 17 Jan 2018 13:11:54 -0300
Message-ID: <20180117161222.15611-5-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since 75562573bab3 ("perf tools: Add support for
PERF_SAMPLE_IDENTIFIER") we don't need explicitely set
PERF_SAMPLE_IDENTIFIER, as perf_evlist__config() will do this for us,
i.e. when there are more than one evsel in an evlist, it will check if
some evsel has a sample_type different than the one on the first evsel
in the list, setting PERF_SAMPLE_IDENTIFIER in that case.

So, to simplify 'perf trace' codebase, ditch that check.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-12xq6orhwttee2tdtu96ucrp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 71e64bdca86f..e84816d02117 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2348,40 +2348,17 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	perf_evlist__config(evlist, &trace->opts, NULL);
 
 	if (callchain_param.enabled) {
-		bool use_identifier = false;
-
 		if (trace->syscalls.events.sys_exit) {
 			perf_evsel__config_callchain(trace->syscalls.events.sys_exit,
 						     &trace->opts, &callchain_param);
-			use_identifier = true;
 		}
 
 		if (pgfault_maj) {
 			perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
-			use_identifier = true;
 		}
 
 		if (pgfault_min) {
 			perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
-			use_identifier = true;
-		}
-
-		if (use_identifier) {
-		       /*
-			* Now we have evsels with different sample_ids, use
-			* PERF_SAMPLE_IDENTIFIER to map from sample to evsel
-			* from a fixed position in each ring buffer record.
-			*
-			* As of this the changeset introducing this comment, this
-			* isn't strictly needed, as the fields that can come before
-			* PERF_SAMPLE_ID are all used, but we'll probably disable
-			* some of those for things like copying the payload of
-			* pointer syscall arguments, and for vfs_getname we don't
-			* need PERF_SAMPLE_ADDR and PERF_SAMPLE_IP, so do this
-			* here as a warning we need to use PERF_SAMPLE_IDENTIFIER.
-			*/
-			perf_evlist__set_sample_bit(evlist, IDENTIFIER);
-			perf_evlist__reset_sample_bit(evlist, ID);
 		}
 	}
 
-- 
2.14.3
