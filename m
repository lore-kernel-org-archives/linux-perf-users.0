Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EAE2DE702
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413178; cv=none; b=Pr2sJ5llyfLg54Ow9lqlJmYDxz27JKG2BnOUaT7fb7a7sNanUVzhip7UoySPSOj0HN+34VmpJqgLi7TCbz6dpCOttktpnwpheLVtAbXvSZQG68BuguNPLt21QeLRyfdnBuzAohS2cKqbySDzTvrNdGYNRD2a58f1b0gcHWcmiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413178; c=relaxed/simple;
	bh=PsrLYZ63S4/Yl5gUDazBRZIT23aCtdqQCezqcEzmpgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oDOWqBLDJok1Nx3HD0ofl6X9nUC79KwgsoaTXoAiPtTfjOM3RTeclu+AGPq1P6Hc4pqr2934wVkNaUUAlkYjzEo2zL/1WUnB59ruYOr3+Ro1ir2Kk8ftFON1iInCc4quAreWlhgtz5+OYYyKUnDcQ9nkDE/bxXR7SYYkd8KKkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0R/icLo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0R/icLo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9a72a43e42so531190a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413175; x=1763017975; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xO1dG1dA38tu5LHgCObN6Aj03K5VCieIjvEPjfcsmMk=;
        b=E0R/icLo3lPx8rGqKs9fHIP0uUTIBJ7PZ4x/5/gQn/gaEhs13+49OAmO1Dl/O3fJOe
         QcJqR9SYepqR9DngbK4BgpSEVyLt4rfLlWyPkvUSfzuS+2WlKA1KpDLN9JWofMZjvdVu
         Adl5mEjx7M4qRHWkY6BAmLcy8wZw9Lo8Ak/I6VwmkgMB0GnsNMovU46nyHC0xPcdVdIL
         M9rf5dgEP31KJ+xZOgJfqWg0IVUg/iLtY4rGKMeFuesDuOIrXtRuQ0IQhLjc9L+uGDCL
         J0R+SjJlk46c6Yvmo8CYMaLMr/H1EoexOeTHhZhM4Ys7OfYl13zrnajNsAX6YmbhAe6M
         ZrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413175; x=1763017975;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xO1dG1dA38tu5LHgCObN6Aj03K5VCieIjvEPjfcsmMk=;
        b=fCWft57iJb2OJbYY1GjL92hq04D/xL9rKlfUFVvAGwbtWJw6CLwaEcS+E65Dvehvw1
         aQBpEd0mLf0guHq1f80EL34hWywMaP2QpDm4u/cp8+hrRBrWtEZuYSilmh+15LGXU5s+
         oPZszS31Fa8l7XTYXphXPk1XX2OrAMyhtPsJuguixz/DqRkIgX0Wcu+14cFJVaGPJkQC
         P8Olub6lcZvBdmmDAipMHTY2rROsGdKCbafLJ++8cBqQ1mjBA4XE5SP7TJXWb7MpTbpw
         8i3+mPlH+QDygX8CxgupOTh9Tm+V80l+X+gm+Mx7ymib7vepXrVuoeBNzt8UbePakxL3
         5hUw==
X-Forwarded-Encrypted: i=1; AJvYcCUNzbqc+IaA81nROQXw4wRx8XAdZQp5X/fopLLKSgt4TbGVzxdVEp6sBHOcNidTVnajgMNT80pAjlKcjU43K74z@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYWIcka2+3irMWvixTG8LHxQR1wcNIrYUvQ/dB63dpKFqzzYx
	pHiN6IgayL/xdX5MTWyGBYjc1ZAZM5dfnXgKcuXspZGk3xwcVD9mUDVc8uLo2UVpehWuKShobdI
	5aeU5mTUQpA==
X-Google-Smtp-Source: AGHT+IHfNtEmB2vzB5Qgk4FgJ6by0dipPevRra6zzBmqo37BLyLVuIe07shcJ43P7IrSPny8s42SfF6V60Pa
X-Received: from dlad18.prod.google.com ([2002:a05:701b:2212:b0:119:9f33:34af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9989:b0:251:43f5:cad4
 with SMTP id adf61e73a8af0-34f84008799mr8440665637.10.1762413174906; Wed, 05
 Nov 2025 23:12:54 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:36 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-6-irogers@google.com>
Subject: [PATCH v3 5/9] perf stat: Reduce scope of ru_stats
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

The ru_stats are used to capture user and system time stats when a
process exits. These are then applied to user and system time tool
events if their reads fail due to the process terminating. Reduce the
scope now the metric code no longer reads these values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 14 +++++++++++++-
 tools/perf/util/config.c      |  1 -
 tools/perf/util/stat-shadow.c |  2 --
 tools/perf/util/stat.h        | 16 ----------------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d89fa9468f89..3cd663b3b357 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -132,6 +132,7 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static char			*metrics;
+static struct rusage_stats	ru_stats;
 
 struct perf_stat {
 	bool			 record;
@@ -729,6 +730,17 @@ static int create_perf_stat_counter(struct evsel *evsel,
 					      evsel->core.threads);
 }
 
+static void update_rusage_stats(const struct rusage *rusage)
+{
+	const u64 us_to_ns = 1000;
+	const u64 s_to_ns = 1000000000;
+
+	update_stats(&ru_stats.ru_utime_usec_stat,
+		(rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
+	update_stats(&ru_stats.ru_stime_usec_stat,
+		(rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -978,7 +990,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__reset_aggr_stats(evsel_list);
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
-		update_rusage_stats(&ru_stats, &stat_config.ru_data);
+		update_rusage_stats(&stat_config.ru_data);
 	}
 
 	/*
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6f914620c6ff..cc0746f494f4 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -45,7 +45,6 @@ struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
-	.ru_stats		= &ru_stats,
 	.big_num		= true,
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 939ac3269a44..c59578886b4f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -18,7 +18,6 @@
 #include "tool_pmu.h"
 
 struct stats walltime_nsecs_stats;
-struct rusage_stats ru_stats;
 
 enum {
 	CTX_BIT_USER	= 1 << 0,
@@ -74,7 +73,6 @@ static int evsel_context(const struct evsel *evsel)
 void perf_stat__reset_shadow_stats(void)
 {
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
-	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
 static enum stat_type evsel__stat_type(struct evsel *evsel)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 34f30a295f89..5b8b4675883c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -102,7 +102,6 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-	struct rusage_stats		 *ru_stats;
 	struct cpu_aggr_map	*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_aggr_map	*cpus_aggr_map;
@@ -132,25 +131,10 @@ static inline void init_stats(struct stats *stats)
 	stats->max  = 0;
 }
 
-static inline void init_rusage_stats(struct rusage_stats *ru_stats) {
-	init_stats(&ru_stats->ru_utime_usec_stat);
-	init_stats(&ru_stats->ru_stime_usec_stat);
-}
-
-static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rusage* rusage) {
-	const u64 us_to_ns = 1000;
-	const u64 s_to_ns = 1000000000;
-	update_stats(&ru_stats->ru_utime_usec_stat,
-	             (rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
-	update_stats(&ru_stats->ru_stime_usec_stat,
-	             (rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
-}
-
 struct evsel;
 struct evlist;
 
 extern struct stats walltime_nsecs_stats;
-extern struct rusage_stats ru_stats;
 
 enum metric_threshold_classify {
 	METRIC_THRESHOLD_UNKNOWN,
-- 
2.51.2.1041.gc1ab5b90ca-goog

