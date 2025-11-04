Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9782DAFA9
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234519; cv=none; b=gmI5COfcH5pZdj26FmZn4bjVSMZjqQzw9yXL27fBLn3rUUTeFWQ0uUg/jYHNgEfW31pL0mkJv3wfoOEwDhNhmuBmEKfrkZUg0Veue7jbJIO2/ICv60xz92hi/I1Q+bRQA/D5d1duIYwutagoR9lArs+vS98y3s1wLCdlj1NXCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234519; c=relaxed/simple;
	bh=aSDJA62mh/W7207RAJ4s1qiw6gCAvN0Vwrm2MXwZEOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hcD3qAJzD7ayEK69J5P1Wvn/d38O498JDjKlFnRQ2wt8gv0sQR/KA5eticgOELVJoiSV+uXm+Dv718TFdXElwc6RAePWOgQo5rhLl/5PYTnmS3Q6ZLR0lpQScG5JWn9pM4/YcPcBmcSAeZ+ivkSkWLdnLTS2TcTkZO93qadvyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1w7y+D7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1w7y+D7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-78658266df1so35066827b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 21:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762234517; x=1762839317; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd74J25OC6bAFZtXTXLpUwvxIO4291BBgJ3n2WJijvY=;
        b=d1w7y+D7gXQT6LrNp0OpJSjYpzdriXhlB9WJl+OLVllBCVeywgAiR3Q7xcqyQB63sQ
         ec+UJScpWAn5LhwaolOl8Vj2eofBwA7b+xdM25G0TF0EBhFItSAw21InPZL8nRW9Szec
         5WH8BLt1VtEhmizef+2lF6pmXUi9ed2TSEvQF8PMRcwcPwkaHJ3RZzu59Ud/21i0fBj5
         4HZn+P5BzM2lNgb4roRGG7pmmiOWuEZrQovCTMc9pmEeCmBIEMAWFNKcefN6IVhYo5fV
         Jjl3C8Lff2pFP7ItiBSa3eIFZkJgbSaFHR84HROXrLk7Bukp4CDw6Duxk2fqoZXip/2u
         RCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234517; x=1762839317;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qd74J25OC6bAFZtXTXLpUwvxIO4291BBgJ3n2WJijvY=;
        b=E/u9uVp+KdjXZYNMzanV4iSJuIPV6VpHE+2lQACbZwNu6EqYGWKS46BxjAqeitYR5i
         hFgNrCWbdN8N8nqqlooKhyjhqv/PegMyXU+n/bgZbWTTCm6/KtmK407hShOBil4S7NGu
         yH+iEavzgt6p46lf4RTiG+ddZ8MZDVkf0QcRbQatmqBecbVKcz3gUnt+AVXmKWBil+Fd
         p5Ngc1supJsUs+s9ny5NIm7qL7/YsfhOy6sbHwfOxT20ahwejMwxMOa+b2jbMrtVmp/C
         5kHZtIYPWAqrQCO2GPCKaJwh+AxD7GFdJiL7hfyYO4hYcIiwIeUWyYmZoyoUOLY5Advd
         7qcA==
X-Forwarded-Encrypted: i=1; AJvYcCVqbYecFkV4zVR/BKcdXwv6AkENzn5rQ5SMFay3yXfBlE2fVp13hPpSOKqrjxYhl3K8AN+1a/+NWuNFLPspa9/z@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQSZ/nV5Qwf89e3YhObL2poXb4IwjWtWkIkqeqFYI1nIqWX5f
	OF4UBqvND+X01bVSYRj3K+nF8kMxi0hVrK8WCMXQMeG/gDNCP8YCF0ZW/xxUYOzhfIjHG1pApLX
	1bwMFGseRNA==
X-Google-Smtp-Source: AGHT+IHcd3ZeyhXX0u7KoqrhOivRqs854gsZbVFyElx8uffDBc4wTk9cNDZqn01PHV7DFxtKDCVI/HbRHp7b
X-Received: from ywt5.prod.google.com ([2002:a05:690c:9a05:b0:76e:1529:a135])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:e18:b0:784:8b01:c21e
 with SMTP id 00721157ae682-786484cbb06mr136715307b3.45.1762234516911; Mon, 03
 Nov 2025 21:35:16 -0800 (PST)
Date: Mon,  3 Nov 2025 21:34:49 -0800
In-Reply-To: <20251104053449.1208800-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104053449.1208800-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104053449.1208800-3-irogers@google.com>
Subject: [PATCH v1 3/3] perf stat: Reduce scope of ru_stats
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index 9fae3d32a519..0bf96b19a37a 100644
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
2.51.2.1006.ga50a493c49-goog

