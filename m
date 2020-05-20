From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH] perf config: Add stat.big-num support
Date: Wed, 20 May 2020 10:32:55 -0500
Message-ID: <1589988775-9995-1-git-send-email-pc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

Add support for new "stat.big-num" boolean option.

This allows a user to set a default for "--no-big-num" for "perf stat"
commands.

$ perf config stat.big-num
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           803,684      cycles                                                      
[...]
$ perf config stat.big-num=0
$ perf config stat.big-num
stat.big-num=0
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

            790448      cycles                                                      
[...]

There is an interaction with "--field-separator" that must be
accommodated, such that specifying "--big-num --field-separator={x}"
still reports an invalid combination of options.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
Testing results with a matrix of:
- nothing in .perfconfig, stat.big-num=0, stat.big-num=1
- --field-separator not set, --field-separator=:
- no "--big-num", --big-num, --no-big-num

$ perf config stat.big-num
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           803,684      cycles                                                      

       0.000592761 seconds time elapsed

       0.000672000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           809,599      cycles                                                      

       0.000576090 seconds time elapsed

       0.000627000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            793870      cycles                                                      

       0.000574928 seconds time elapsed

       0.000625000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
790255::cycles:346960:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
764548::cycles:335938:100.00::
$ perf config stat.big-num=0
$ perf config stat.big-num
stat.big-num=0
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

            790448      cycles                                                      

       0.000567659 seconds time elapsed

       0.000619000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           751,377      cycles                                                      

       0.000534888 seconds time elapsed

       0.000587000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            803738      cycles                                                      

       0.000576151 seconds time elapsed

       0.000657000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
774897::cycles:339986:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
814619::cycles:358260:100.00::
$ perf config stat.big-num=1
$ perf config stat.big-num
stat.big-num=1
$ perf stat --event cycles /bin/true

 Performance counter stats for '/bin/true':

           787,680      cycles                                                      

       0.000555401 seconds time elapsed

       0.000623000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --big-num /bin/true

 Performance counter stats for '/bin/true':

           783,287      cycles                                                      

       0.000562255 seconds time elapsed

       0.000636000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --no-big-num /bin/true

 Performance counter stats for '/bin/true':

            748802      cycles                                                      

       0.000525658 seconds time elapsed

       0.000586000 seconds user
       0.000000000 seconds sys


$ perf stat --event cycles --field-separator=: /bin/true
785868::cycles:344508:100.00::
$ perf stat --event cycles --big-num --field-separator=: /bin/true
-B option not supported with -x

 Usage: perf stat [<options>] [<command>]

    -B, --big-num         print large numbers with thousands' separators
    -x, --field-separator <separator>
                          print counts with custom separator
$ perf stat --event cycles --no-big-num --field-separator=: /bin/true
794273::cycles:349600:100.00::
$ 
--
 tools/perf/builtin-stat.c |  6 ++++++
 tools/perf/util/config.c  | 13 +++++++++++++
 tools/perf/util/stat.h    |  2 ++
 3 files changed, 21 insertions(+)

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
