From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/15] perf tools: Dedup events in expression parsing
Date: Wed, 23 Aug 2017 16:36:06 -0300
Message-ID: <20170823193614.20394-8-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Avoid adding redundant events while parsing an expression.  When we add
an "other" event check first if it already exists.

v2: Fix perf test failure.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170811232634.30465-10-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.y | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 5753c4f21534..432b8560cf51 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -181,6 +181,19 @@ void expr__ctx_init(struct parse_ctx *ctx)
 	ctx->num_ids = 0;
 }
 
+static bool already_seen(const char *val, const char *one, const char **other,
+			 int num_other)
+{
+	int i;
+
+	if (one && !strcasecmp(one, val))
+		return true;
+	for (i = 0; i < num_other; i++)
+		if (!strcasecmp(other[i], val))
+			return true;
+	return false;
+}
+
 int expr__find_other(const char *p, const char *one, const char ***other,
 		     int *num_otherp)
 {
@@ -200,7 +213,7 @@ int expr__find_other(const char *p, const char *one, const char ***other,
 			err = 0;
 			break;
 		}
-		if (tok == ID && (!one || strcasecmp(one, val.id))) {
+		if (tok == ID && !already_seen(val.id, one, *other, num_other)) {
 			if (num_other >= EXPR_MAX_OTHER - 1) {
 				pr_debug("Too many extra events in %s\n", orig);
 				break;
-- 
2.13.5
