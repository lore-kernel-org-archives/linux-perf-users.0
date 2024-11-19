Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2371459F7
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979058; cv=none; b=LUSQFy47IIIkauE7aQfgmEFAUS17UAIDZlzE+LaJXkQhmPcX2ROxJLOOZQLqeW3YSk9+I8Kg8X5hF8u2lsxWdh0CQpXSR3UVHUDctv//zzw8b7b2jolHjhkzr5KErTABagY7mMRBQvG0LRhTccEt80bZs80eXQ9Xs3Tic8XdIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979058; c=relaxed/simple;
	bh=DGojOJgFDaGqdr6kKd74ATAbtPhpAzkCO8jJGHoxK6Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=IdRAAVa/Qsej0RR1aQcy87v8l/YGOM68p84NB8qmuAniwU8HRd4zmTWGtCalzSMblO/6OhELHo41uZPTrvnKk0jhO9PGwQEW71/IJUhElDgTAFeqZ7uCQVEPecOe1I9MJ7h7NiivkhRX4ri7ZN/JXQdHVWW7UXslA6afT0bkRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrLL/tzv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrLL/tzv"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee6122ea3fso9654227b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979056; x=1732583856; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xcdwNCXAapieDjq0EaB/I9Ayk4LLuR25v1wJQOOIu4=;
        b=YrLL/tzvGQ0/jZqM9j2ek+TLyqpXFhCKtK4s/x44h+TOs1ybLKGy96KFDMnJHLqOtw
         G+kRtCJaHEVvH6AbebwezaYfNXdj3iQVDydvpiTgfbDY/0TJ95BtdyY5ET6JuXGyMV6V
         qiN3K2mdXCh/oXzZ3oHOGt0Jv+Bbz5ckL7lAGUsH8zQVCZGQdymPzpTG1UwsFjkO+rC6
         gUmpGKq5S3FJv0tttVLWqvbJCqwWhrrdHyDOVZ28W2R6J2jtvJVQwrwOSnVucW0fTYzf
         IqZs/nWVmOpdRPe4qo9dCr1XcjIaZcg3ohS7PvrEatKoqfk+shYjsBW04nKUJFTTqyHy
         bkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979056; x=1732583856;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xcdwNCXAapieDjq0EaB/I9Ayk4LLuR25v1wJQOOIu4=;
        b=dKGRPzjpxTj4pJACYFBlpsXrqG63DaRpme9wkDBVH6Nupx6rslSJHL3ztiQAH0xvBT
         PW+GWWOv3LPMkaDLr3527xC0sRJtWGvzg3i35RsdUsE8fuBMUyyY7slA219uVFf4wxXS
         38Wtw4lZMQghiM2F5HMmZOXW3hjR1zBl4G9W5+5BH6zQNlMzJg6qrbISiYVQXa1glwUE
         //na/dIo6U3dACJKeIHFSL3NlQrx3AJ65D84muY+I57NQbOSQ1A6AoCqXVR93cVRCFLH
         TU6ATANSx9FuPATWSRn9rsE/rlZWMtLcR+ErEdIGeI1K+c2ia32Z+gHMMnMqoL4TbEkq
         UdPA==
X-Forwarded-Encrypted: i=1; AJvYcCV+gmabOtD9SVyW7T8++VaVTc65ZwhhYrn4awSXcqygvGBSZ7OqB0v172rrMtGxrapJs6VmQjN+ly7dIjcPQke2@vger.kernel.org
X-Gm-Message-State: AOJu0YzNP7Ib5RW2f1DIXrK8fc0uo3eyvJ2l06dIVm852nKYNjpkFyne
	dHQ9EO+WmGrKMzsbl/TjQYPU4SKXZSXLueUYP+aEm80n6rYGta+e2u+PmR5YN8OS5bZvT51KLI9
	9+UqmLA==
X-Google-Smtp-Source: AGHT+IEe+hj2e22w4ZCW8LOneiD3eQ1sChTs4Nn/28644fdsvqWLXr0L7ggq538XuoPZiS3IQfss1cZAksHU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:dc2:b0:6ee:93e6:caac with SMTP id
 00721157ae682-6ee93e6ceebmr3218167b3.7.1731979056100; Mon, 18 Nov 2024
 17:17:36 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:30 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 08/22] perf stat: Move stat_config into config.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

stat_config is accessed by config.c via helper functions, but declared
in builtin-stat. Move to util/config.c so that stub functions aren't
needed in python.c which doesn't link against the builtin files.

To avoid name conflicts change builtin-script to use the same
stat_config as builtin-stat. Rename local variables in tests to avoid
shadow declaration warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c |  1 -
 tools/perf/builtin-stat.c   | 27 ---------------------------
 tools/perf/tests/stat.c     | 16 +++++++++-------
 tools/perf/util/config.c    | 27 +++++++++++++++++++++++++++
 tools/perf/util/python.c    | 10 ----------
 tools/perf/util/stat.h      |  3 ++-
 6 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 33f50a17338a..0ba1866dbeef 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -85,7 +85,6 @@ static bool			system_wide;
 static bool			print_flags;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
-static struct perf_stat_config	stat_config;
 static int			max_blocks;
 static bool			native_arch;
 static struct dlfilter		*dlfilter;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fdf5172646a5..77e327d4a9a7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -112,8 +112,6 @@ static struct target target = {
 	.uid	= UINT_MAX,
 };
 
