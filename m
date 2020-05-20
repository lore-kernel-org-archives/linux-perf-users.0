From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH v2] perf config: Add stat.big-num support
Date: Wed, 20 May 2020 11:23:35 -0500
Message-ID: <1589991815-17951-1-git-send-email-pc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

Add support for new "stat.big-num" boolean option.

This allows a user to set a default for "--no-big-num" for "perf stat"
commands.

--
$ perf config stat.big-num
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           778,849      cycles
[...]
$ perf config stat.big-num=false
$ perf config stat.big-num
stat.big-num=false
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

            769622      cycles
[...]
--

There is an interaction with "--field-separator" that must be
accommodated, such that specifying "--big-num --field-separator={x}"
still reports an invalid combination of options.

Documentation for perf-config and perf-stat updated.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
v2:
- Documentation updates for perf-config and perf-stat.
- Changed from using 0/1 to false/true in the examples and documentation.

Testing results with a matrix of:
- nothing in .perfconfig, stat.big-num=false, stat.big-num=true
- --field-separator not set, --field-separator=:
- no "--big-num", --big-num, --no-big-num

$ perf config stat.big-num
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           778,849      cycles                                                      

       0.000570037 seconds time elapsed

       0.000619000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           763,003      cycles                                                      

       0.000546281 seconds time elapsed

       0.000597000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            810753      cycles                                                      

       0.000582670 seconds time elapsed

       0.000638000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
759523::cycles:333196:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
782610::cycles:343606:100.00::
$ perf config stat.big-num=false
$ perf config stat.big-num
stat.big-num=false
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

            769622      cycles                                                      

       0.000545743 seconds time elapsed

       0.000600000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           788,694      cycles                                                      

       0.000565276 seconds time elapsed

       0.000622000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            808283      cycles                                                      

       0.000575508 seconds time elapsed

       0.000632000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
809296::cycles:355486:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
795679::cycles:349824:100.00::
$ perf config stat.big-num=true
$ perf config stat.big-num
stat.big-num=true
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           823,114      cycles                                                      

       0.000577809 seconds time elapsed

       0.000643000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           778,824      cycles                                                      

       0.000551584 seconds time elapsed

       0.000603000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            789190      cycles                                                      

       0.000574797 seconds time elapsed

       0.000637000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
780405::cycles:343394:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
802656::cycles:353182:100.00::
$ 
---
 tools/perf/Documentation/perf-config.txt |  5 +++++
 tools/perf/Documentation/perf-stat.txt   |  4 +++-
 tools/perf/builtin-stat.c                |  6 ++++++
 tools/perf/util/config.c                 | 13 +++++++++++++
 tools/perf/util/stat.h                   |  2 ++
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index f16d8a71d3f5..790003158648 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -667,6 +667,11 @@ convert.*::
 		Limit the size of ordered_events queue, so we could control
 		allocation size of perf data files without proper finished
 		round events.
+stat.*::
+
+	stat.big-num::
+		(boolean) Change the default for "--big-num". To make
+		"--no-big-num" the default, set "stat.big-num=false".
 
 intel-pt.*::
 
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3fb5028aef08..77081283856d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -93,7 +93,9 @@ report::
 
 -B::
 --big-num::
-        print large numbers with thousands' separators according to locale
+        print large numbers with thousands' separators according to locale.
+	Enabled by default. Use "--no-big-num" to disable.
+	Default setting can be changed with "perf config stat.big-num=false".
 
 -C::
 --cpu=::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0c1ad23c768..c39305907940 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -821,10 +821,16 @@ static void sig_atexit(void)
 	kill(getpid(), signr);
 }
 
+void perf_stat__set_big_num(int set)
+{
+	stat_config.big_num = (set != 0);
+}
+
 static int stat__set_big_num(const struct option *opt __maybe_unused,
 			     const char *s __maybe_unused, int unset)
 {
 	big_num_opt = unset ? 0 : 1;
+	perf_stat__set_big_num(!unset);
 	return 0;
 }
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index ef38eba56ed0..8e65f1fa421f 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -17,6 +17,7 @@
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
+#include "util/stat.h"  /* perf_stat__set_big_num */
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
@@ -452,6 +453,15 @@ static int perf_ui_config(const char *var, const char *value)
 	return 0;
 }
 
+static int perf_stat_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "stat.big-num"))
+		perf_stat__set_big_num(perf_config_bool(var, value));
+
+	/* Add other config variables here. */
+	return 0;
+}
+
 int perf_default_config(const char *var, const char *value,
 			void *dummy __maybe_unused)
 {
@@ -473,6 +483,9 @@ int perf_default_config(const char *var, const char *value,
 	if (strstarts(var, "buildid."))
 		return perf_buildid_config(var, value);
 
+	if (strstarts(var, "stat."))
+		return perf_stat_config(var, value);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..4bd6dc6cb6aa 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -132,6 +132,8 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 };
 
+void perf_stat__set_big_num(int set);
+
 void update_stats(struct stats *stats, u64 val);
 double avg_stats(struct stats *stats);
 double stddev_stats(struct stats *stats);
-- 
2.18.2
