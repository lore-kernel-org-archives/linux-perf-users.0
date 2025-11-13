Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0435A140
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057155; cv=none; b=tpFoeEG1g268RMBNt0n6Db7kekMZiAL87YZr/BCB+0OnJ6ZDgngcef9cXErRgqg6UZ8q0Skp75kHD5CIhdQGfHlPXUyiflERAouAq3bMj8AWXbkJFuty0xosFdf2eeLFeoEYH8Knti4qKsJC5aoSfIO5s+9G9NWAltd02XL1q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057155; c=relaxed/simple;
	bh=uV3AqahuvBOAec4rbwf3PNsJdf98h98d2CbuPAwnjNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RwOWi9N/LdJvAPSLPKBdRhFTTfkE667ff7wV6Vg6yLTxTBF05nawktVzLYZHA99nkBxhYsD/BukLYw7CMamU4XNXg/Ji7LB+rkJUZAw8oiYywTQakhrdh3OwNVT4ogeFZHoLG7f/6OyTgSamyESRiN6Ds+vW1cvMZcIX2jsNTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lsq11ilV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lsq11ilV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5533921eb2so930933a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057153; x=1763661953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEiCVcfmBq7/07PDARSKfpxXyKmbnJgNjTv23W0kYR0=;
        b=Lsq11ilV25+4mCxwa2bWiQuZx0CV9GCMwgd4VC94bmeN55hCkhP30LRbBqmXhX2eCi
         FNsLLHtZRlXkKk3HuOk4Gr5rzzs3y79kUMGQ9539riyZxSwlA1QdNsTb6DEr81PzHOmb
         FhGSHZvmctmqPIta2smBLmruhTskrc79rhMvx879FDX6+/WHNxAm+OIg9O9Dyk2GN2FA
         Ewy5v7jxoahVQvrjKFYhlN2+N3+Y8JKlpEkVRS73ZqLFCa2Ujjl4SjwuIy0UEQzxvXlq
         dhHh6r0nrLLAGNex5Q1VTQqIcVy38LoDnKg9PNixR8UyvFogBLQ//hmRe0aARjxs0GZg
         23OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057153; x=1763661953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEiCVcfmBq7/07PDARSKfpxXyKmbnJgNjTv23W0kYR0=;
        b=Cy0xOETWVFdDfwBzPyGQfEGON3fX5qZm3dIwh46JZhek7jl62EEdVxPfb2vwRyfuvJ
         /9ARXcLB3HYRhKfPoJyCUjZMnU4COYgCaBWADhmLf2iTXg2QQ8OS+9M/Nqs5MbHxl9MD
         mlQUMuVwCM1WB67PPQrLpIz5/U6JCkXszJnERp4bBxlMvKCm1ZXZ+2NbgQCUm/YjKjk1
         vF71gJCjDSzygkH5Qr9SFHYtQqhveiVESRRoSWY8E9w2dffHueV+q8pOY0wpNePsrfB9
         OO+wVmTYl71jvYtSsNwLmByd7+pT+r9QaZSX+JkqOZ1cRbJJrG5tKVuze+GWPJy3Fxry
         Uzgg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ttMIUCFCoeSTHohioM7HaWzprU08AgJBydLYpnpWQg3WaKL2S/1BkXtwRYdU5qQE2LJJ/0k6ja+ePx+eHDIU@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvP+3+1TMYeNIsyDt++Hg9ZtYJoMtrOXLkBnb99OIfz0eEz4Q
	tSfB9K2YbqS+KdNito5WHyPfgaw/2O+Ns2gxIUzbNBNxKq74qKc+N6B5oIMxcqR0+ER+uNIGvIc
	ozEZi5xs3QQ==
X-Google-Smtp-Source: AGHT+IGlqFaqOqL8Z5qwpdJ2PvxfOLh9uRRj8qgwXUyX3PabwIarjuBObD5fLJzc8iTeTO7Mp1A5S+tlFZzh
X-Received: from dycuf3.prod.google.com ([2002:a05:7300:103:b0:2a4:5a4a:cc6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bc1a:b0:2a4:3593:6466
 with SMTP id 5a478bee46e88-2a4abb1cf05mr160639eec.22.1763057153014; Thu, 13
 Nov 2025 10:05:53 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:11 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-6-irogers@google.com>
Subject: [PATCH v4 05/10] perf stat: Reduce scope of ru_stats
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
 tools/perf/builtin-stat.c     | 19 ++++++++++++++++++-
 tools/perf/util/config.c      |  1 -
 tools/perf/util/stat-shadow.c |  2 --
 tools/perf/util/stat.h        | 21 ---------------------
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 654f840f7a2f..d6f4c84f7d7e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -104,6 +104,11 @@
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
 
+struct rusage_stats {
+	struct stats ru_utime_usec_stat;
+	struct stats ru_stime_usec_stat;
+};
+
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
 static struct evlist	*evsel_list;
@@ -133,6 +138,7 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static char			*metrics;
+static struct rusage_stats	ru_stats;
 
 struct perf_stat {
 	bool			 record;
@@ -730,6 +736,17 @@ static int create_perf_stat_counter(struct evsel *evsel,
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
@@ -979,7 +996,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
index 6c1ad78604e1..cb7c741a1ebb 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -18,12 +18,10 @@
 #include "tool_pmu.h"
 
 struct stats walltime_nsecs_stats;
-struct rusage_stats ru_stats;
 
 void perf_stat__reset_shadow_stats(void)
 {
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
-	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
 static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b42da4a29c44..055b95d18106 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -56,11 +56,6 @@ enum aggr_mode {
 	AGGR_MAX
 };
 
-struct rusage_stats {
-	struct stats ru_utime_usec_stat;
-	struct stats ru_stime_usec_stat;
-};
-
 typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, struct perf_cpu cpu);
 
 struct perf_stat_config {
@@ -102,7 +97,6 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-	struct rusage_stats		 *ru_stats;
 	struct cpu_aggr_map	*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_aggr_map	*cpus_aggr_map;
@@ -132,25 +126,10 @@ static inline void init_stats(struct stats *stats)
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