-#define METRIC_ONLY_LEN 20
-
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
@@ -151,21 +149,6 @@ static struct perf_stat		perf_stat;
 
 static volatile sig_atomic_t done = 0;
 
-static struct perf_stat_config stat_config = {
-	.aggr_mode		= AGGR_GLOBAL,
-	.aggr_level		= MAX_CACHE_LVL + 1,
-	.scale			= true,
-	.unit_width		= 4, /* strlen("unit") */
-	.run_count		= 1,
-	.metric_only_len	= METRIC_ONLY_LEN,
-	.walltime_nsecs_stats	= &walltime_nsecs_stats,
-	.ru_stats		= &ru_stats,
-	.big_num		= true,
-	.ctl_fd			= -1,
-	.ctl_fd_ack		= -1,
-	.iostat_run		= false,
-};
-
 /* Options set from the command line. */
 struct opt_aggr_mode {
 	bool node, socket, die, cluster, cache, core, thread, no_aggr;
@@ -1071,16 +1054,6 @@ static void sig_atexit(void)
 	kill(getpid(), signr);
 }
 
-void perf_stat__set_big_num(int set)
-{
-	stat_config.big_num = (set != 0);
-}
-
-void perf_stat__set_no_csv_summary(int set)
-{
-	stat_config.no_csv_summary = (set != 0);
-}
-
 static int stat__set_big_num(const struct option *opt __maybe_unused,
 			     const char *s __maybe_unused, int unset)
 {
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 6468cc0d0204..d60983657bad 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -27,7 +27,7 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
 				     struct machine *machine __maybe_unused)
 {
 	struct perf_record_stat_config *config = &event->stat_config;
-	struct perf_stat_config stat_config = {};
+	struct perf_stat_config test_stat_config = {};
 
 #define HAS(term, val) \
 	has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
@@ -39,25 +39,27 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
 
 #undef HAS
 
-	perf_event__read_stat_config(&stat_config, config);
+	perf_event__read_stat_config(&test_stat_config, config);
 
-	TEST_ASSERT_VAL("wrong aggr_mode", stat_config.aggr_mode == AGGR_CORE);
-	TEST_ASSERT_VAL("wrong scale",     stat_config.scale == 1);
-	TEST_ASSERT_VAL("wrong interval",  stat_config.interval == 1);
+	TEST_ASSERT_VAL("wrong aggr_mode", test_stat_config.aggr_mode == AGGR_CORE);
+	TEST_ASSERT_VAL("wrong scale",     test_stat_config.scale == 1);
+	TEST_ASSERT_VAL("wrong interval",  test_stat_config.interval == 1);
 	return 0;
 }
 
 static int test__synthesize_stat_config(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
-	struct perf_stat_config stat_config = {
+	struct perf_stat_config test_stat_config = {
 		.aggr_mode	= AGGR_CORE,
 		.scale		= 1,
 		.interval	= 1,
 	};
 
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
-		!perf_event__synthesize_stat_config(NULL, &stat_config, process_stat_config_event, NULL));
+		!perf_event__synthesize_stat_config(NULL, &test_stat_config,
+						    process_stat_config_event,
+						    NULL));
 
 	return 0;
 }
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 68f9407ca74b..2d07c9257a1a 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -13,6 +13,7 @@
 #include <sys/param.h>
 #include "cache.h"
 #include "callchain.h"
+#include "header.h"
 #include <subcmd/exec-cmd.h>
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
@@ -34,6 +35,22 @@
 
 #define DEBUG_CACHE_DIR ".debug"
 
+#define METRIC_ONLY_LEN 20
+
+struct perf_stat_config stat_config = {
+	.aggr_mode		= AGGR_GLOBAL,
+	.aggr_level		= MAX_CACHE_LVL + 1,
+	.scale			= true,
+	.unit_width		= 4, /* strlen("unit") */
+	.run_count		= 1,
+	.metric_only_len	= METRIC_ONLY_LEN,
+	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.ru_stats		= &ru_stats,
+	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1,
+	.iostat_run		= false,
+};
 
 char buildid_dir[MAXPATHLEN]; /* root dir for buildid, binary cache */
 
@@ -455,6 +472,16 @@ static int perf_ui_config(const char *var, const char *value)
 	return 0;
 }
 
+void perf_stat__set_big_num(int set)
+{
+	stat_config.big_num = (set != 0);
+}
+
+static void perf_stat__set_no_csv_summary(int set)
+{
+	stat_config.no_csv_summary = (set != 0);
+}
+
 static int perf_stat_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "stat.big-num"))
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4593c937febb..7fc3ec5684c3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,8 +17,6 @@
 #include "trace-event.h"
 #include "mmap.h"
 #include "util/env.h"
-#include "util/kvm-stat.h"
-#include "util/stat.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1307,14 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-void perf_stat__set_no_csv_summary(int set __maybe_unused)
-{
-}
-
-void perf_stat__set_big_num(int set __maybe_unused)
-{
-}
-
 int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
 {
 	return -1;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 6f8cff3cd39a..2fda9acd7374 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -117,8 +117,9 @@ struct perf_stat_config {
 	unsigned int		topdown_level;
 };
 
+extern struct perf_stat_config stat_config;
+
 void perf_stat__set_big_num(int set);
-void perf_stat__set_no_csv_summary(int set);
 
 void update_stats(struct stats *stats, u64 val);
 double avg_stats(struct stats *stats);
-- 
2.47.0.338.g60cca15819-goog

