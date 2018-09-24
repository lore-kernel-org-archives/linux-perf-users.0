From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/27] perf script: Enhance sample flags for trace begin / end
Date: Mon, 24 Sep 2018 12:02:36 -0300
Message-ID: <20180924150242.14235-22-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Allow for different combinations of sample flags with "trace begin" or
"trace end".

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, prepare 'perf script' to
display sample flags with more combinations that include trace begin /
end. In those cases display 'tr start' and 'tr end' separately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7732346bd9dd..4da5e32b9e03 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1262,6 +1262,18 @@ static struct {
 	{0, NULL}
 };
 
+static const char *sample_flags_to_name(u32 flags)
+{
+	int i;
+
+	for (i = 0; sample_flags[i].name ; i++) {
+		if (sample_flags[i].flags == flags)
+			return sample_flags[i].name;
+	}
+
+	return NULL;
+}
+
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
@@ -1271,11 +1283,20 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	char str[33];
 	int i, pos = 0;
 
-	for (i = 0; sample_flags[i].name ; i++) {
-		if (sample_flags[i].flags == (flags & ~PERF_IP_FLAG_IN_TX)) {
-			name = sample_flags[i].name;
-			break;
-		}
+	name = sample_flags_to_name(flags & ~PERF_IP_FLAG_IN_TX);
+	if (name)
+		return fprintf(fp, "  %-15s%4s ", name, in_tx ? "(x)" : "");
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_BEGIN));
+		if (name)
+			return fprintf(fp, "  tr strt %-7s%4s ", name, in_tx ? "(x)" : "");
+	}
+
+	if (flags & PERF_IP_FLAG_TRACE_END) {
+		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_END));
+		if (name)
+			return fprintf(fp, "  tr end  %-7s%4s ", name, in_tx ? "(x)" : "");
 	}
 
 	for (i = 0; i < n; i++, flags >>= 1) {
@@ -1288,10 +1309,7 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	}
 	str[pos] = 0;
 
-	if (name)
-		return fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
-
-	return fprintf(fp, "  %-11s ", str);
+	return fprintf(fp, "  %-19s ", str);
 }
 
 struct printer_data {
-- 
2.14.4
