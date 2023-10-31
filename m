Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3321D546
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2023 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC5155595;
	Tue, 31 Oct 2023 05:05:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F8A3DA7;
	Tue, 31 Oct 2023 05:06:26 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.. (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.2.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA45E3F738;
	Tue, 31 Oct 2023 05:05:42 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	stable@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/2] perf lock report: Restore aggregation by caller by default
Date: Tue, 31 Oct 2023 12:05:24 +0000
Message-ID: <20231031120526.11502-2-nick.forrington@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031120526.11502-1-nick.forrington@arm.com>
References: <20231031120526.11502-1-nick.forrington@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change restores the previous default behaviour for "perf lock
report", making the current aggregate-by-address behaviour available via
the new "--lock-addr" command line parameter.

This makes the behaviour consistent with "perf lock contention" (which
also aggregates by caller by default, or by address when "--lock-addr"
is specified).

Commit 688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")
introduced aggregation modes for "perf lock contention" and (potentially
inadvertently) changed the behaviour of "perf lock report" from
aggregate-by-caller to aggregate-by-address (making the prior behaviour
inaccessible).

Example aggregate-by-address output:

$ perf lock report -F acquired
                Name   acquired

         event_mutex         34
                             21
                              1

Example aggregate-by-caller output:

$ perf lock report -F acquired
                Name   acquired

 perf_trace_init+...         34
 lock_mm_and_find...         20
 inherit_event.co...          1
    do_madvise+0x1f8          1

Cc: stable@kernel.org
Fixes: 688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")
Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++++
 tools/perf/builtin-lock.c              | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 503abcba1438..349333acbbfc 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -80,6 +80,10 @@ REPORT OPTIONS
 --combine-locks::
 	Merge lock instances in the same class (based on name).
 
+-l::
+--lock-addr::
+	Show lock contention stat by address
+
 -t::
 --threads::
     The -t option is to show per-thread lock stat like below:
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fa7419978353..3aa8ba5ad928 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -78,7 +78,7 @@ struct callstack_filter {
 
 static struct lock_filter filters;
 
-static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
+static enum lock_aggr_mode aggr_mode = LOCK_AGGR_CALLER;
 
 static bool needs_callstack(void)
 {
@@ -1983,8 +1983,8 @@ static int __cmd_report(bool display_info)
 	if (select_key(false))
 		goto out_delete;
 
-	if (show_thread_stats)
-		aggr_mode = LOCK_AGGR_TASK;
+	aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
+		show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
 
 	err = perf_session__process_events(session);
 	if (err)
@@ -2008,6 +2008,19 @@ static void sighandler(int sig __maybe_unused)
 {
 }
 
+static int check_lock_report_options(const struct option *options,
+				     const char * const *usage)
+{
+	if (show_thread_stats && show_lock_addrs) {
+		pr_err("Cannot use thread and addr mode together\n");
+		parse_options_usage(usage, options, "threads", 0);
+		parse_options_usage(NULL, options, "lock-addr", 0);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int check_lock_contention_options(const struct option *options,
 					 const char * const *usage)
 
@@ -2589,6 +2602,7 @@ int cmd_lock(int argc, const char **argv)
 	/* TODO: type */
 	OPT_BOOLEAN('c', "combine-locks", &combine_locks,
 		    "combine locks in the same class"),
+	OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
 	OPT_BOOLEAN('t', "threads", &show_thread_stats,
 		    "show per-thread lock stats"),
 	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
@@ -2680,6 +2694,10 @@ int cmd_lock(int argc, const char **argv)
 			if (argc)
 				usage_with_options(report_usage, report_options);
 		}
+
+		if (check_lock_report_options(report_options, report_usage) < 0)
+			return -1;
+
 		rc = __cmd_report(false);
 	} else if (!strcmp(argv[0], "script")) {
 		/* Aliased to 'perf script' */
-- 
2.42.0

