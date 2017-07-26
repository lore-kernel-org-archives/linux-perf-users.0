From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/40] perf top: Support lookup of symbols in other mount namespaces.
Date: Wed, 26 Jul 2017 11:17:19 -0300
Message-ID: <20170726141730.30750-30-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

The perf top command needs to unshare its fs from the helper threads in
order to successfully setns(2) during its symbol lookup.  It also needs
to impelement a force flag to ignore ownership of perf-<pid>.map files.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1499305693-1599-6-git-send-email-kjlx@templeofstupid.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt |  4 ++++
 tools/perf/builtin-top.c              | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index e71d63843f45..d864ea6fd367 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -237,6 +237,10 @@ Default is to monitor all CPUS.
 --hierarchy::
 	Enable hierarchy output.
 
+--force::
+	Don't do ownership validation.
+
+
 INTERACTIVE PROMPTING KEYS
 --------------------------
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e5a8f249077f..ee954bde7e3e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -587,6 +587,13 @@ static void *display_thread_tui(void *arg)
 		.refresh	= top->delay_secs,
 	};
 
+	/* In order to read symbols from other namespaces perf to  needs to call
+	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
+	 * unshare(2) the fs so that we may continue to setns into namespaces
+	 * that we're observing.
+	 */
+	unshare(CLONE_FS);
+
 	perf_top__sort_new_samples(top);
 
 	/*
@@ -628,6 +635,13 @@ static void *display_thread(void *arg)
 	struct perf_top *top = arg;
 	int delay_msecs, c;
 
+	/* In order to read symbols from other namespaces perf to  needs to call
+	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
+	 * unshare(2) the fs so that we may continue to setns into namespaces
+	 * that we're observing.
+	 */
+	unshare(CLONE_FS);
+
 	display_setup_sig();
 	pthread__unblock_sigwinch();
 repeat:
@@ -1206,6 +1220,7 @@ int cmd_top(int argc, const char **argv)
 		    "Show raw trace event output (do not use print fmt or plugins)"),
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
+	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_END()
 	};
 	const char * const top_usage[] = {
-- 
2.9.4
