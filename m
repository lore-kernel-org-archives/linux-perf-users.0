Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985514EC60
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133123; cv=none; b=BKWIN5JlsmO4DYF+JpIDoD9NUa5zHLea54QR+x4oGphIvBhK1KPJnKRJ9l9UCsG4Oixp8KBpc9UnYo5Ea8Lu2vp9SRkuZUnrftZfIIYM9F84q1O9rAuGSHNKQEd65kVjcfrifChO3swt70ZMUcPgmm8ABf2zxZ5V+DRrgZ//wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133123; c=relaxed/simple;
	bh=lIF4ebo07Qn3lWBc2oG9EBvdP9eqb50Xz7CoIVuhSUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BrHNVqPa2q+1RKaPrkCx8fNjS95ye4tT0MpxB51zSvaaZoOjJbDhD9ifU1ElCA2EDx0+k+oc2H5dozjmZ6h3NyHvfTzveXbDXTnO1pS3soDymILtZcM15m72yzxKGhs2eOgtLMba4Er5+cZ3NVX5Gb1cZA1ayQ/TJ3Ftr3+vHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJwPxb0/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJwPxb0/"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e32ff6f578eso5103895276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133120; x=1731737920; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vceMdfPQzvji0lr/wplVMHDa75Ua/B62DqNFCz+YnAQ=;
        b=uJwPxb0/TDrD9t9pVdwdXaRib4PJnF/CsfLkYtPrplQcHxtmK6KAes4GJfp1NOaM4W
         db3Ajqm2Jf5xGnKbqu/1+fbgXFiVEVl4Fv7ImUgp5jX2xQ79oH9Y02BxcYG9QLdAMYAA
         TxrppipmFBSjMRZEiojRSZIeVrwMSwLhqVxag2fekbNXqAYo4dSD3cwqZ4Ec3+Srg7/8
         /t220SPzOcTGqqYab3IQwnz7FYbHNUeHbP9nu08Vx8X9iHGMGhwohFKtIUmCwEZ7/sCP
         319qvcEV8XcvY6OOtC/J3c8nDeFzA8jt+r5U92j2/AdOIJuuO3GHjDtu/j4uLGmacXf9
         crgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133120; x=1731737920;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vceMdfPQzvji0lr/wplVMHDa75Ua/B62DqNFCz+YnAQ=;
        b=iYyTGOiY5HuNVvKqUfNctzOgCDOBSykwUKgt6OcoozaqgwSIRRf//BinVK63jSPM11
         K/gSBmCd9AMddoHSHF/bJ9KCuCB+OLvbY8cF8PGrZjjj5vJTeYkjK1bSQc6ZUcksTAQo
         E265tiqa2PGHNSrWi356z7ruxaGUzo/pEQA/+/QztxvHhpwoYbYNqltY8OABgZlTxCE6
         5GfqL546a5KEiISD/BJQadWbrVNY9I2ev6mhnqqSh2ufaaMFxFnX9ulfaN7kjOWuyWNA
         mWk9VJIcN9iAYn5jykPxujPFB++iFuaPntvv7pGe6/4p5NlfsOeoauD+0mG0Y/j6pnhp
         5j4g==
X-Forwarded-Encrypted: i=1; AJvYcCX2vESv1IuzBN8QRNlg6GTXl8Hc+gz2cjWJOr4YLowtbq7mLU4MCKWdXyfTc1Lo608W3sPl8IGAy3LMrovWT/6y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0TjHzu7HF2q/0lHVgP/2lV1jcn9cTiB2ujX6z/eLm76kwZFG
	uCuGOWL1KiPawVjan1yGXLeJpXk4fBViiThA+Fu0pWG/zbCw1oE+P4AZ0zlYmO5gJA2MIw5HRsA
	Y4CEypw==
X-Google-Smtp-Source: AGHT+IFJj6ezwbroN2Z6Ou2WY5hJS2sWu4kbUw+Vh0YtYjC8+aP4yPS52d8ZHSESFDq6c+smKt4xwsnGJPhL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:c2c7:0:b0:e29:9c5:5fcb with SMTP id
 3f1490d57ef6-e337e1b0c47mr26916276.4.1731133119967; Fri, 08 Nov 2024 22:18:39
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:55 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 08/22] perf stat: Move stat_config into config.c
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
index e9ec74056f71..62e851fdf5ca 100644
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
index eb15f3b6c4f5..0fa8e27769be 100644
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
2.47.0.277.g8800431eea-goog

