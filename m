Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AAD1C2DA9
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618270; cv=none; b=sVsSSu0KW6nMxUeMbBYHYGwUV1UgLeSgUVi7bvIASfpvaKurRljzd/tEcv/gDNM/SasYg7SAJKD9b+UtZ8q7aqFJz+QDTcAE4ihyRia2HMED5mNBufuJyudk1FKJRITmDsm9R4SXFCeUUz/SW6avi8oBQaQuMHUwycjbZJ94uWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618270; c=relaxed/simple;
	bh=s31dSzgjSGas7kPllBbZiPWKWXkpL9nMCVZO/I2SOZU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g3H5arV8mhmHXoRtVZ385RlnUaiJrdXc0sn1LTBbs69Yqmon9+HTiXZ/dpijbe5uWYDh7wJL6tihllhzZ1zXhVuzXXPg7T4swW28up3SmmipTpBd7zTbECMr4LqVsJ1w9R/2ikmzR5NbVsTOguTvVRO+qnrRW0+7EJs52MN5V6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEHjqN+V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEHjqN+V"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2939e25402so9453901276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618267; x=1730223067; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgPxjN/5Bqvxkvpikn5AEcPP+fMC5PENxXEI6dgAv3U=;
        b=gEHjqN+VNbb3aun78kHSap34Iya3ftirIVkGrd1k/heB+FS3ymU+D1zCPLiGv6ovzD
         ORe9uwI6V/VtxDjP2VY2w+dcGonyx1UMOMdgT03yP+KVw63M4g4vdeCFyNiTK2DrsQSL
         p4JmadCnRDfgl+v+JmVPYMudt6sqx6p9rT6dwWRD2nW+1uYePHGLJrXqGHuEpvzJdOKS
         hBGqI1t1nMOG0CXkP6Gf13qYru1CfoNoEtPyA5EtE4iisDfvJl6UTXt3mIci5V7p9M26
         Gom17uwWoQIrPIhuQ4oo3g4VyJHET2Af+wt5v+BbuAcNuHxxjw0ZRtJAEvSO3AtlpM+v
         nlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618267; x=1730223067;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgPxjN/5Bqvxkvpikn5AEcPP+fMC5PENxXEI6dgAv3U=;
        b=vzxQ3BQIFIn0eCCnKcGcD86QS9ibkQpgfccvnCesTEvKMqqB8ag143Z5T+lcWmdHEm
         luVIAkE13uh0AId42U+IktXSKboQFgVl7aFIKfIrI6jVnnRJpUfRp/xGTasQHAZwpCk9
         SkyIjqAYsSLPzeBrFeiK9RmZxTZ0nvbJvtSTyU+L+wDyrWMiz5EVjiBf0rz/MPqUUxmg
         QVhy5NuF2zjbB7CVuPl9BSvT87N02kK4EYU9gK26WD0OnEHmEeobfmpu2Of75+GERKq6
         IDgA4ftw1G0yYSct26quCQoF7E0YPDGmhgQ2sevjHHZEK0usSmjvC+dKsGFtQwdlO8RD
         FnNg==
X-Forwarded-Encrypted: i=1; AJvYcCXfhNJZLCYq+mLjJ9bOvrS7D4FAZ7h5M8bFnpZZkjfYVEijkrX9e/pOtYvvsiDUnnmQLR/ddC9HQANo5ILaCj90@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgg9gZ4WZyec5w7d9BUh94Buju4npw7zqBIoSal026wt2Q+VG
	M0Q0efhp5mgjIoA+vCT7A71PtSRDtiVXzpKe/4CLjJt8rYQjAPRnh9yAlLRc3CtxL5vcWsVuKZ6
	bNGBPxA==
X-Google-Smtp-Source: AGHT+IHmhEj8jDmTBd5ueE3FMCFsA6yJQFA0/6n58ZO1nAwQpMjQ3hJs1pPs3ymDYl0vJHj4IRNseRMVBDOh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:800f:0:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e2bb11cccaemr28124276.1.1729618267187; Tue, 22 Oct 2024 10:31:07
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:05 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 07/16] perf stat: Move stat_config into config.c
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

stat_config is accessed by config.c via helper functions, but declared
in builtin-stat. Move to util/config.c so that stub functions aren't
needed in python.c which doesn't link against the builtin files.

To avoid name conflicts change builtin-script to use the same
stat_config as builtin-stat. Rename local variables in tests to avoid
shadow declaration warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c |  1 -
 tools/perf/builtin-stat.c   | 27 ---------------------------
 tools/perf/tests/stat.c     | 16 +++++++++-------
 tools/perf/util/config.c    | 27 +++++++++++++++++++++++++++
 tools/perf/util/python.c    |  9 ---------
 tools/perf/util/stat.h      |  3 ++-
 6 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 27b2fb08ad67..1ce7b71f1f46 100644
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
index b5e18853982c..7c7424824b0e 100644
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
@@ -1059,16 +1042,6 @@ static void sig_atexit(void)
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
index 5f11ae88943d..0fa8e27769be 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,7 +17,6 @@
 #include "trace-event.h"
 #include "mmap.h"
 #include "util/env.h"
-#include "util/kvm-stat.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1306,14 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
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
index fd7a187551bd..78ddc14507b7 100644
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
2.47.0.163.g1226f6d8fa-goog

