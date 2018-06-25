From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/19] perf alias: Rebuild alias expression string to make it comparable
Date: Mon, 25 Jun 2018 14:40:40 -0300
Message-ID: <20180625174045.25765-15-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

PMU alias definitions in sysfs files may have spaces, newlines and
numbers with leading zeroes. Some alias definitions may also appear in
JSON files without spaces, etc.

Scan alias definitions and remove leading zeroes, spaces, newlines, etc
and rebuild string to make alias->str member comparable.

s390 for example  has terms specified as event=0x0091 (read from files
../<PMU>/events/<FILE> and terms specified as event=0x91 (read from JSON
files).

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180615101105.47047-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2738fc8d200d..f321ce97d9ec 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -241,9 +241,11 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *metric_expr,
 				 char *metric_name)
 {
+	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
 	int ret;
 	int num;
+	char newval[256];
 
 	alias = malloc(sizeof(*alias));
 	if (!alias)
@@ -262,6 +264,27 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		return ret;
 	}
 
+	/* Scan event and remove leading zeroes, spaces, newlines, some
+	 * platforms have terms specified as
+	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
+	 * and terms specified as event=0x91 (read from JSON files).
+	 *
+	 * Rebuild string to make alias->str member comparable.
+	 */
+	memset(newval, 0, sizeof(newval));
+	ret = 0;
+	list_for_each_entry(term, &alias->terms, list) {
+		if (ret)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 ",");
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%#x", term->config, term->val.num);
+		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%s", term->config, term->val.str);
+	}
+
 	alias->name = strdup(name);
 	if (dir) {
 		/*
@@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
-	alias->str = strdup(val);
+	alias->str = strdup(newval);
 
 	list_add_tail(&alias->list, list);
 
-- 
2.14.3
