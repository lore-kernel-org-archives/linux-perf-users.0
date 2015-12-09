From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 04/22] perf refcnt: refcnt shows summary per object
Date: Wed, 09 Dec 2015 11:10:57 +0900
Message-ID: <20151209021057.10245.89483.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Report refcnt per object(class) summary numbers if
any leaks exist, not only the total number.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/refcnt.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/refcnt.c b/tools/perf/util/refcnt.c
index e83e9a8..5348406 100644
--- a/tools/perf/util/refcnt.c
+++ b/tools/perf/util/refcnt.c
@@ -157,8 +157,48 @@ static void pr_refcnt_object(struct refcnt_object *ref)
 		pr_refcnt_buffer(buf);
 }
 
+#define REFCNT_STAT_NUM	16
+static struct refcnt_stat_entry {
+	int counter;
+	const char *name;
+} stat_entry[REFCNT_STAT_NUM] = { {.name = "(others)"}, };
+
+static struct refcnt_stat_entry *refcnt_stat__find_entry(const char *name)
+{
+	int i;
+
+	if (!name)
+		goto last;
+
+	for (i = 1; i < REFCNT_STAT_NUM; i++)
+		if (stat_entry[i].name) {
+			if (strcmp(stat_entry[i].name, name) == 0)
+				return &stat_entry[i];
+		} else {
+			stat_entry[i].name = name;
+			return &stat_entry[i];
+		}
+last:
+	/* Here, it shorts the slot, let it fold to others */
+	return &stat_entry[0];
+}
+
+static void pr_refcnt_stat(void)
+{
+	int i;
+
+	for (i = 1; i < REFCNT_STAT_NUM && stat_entry[i].name; i++)
+		pr_warning("  \"%s\" leaks %d objects\n",
+			   stat_entry[i].name, stat_entry[i].counter);
+
+	if (stat_entry[0].counter)
+		pr_warning("  And others leak %d objects\n",
+			stat_entry[0].counter);
+}
+
 static void  __attribute__((destructor)) refcnt__dump_unreclaimed(void)
 {
+	struct refcnt_stat_entry *ent;
 	struct refcnt_object *ref, *n;
 	int h, i = 0;
 
@@ -174,11 +214,15 @@ found:
 				pr_debug("==== [%d] ====\n", i);
 				pr_refcnt_object(ref);
 			}
+			ent = refcnt_stat__find_entry(ref->name);
+			if (ent)
+				ent->counter++;
 			refcnt_object__delete(ref);
 			i++;
 		}
 
 	pr_warning("REFCNT: Total %d objects are not reclaimed.\n", i);
+	pr_refcnt_stat();
 	if (!verbose)
 		pr_warning("   To see all backtraces, rerun with -v option\n");
 }
