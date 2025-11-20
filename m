Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304D21D590;
	Thu, 20 Nov 2025 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599650; cv=none; b=YsdRrQ6//nL8nHazttnQBVfqY/yuZlgcoJdYnePXDb8ujh2+FmyQk+w7/9pFpQYmdyJjk3kfacOxYeElHxdddoJpn2jTug7tMNbLCz7QMIcEEUNCjmxl/ObEaX6cxaI8eeO/O7VA1bzZAy6xyAS/Zj5UkMmgr/TKUr9vjPEPJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599650; c=relaxed/simple;
	bh=+G3ksrVAmHyhFbx72dQ2pLcMrynbwW5RbSVOwVvuh40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbE7fI8wov/vvO789VrSwDohycZC8LjRMwAsP9DdGjvC8rllUJMjxI7Gxhx70rIkggzO6nLPGU9lcaQ/A8h9aXUEwXriPB5PqFd9vIVrRb7OocOYNq3Ew1R3bz6HcdI3G24iS/eO2yKf8MVgpLZZoXuVpJ5dYVZNrWwa/23/mIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8BlTNog; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8BlTNog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770AEC116D0;
	Thu, 20 Nov 2025 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763599649;
	bh=+G3ksrVAmHyhFbx72dQ2pLcMrynbwW5RbSVOwVvuh40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8BlTNogUXOJsUi2mbz9XLPRXGBKj9YADkdFAeibOwik71yv71XEoQRa3ktya5Zjo
	 uwzetYmuJafjRbSqogBwjPmRiImrMHOqwDOFU5dafFtzmAdNJF1qHOSc7er5CaLEg3
	 R8qYmqGmjQzvZf6msr1TrRSkI5V/JgmHwedGqPuE04akQYce7cAzaNWGDK/NRHZIOw
	 WUNajTDOut6G51L+lvOQQny6S3c/PEha4ydbifvXkWDMCwk6k7Ah7dVbaq1jO48fPx
	 kW8UIyPxu0LK4A2JHVZUcIc0PTG4hDgJOYEHGlXpF39gGb9tHPh8w7QQh9eztC0dD8
	 IB9eyJBOUKPWw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/3] perf list: Share print state with JSON output
Date: Wed, 19 Nov 2025 16:47:25 -0800
Message-ID: <20251120004726.61660-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120004726.61660-1-namhyung@kernel.org>
References: <20251120004726.61660-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JSON print state has only one different field (need_sep).  Let's
add the default print state to the json state and use it.  Then we can
use the 'ps' variable to update the state properly.

This is a preparation for the next commit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-list.c | 127 +++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 28bf1fc7f5eeff8f..6c5913f129f39c94 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -283,8 +283,8 @@ static void default_print_metric(void *ps,
 }
 
 struct json_print_state {
-	/** @fp: File to write output to. */
-	FILE *fp;
+	/** The shared print_state */
+	struct print_state common;
 	/** Should a separator be printed prior to the next item? */
 	bool need_sep;
 };
