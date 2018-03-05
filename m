From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/28] perf top: Allow asking for the maximum allowed sample rate
Date: Mon,  5 Mar 2018 11:29:15 -0300
Message-ID: <20180305142932.16921-12-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add the handy '-F max' shortcut, just introduced to 'perf record', to
reading and using the kernel.perf_event_max_sample_rate value as the
user supplied sampling frequency:

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hz04f296zccknnb5at06a6q0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 4 +++-
 tools/perf/builtin-top.c              | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 8a32cc77bead..a039407d63b8 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -55,7 +55,9 @@ Default is to monitor all CPUS.
 
 -F <freq>::
 --freq=<freq>::
-	Profile at this frequency.
+	Profile at this frequency. Use 'max' to use the currently maximum
+	allowed frequency, i.e. the value in the kernel.perf_event_max_sample_rate
+	sysctl.
 
 -i::
 --inherit::
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 35ac016fcb98..bb4f9fafd11d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1307,7 +1307,9 @@ int cmd_top(int argc, const char **argv)
 	OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
 		    "symbol to annotate"),
 	OPT_BOOLEAN('z', "zero", &top.zero, "zero history across updates"),
-	OPT_UINTEGER('F', "freq", &opts->user_freq, "profile at this frequency"),
+	OPT_CALLBACK('F', "freq", &top.record_opts, "freq or 'max'",
+		     "profile at this frequency",
+		      record__parse_freq),
 	OPT_INTEGER('E', "entries", &top.print_entries,
 		    "display this many functions"),
 	OPT_BOOLEAN('U', "hide_user_symbols", &top.hide_user_symbols,
-- 
2.14.3
