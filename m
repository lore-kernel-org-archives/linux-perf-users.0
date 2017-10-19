From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/8] perf tools: Check wether the eBPF file exists in event parsing
Date: Thu, 19 Oct 2017 14:45:10 -0300
Message-ID: <20171019174515.7407-4-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Adding the check wether the eBPF file exists, to consider it
as eBPF input file. This way we can differentiate eBPF events
from events that end up with same suffix as eBPF file.

Before:

  $ perf stat -e 'cpu/uops_executed.core/'  true
  bpf: builtin compilation failed: -95, try external compiler
  WARNING:        unable to get correct kernel building directory.
  Hint:   Set correct kbuild directory using 'kbuild-dir' option in [llvm]
          section of ~/.perfconfig or set it to "" to suppress kbuild
          detection.

  event syntax error: 'cpu/uops_executed.core/'
                       \___ Failed to load cpu/uops_executed.c from source: 'version' section incorrect or lost

After:

  $ perf stat -e 'cpu/uops_executed.core/'  true

   Performance counter stats for 'true':

             181,533      cpu/uops_executed.core/:u

         0.002795447 seconds time elapsed

If user makes type in the eBPF file, we prioritize the event syntax
and show following warning:

  $ perf stat -e 'krava.c//'  true
  event syntax error: 'krava.c//'
                       \___ Cannot find PMU `krava.c'. Missing kernel support?

Reported-and-Tested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20171013083736.15037-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.l | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index c42edeac451f..dcfdafdc2f1c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -8,6 +8,9 @@
 
 %{
 #include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
 #include "../perf.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
@@ -53,9 +56,8 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
-static bool isbpf(yyscan_t scanner)
+static bool isbpf_suffix(char *text)
 {
-	char *text = parse_events_get_text(scanner);
 	int len = strlen(text);
 
 	if (len < 2)
@@ -68,6 +70,17 @@ static bool isbpf(yyscan_t scanner)
 	return false;
 }
 
+static bool isbpf(yyscan_t scanner)
+{
+	char *text = parse_events_get_text(scanner);
+	struct stat st;
+
+	if (!isbpf_suffix(text))
+		return false;
+
+	return stat(text, &st) == 0;
+}
+
 /*
  * This function is called when the parser gets two kind of input:
  *
-- 
2.13.6
