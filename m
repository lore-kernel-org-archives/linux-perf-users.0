From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/44] perf tools: Support weak groups in 'perf stat'
Date: Fri, 22 Sep 2017 11:41:38 -0300
Message-ID: <20170922144220.9411-3-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Setting up groups can be complicated due to the complicated scheduling
restrictions of different PMUs.

User tools usually don't understand all these restrictions.

Still in many cases it is useful to set up groups and they work most of
the time. However if the group is set up wrong some members will not
report any value because they never get scheduled.

Add a concept of a 'weak group': try to set up a group, but if it's not
schedulable fallback to not using a group. That gives us the best of
both worlds: groups if they work, but still a usable fallback if they
don't.

In theory it would be possible to have more complex fallback strategies
(e.g. try to split the group in half), but the simple fallback of not
using a group seems to work for now.

So far the weak group is only implemented for perf stat, not for record.

Here's an unschedulable group (on IvyBridge with SMT on)

  % perf stat -e '{branches,branch-misses,l1d.replacement,l2_lines_in.all,l2_rqsts.all_code_rd}' -a sleep 1

        73,806,067      branches
         4,848,144      branch-misses             #    6.57% of all branches
        14,754,458      l1d.replacement
        24,905,558      l2_lines_in.all
   <not supported>      l2_rqsts.all_code_rd         <------- will never report anything

With the weak group:

  % perf stat -e '{branches,branch-misses,l1d.replacement,l2_lines_in.all,l2_rqsts.all_code_rd}:W' -a sleep 1

       125,366,055      branches                                                      (80.02%)
         9,208,402      branch-misses             #    7.35% of all branches          (80.01%)
        24,560,249      l1d.replacement                                               (80.00%)
        43,174,971      l2_lines_in.all                                               (80.05%)
        31,891,457      l2_rqsts.all_code_rd                                          (79.92%)

The extra event scheduled with some extra multiplexing

v2: Move fallback code to separate function.
Add comment on for_each_group_member
Adjust to new perf_evsel__close interface
v3: Fix debug print out.

Committer testing:

Before:

  # perf stat -e '{branches,branch-misses,l1d.replacement,l2_lines_in.all,l2_rqsts.all_code_rd}' -a sleep 1

   Performance counter stats for 'system wide':

     <not counted>      branches
     <not counted>      branch-misses
     <not counted>      l1d.replacement
     <not counted>      l2_lines_in.all
   <not supported>      l2_rqsts.all_code_rd

       1.002147212 seconds time elapsed

  # perf stat -e '{branches,l1d.replacement,l2_lines_in.all,l2_rqsts.all_code_rd}' -a sleep 1

   Performance counter stats for 'system wide':

        83,207,892      branches
        11,065,444      l1d.replacement
        28,484,024      l2_lines_in.all
        12,186,179      l2_rqsts.all_code_rd

       1.001739493 seconds time elapsed

After:

  # perf stat -e '{branches,branch-misses,l1d.replacement,l2_lines_in.all,l2_rqsts.all_code_rd}':W -a sleep 1

   Performance counter stats for 'system wide':

       543,323,909      branches                                                      (80.01%)
        27,100,512      branch-misses             #    4.99% of all branches          (80.02%)
        50,402,905      l1d.replacement                                               (80.03%)
        67,385,892      l2_lines_in.all                                               (80.01%)
        21,352,885      l2_rqsts.all_code_rd                                          (79.94%)

       1.001086658 seconds time elapsed

  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20170831194036.30146-2-andi@firstfloor.org
[ Add a "'perf stat' only, for now" comment in the man page, suggested by Jiri ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  2 ++
 tools/perf/builtin-stat.c              | 35 ++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h                |  1 +
 tools/perf/util/parse-events.c         |  8 +++++++-
 tools/perf/util/parse-events.l         |  2 +-
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index f709de54707b..75fc17f47298 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -47,6 +47,8 @@ counted. The following modifiers exist:
  P - use maximum detected precise level
  S - read sample value (PERF_SAMPLE_READ)
  D - pin the event to the PMU
+ W - group is weak and will fallback to non-group if not schedulable,
+     only supported in 'perf stat' for now.
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 69523ed55894..7cc61eb0d83b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -582,6 +582,32 @@ static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
 }
 
+static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
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
+
 static int __run_perf_stat(int argc, const char **argv)
 {
 	int interval = stat_config.interval;
@@ -618,6 +644,15 @@ static int __run_perf_stat(int argc, const char **argv)
 	evlist__for_each_entry(evsel_list, counter) {
 try_again:
 		if (create_perf_stat_counter(counter) < 0) {
+
+			/* Weak group failed. Reset the group. */
+			if (errno == EINVAL &&
+			    counter->leader != counter &&
+			    counter->weak_group) {
+				counter = perf_evsel__reset_weak_group(counter);
+				goto try_again;
+			}
+
 			/*
 			 * PPC returns ENXIO for HW counters until 2.6.37
 			 * (behavior changed with commit b0a873e).
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dd2c4b5112a5..db658785d828 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -137,6 +137,7 @@ struct perf_evsel {
 	const char *		metric_name;
 	struct perf_evsel	**metric_events;
 	bool			collect_stat;
+	bool			weak_group;
 };
 
 union u64_swap {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f6257fb4f08c..57d7acf890e0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1366,6 +1366,7 @@ struct event_modifier {
 	int exclude_GH;
 	int sample_read;
 	int pinned;
+	int weak;
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
@@ -1384,6 +1385,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 
 	int exclude = eu | ek | eh;
 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
+	int weak = 0;
 
 	memset(mod, 0, sizeof(*mod));
 
@@ -1421,6 +1423,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 			sample_read = 1;
 		} else if (*str == 'D') {
 			pinned = 1;
+		} else if (*str == 'W') {
+			weak = 1;
 		} else
 			break;
 
@@ -1451,6 +1455,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	mod->exclude_GH = exclude_GH;
 	mod->sample_read = sample_read;
 	mod->pinned = pinned;
+	mod->weak = weak;
 
 	return 0;
 }
@@ -1464,7 +1469,7 @@ static int check_modifier(char *str)
 	char *p = str;
 
 	/* The sizeof includes 0 byte as well. */
-	if (strlen(str) > (sizeof("ukhGHpppPSDI") - 1))
+	if (strlen(str) > (sizeof("ukhGHpppPSDIW") - 1))
 		return -1;
 
 	while (*p) {
@@ -1504,6 +1509,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->exclude_GH          = mod.exclude_GH;
 		evsel->sample_read         = mod.sample_read;
 		evsel->precise_max         = mod.precise_max;
+		evsel->weak_group	   = mod.weak;
 
 		if (perf_evsel__is_group_leader(evsel))
 			evsel->attr.pinned = mod.pinned;
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index c42edeac451f..fdb5bb52f01f 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -161,7 +161,7 @@ name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
-modifier_event	[ukhpPGHSDI]+
+modifier_event	[ukhpPGHSDIW]+
 modifier_bp	[rwx]{1,3}
 
 %%
-- 
2.13.5
