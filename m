From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/18] perf evlist: Move perf_evsel__reset_weak_group into evlist
Date: Tue,  6 Nov 2018 09:06:00 -0300
Message-ID: <20181106120612.8262-7-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

- Move the function from builtin-stat to evlist for reuse
- Rename to evlist to match purpose better
- Pass the evlist as first argument.
- No functional changes

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181001195927.14211-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 28 +---------------------------
 tools/perf/util/evlist.c  | 27 +++++++++++++++++++++++++++
 tools/perf/util/evlist.h  |  3 +++
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d1028d7755bb..a635abfa77b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -383,32 +383,6 @@ static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
 }
 
-static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
-{
-	struct perf_evsel *c2, *leader;
-	bool is_open = true;
-
-	leader = evsel->leader;
-	pr_debug("Weak group for %s/%d failed\n",
-			leader->name, leader->nr_members);
-
-	/*
-	 * for_each_group_member doesn't work here because it doesn't
-	 * include the first entry.
-	 */
-	evlist__for_each_entry(evsel_list, c2) {
-		if (c2 == evsel)
-			is_open = false;
-		if (c2->leader == leader) {
-			if (is_open)
-				perf_evsel__close(c2);
-			c2->leader = c2;
-			c2->nr_members = 0;
-		}
-	}
-	return leader;
-}
-
 static bool is_target_alive(struct target *_target,
 			    struct thread_map *threads)
 {
@@ -477,7 +451,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			if ((errno == EINVAL || errno == EBADF) &&
 			    counter->leader != counter &&
 			    counter->weak_group) {
-				counter = perf_evsel__reset_weak_group(counter);
+				counter = perf_evlist__reset_weak_group(evsel_list, counter);
 				goto try_again;
 			}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e88e6f9b1463..668d2a9ef0f4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1810,3 +1810,30 @@ void perf_evlist__force_leader(struct perf_evlist *evlist)
 		leader->forced_leader = true;
 	}
 }
+
+struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
+						 struct perf_evsel *evsel)
+{
+	struct perf_evsel *c2, *leader;
+	bool is_open = true;
+
+	leader = evsel->leader;
+	pr_debug("Weak group for %s/%d failed\n",
+			leader->name, leader->nr_members);
+
+	/*
+	 * for_each_group_member doesn't work here because it doesn't
+	 * include the first entry.
+	 */
+	evlist__for_each_entry(evsel_list, c2) {
+		if (c2 == evsel)
+			is_open = false;
+		if (c2->leader == leader) {
+			if (is_open)
+				perf_evsel__close(c2);
+			c2->leader = c2;
+			c2->nr_members = 0;
+		}
+	}
+	return leader;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..9919eed6d15b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -312,4 +312,7 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
 
 void perf_evlist__force_leader(struct perf_evlist *evlist);
 
+struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evlist,
+						 struct perf_evsel *evsel);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.14.4