@@ -292,7 +292,7 @@ struct json_print_state {
 static void json_print_start(void *ps)
 {
 	struct json_print_state *print_state = ps;
-	FILE *fp = print_state->fp;
+	FILE *fp = print_state->common.fp;
 
 	fprintf(fp, "[\n");
 }
@@ -300,7 +300,7 @@ static void json_print_start(void *ps)
 static void json_print_end(void *ps)
 {
 	struct json_print_state *print_state = ps;
-	FILE *fp = print_state->fp;
+	FILE *fp = print_state->common.fp;
 
 	fprintf(fp, "%s]\n", print_state->need_sep ? "\n" : "");
 }
@@ -370,7 +370,7 @@ static void json_print_event(void *ps, const char *topic,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
-	FILE *fp = print_state->fp;
+	FILE *fp = print_state->common.fp;
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
@@ -446,7 +446,7 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
-	FILE *fp = print_state->fp;
+	FILE *fp = print_state->common.fp;
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
@@ -521,10 +521,12 @@ int cmd_list(int argc, const char **argv)
 		.fp = stdout,
 		.desc = true,
 	};
-	struct print_state json_ps = {
-		.fp = stdout,
+	struct json_print_state json_ps = {
+		.common = {
+			.fp = stdout,
+		},
 	};
-	void *ps = &default_ps;
+	struct print_state *ps = &default_ps;
 	struct print_callbacks print_cb = {
 		.print_start = default_print_start,
 		.print_end = default_print_end,
@@ -572,9 +574,11 @@ int cmd_list(int argc, const char **argv)
 	argc = parse_options(argc, argv, list_options, list_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (json)
+		ps = &json_ps.common;
+
 	if (output_path) {
-		default_ps.fp = fopen(output_path, "w");
-		json_ps.fp = default_ps.fp;
+		ps->fp = fopen(output_path, "w");
 	}
 
 	setup_pager();
@@ -590,14 +594,13 @@ int cmd_list(int argc, const char **argv)
 			.print_metric = json_print_metric,
 			.skip_duplicate_pmus = json_skip_duplicate_pmus,
 		};
-		ps = &json_ps;
 	} else {
-		default_ps.last_topic = strdup("");
-		assert(default_ps.last_topic);
-		default_ps.visited_metrics = strlist__new(NULL, NULL);
-		assert(default_ps.visited_metrics);
+		ps->last_topic = strdup("");
+		assert(ps->last_topic);
+		ps->visited_metrics = strlist__new(NULL, NULL);
+		assert(ps->visited_metrics);
 		if (unit_name)
-			default_ps.pmu_glob = strdup(unit_name);
+			ps->pmu_glob = strdup(unit_name);
 		else if (cputype) {
 			const struct perf_pmu *pmu = perf_pmus__pmu_for_pmu_filter(cputype);
 
@@ -606,15 +609,15 @@ int cmd_list(int argc, const char **argv)
 				ret = -1;
 				goto out;
 			}
-			default_ps.pmu_glob = strdup(pmu->name);
+			ps->pmu_glob = strdup(pmu->name);
 		}
 	}
 	print_cb.print_start(ps);
 
 	if (argc == 0) {
 		if (!unit_name) {
-			default_ps.metrics = true;
-			default_ps.metricgroups = true;
+			ps->metrics = true;
+			ps->metricgroups = true;
 		}
 		print_events(&print_cb, ps);
 		goto out;
@@ -636,57 +639,57 @@ int cmd_list(int argc, const char **argv)
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") == 0 ||
 			   strcmp(argv[i], "hardware") == 0) {
-			char *old_event_glob = default_ps.event_glob;
+			char *old_event_glob = ps->event_glob;
 
-			default_ps.event_glob = strdup("legacy hardware");
-			if (!default_ps.event_glob) {
+			ps->event_glob = strdup("legacy hardware");
+			if (!ps->event_glob) {
 				ret = -1;
 				goto out;
 			}
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			zfree(&default_ps.event_glob);
-			default_ps.event_glob = old_event_glob;
+			zfree(&ps->event_glob);
+			ps->event_glob = old_event_glob;
 		} else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
-			char *old_pmu_glob = default_ps.pmu_glob;
+			char *old_pmu_glob = ps->pmu_glob;
 			static const char * const sw_globs[] = { "software", "tool" };
 
 			for (size_t j = 0; j < ARRAY_SIZE(sw_globs); j++) {
-				default_ps.pmu_glob = strdup(sw_globs[j]);
-				if (!default_ps.pmu_glob) {
+				ps->pmu_glob = strdup(sw_globs[j]);
+				if (!ps->pmu_glob) {
 					ret = -1;
 					goto out;
 				}
 				perf_pmus__print_pmu_events(&print_cb, ps);
-				zfree(&default_ps.pmu_glob);
+				zfree(&ps->pmu_glob);
 			}
-			default_ps.pmu_glob = old_pmu_glob;
+			ps->pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			   strcmp(argv[i], "hwcache") == 0) {
-			char *old_event_glob = default_ps.event_glob;
+			char *old_event_glob = ps->event_glob;
 
-			default_ps.event_glob = strdup("legacy cache");
-			if (!default_ps.event_glob) {
+			ps->event_glob = strdup("legacy cache");
+			if (!ps->event_glob) {
 				ret = -1;
 				goto out;
 			}
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			zfree(&default_ps.event_glob);
-			default_ps.event_glob = old_event_glob;
+			zfree(&ps->event_glob);
+			ps->event_glob = old_event_glob;
 		} else if (strcmp(argv[i], "pmu") == 0) {
-			default_ps.exclude_abi = true;
+			ps->exclude_abi = true;
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			default_ps.exclude_abi = false;
+			ps->exclude_abi = false;
 		} else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(&print_cb, ps);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0) {
-			default_ps.metricgroups = false;
-			default_ps.metrics = true;
+			ps->metricgroups = false;
+			ps->metrics = true;
 			metricgroup__print(&print_cb, ps);
 		} else if (strcmp(argv[i], "metricgroup") == 0 ||
 			   strcmp(argv[i], "metricgroups") == 0) {
-			default_ps.metricgroups = true;
-			default_ps.metrics = false;
+			ps->metricgroups = true;
+			ps->metrics = false;
 			metricgroup__print(&print_cb, ps);
 		}
 #ifdef HAVE_LIBPFM
@@ -694,40 +697,40 @@ int cmd_list(int argc, const char **argv)
 			print_libpfm_events(&print_cb, ps);
 #endif
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
-			char *old_pmu_glob = default_ps.pmu_glob;
-			char *old_event_glob = default_ps.event_glob;
+			char *old_pmu_glob = ps->pmu_glob;
+			char *old_event_glob = ps->event_glob;
 
-			default_ps.event_glob = strdup(argv[i]);
-			if (!default_ps.event_glob) {
+			ps->event_glob = strdup(argv[i]);
+			if (!ps->event_glob) {
 				ret = -1;
 				goto out;
 			}
 
-			default_ps.pmu_glob = strdup("tracepoint");
-			if (!default_ps.pmu_glob) {
-				zfree(&default_ps.event_glob);
+			ps->pmu_glob = strdup("tracepoint");
+			if (!ps->pmu_glob) {
+				zfree(&ps->event_glob);
 				ret = -1;
 				goto out;
 			}
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			zfree(&default_ps.pmu_glob);
-			default_ps.pmu_glob = old_pmu_glob;
+			zfree(&ps->pmu_glob);
+			ps->pmu_glob = old_pmu_glob;
 			print_sdt_events(&print_cb, ps);
-			default_ps.metrics = true;
-			default_ps.metricgroups = true;
+			ps->metrics = true;
+			ps->metricgroups = true;
 			metricgroup__print(&print_cb, ps);
-			zfree(&default_ps.event_glob);
-			default_ps.event_glob = old_event_glob;
+			zfree(&ps->event_glob);
+			ps->event_glob = old_event_glob;
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
 				continue;
 			}
-			default_ps.event_glob = s;
+			ps->event_glob = s;
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
-			default_ps.metrics = true;
-			default_ps.metricgroups = true;
+			ps->metrics = true;
+			ps->metricgroups = true;
 			metricgroup__print(&print_cb, ps);
 			free(s);
 		}
@@ -735,12 +738,12 @@ int cmd_list(int argc, const char **argv)
 
 out:
 	print_cb.print_end(ps);
-	free(default_ps.pmu_glob);
-	free(default_ps.last_topic);
-	free(default_ps.last_metricgroups);
-	strlist__delete(default_ps.visited_metrics);
+	free(ps->pmu_glob);
+	free(ps->last_topic);
+	free(ps->last_metricgroups);
+	strlist__delete(ps->visited_metrics);
 	if (output_path)
-		fclose(default_ps.fp);
+		fclose(ps->fp);
 
 	return ret;
 }
-- 
2.52.0.rc1.455.g30608eb744-goog

