Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C633B6ED
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907642; cv=none; b=dI8HEI3BAH4o/Q4ks9ki5IkgLZ+x/w/9TJqJWIm/YQ5GKv60uJnXCOHJVKiDNZ8VNKUNIuXdNYnzm9x+/9NtzR2TCCbfA+gDJUhisKs2j8ehZn88eGtBVbowQe8CRd8qHzZbeAWnO9y9qiTCHAJUqplijxrr51P5kNJ9tkGZT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907642; c=relaxed/simple;
	bh=9QSZcQcj06aGsLJctNtUugZ9Hfk2wEdVuIqDA19JJe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SWfTqESy8weVhISBoNqdk5nDCczCeVFYTAgvzWM2JmtoCogCocCdJ3cDMKGCsFKwbqy5WYLy8+3RB/5K9NXQeQBAyUnnLejhjyhAlBYtbp4zRkvq5pRQAHk2dxvvNvkkx0DF1jrKB+yMi+b+OvjOmbRSsUe574FgZ/O7utHoTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOROiPIN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOROiPIN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11dd10b03d9so4065160c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767907640; x=1768512440; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuVfDturXVb+EuYCA3jpCBxVlvPd/xtKWCXz7A8dJxc=;
        b=OOROiPIN2YvRtmfezWQlxOy+wJgLdm7N+d/c1oBUfPQAITExyhuchLdCrlCqVJMrV2
         1+7Qcyby3S312FdGy1ECrGqg21d1hEb7+yva4xWhFJcvgXsF+VEJGoRV5UaDP7f5f5c5
         KTF9bV9oUrdKxZn+eKhAnkTeCKMvQ/e7kQhI+wGm4e/MvDc5lfoCSrcfiUqbzvB96Lc+
         leOFlqEt8afnJX6ghK4EaEo6KzevUEwEiyxs1CgUawK9dpLEMq5nL5oCFcOa8UJG/3mH
         dnlyyUvfLJqVOa+lTNet1/X7IF1VaV2wwEwZpIVMBxPxjLbi5rc1yl8Zy83Y8MQ4L4q6
         uLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907640; x=1768512440;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuVfDturXVb+EuYCA3jpCBxVlvPd/xtKWCXz7A8dJxc=;
        b=lB6M1VBvkVM1GdP+TxMZjcZHTC8pNPnAwe6GnS0WQsoPjJy8X9csMOZoRfjtGa6Gfe
         4jddPoHvrXUAl0SX+5zQdU0RqkgJJF+I/OtomvaPDSg9LnUkZ3dyA4VWFUPpx1NDARcU
         gL26geolyG73BrronMFJivR1IIATCOW9fA6WE5zfVh2lJSO1Xr+8uT42uoXyIa3u94IJ
         AEEHSH+7U6kHuB4lke19n0W+5oRtFVJorTa85VZp6JHlIZDCToSmc/ko2w7S/DJgTwLJ
         ftbvjTmIrR5+Ylqr/6yznaDnFU0slhvR1Xc6R1MYYLDo/QuYHh+a0ArufBsV6PbnydIg
         tENg==
X-Forwarded-Encrypted: i=1; AJvYcCVjqjolpXRt6VlqmZ3fhfUNqWMnbl1tmVLOrxh5X/JeXww13KuQL9cUvaSZs2XxWq2qPTTigkvyiekWHGBgvDRe@vger.kernel.org
X-Gm-Message-State: AOJu0Yycb20tvKV8szcvTPYRJ5wIMMxP2Gyebit5YrTLnL7XLW+vnIzG
	yAkTK0Vgsy0CidW4xNp1kOy2aW7P5yOt1dFTl2qgJaSf+h6Gy4No+gscXQId4qR98fQqjh4XQxJ
	yYBt8X7hMXw==
X-Google-Smtp-Source: AGHT+IH3VQ58yS97Y3k2iUcc6x+Zh0qVcQROKjoenZAcLDLOMeqvPg90KvCalXFHU5GEJr1mmtjxce5RhVXs
X-Received: from dlee30.prod.google.com ([2002:a05:7022:629e:b0:121:a019:8a44])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:799:b0:11b:7dcd:ca9a
 with SMTP id a92af1059eb24-121f8b8b46emr6739841c88.34.1767907640181; Thu, 08
 Jan 2026 13:27:20 -0800 (PST)
Date: Thu,  8 Jan 2026 13:26:52 -0800
In-Reply-To: <20260108212652.768875-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108212652.768875-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108212652.768875-4-irogers@google.com>
Subject: [PATCH v6 3/3] perf stat: Add no-affinity flag
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

Add flag that disables affinity behavior. Using sched_setaffinity to
place a perf thread on a CPU can avoid certain interprocessor
interrupts but may introduce a delay due to the scheduling,
particularly on loaded machines. Add a command line option to disable
the behavior. This behavior is less present in other tools like `perf
record`, as it uses a ring buffer and doesn't make repeated system
calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 4 ++++
 tools/perf/builtin-stat.c              | 6 ++++++
 tools/perf/util/evlist.c               | 6 +-----
 tools/perf/util/evlist.h               | 1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 1a766d4a2233..1ffb510606af 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -382,6 +382,10 @@ color the metric's computed value.
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
 
+--no-affinity::
+Don't change scheduler affinities when iterating over CPUs. Disables
+an optimization aimed at minimizing interprocessor interrupts.
+
 STAT RECORD
 -----------
 Stores stat data into perf data file.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bb14268e7393..ddda0ea62eaf 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2427,6 +2427,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool affinity = true, affinity_set = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2555,6 +2556,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
+			"don't allow affinity optimizations aimed at reducing IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2612,6 +2615,9 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
+	if (affinity_set)
+		evsel_list->no_affinity = !affinity;
+
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d62b8bab8fa4..00fb3cf45bae 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -369,11 +369,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
-	if (!evlist->core.user_requested_cpus ||
+	if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
 	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
 		return false;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 30dff7484d3c..d17c3b57a409 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -59,6 +59,7 @@ struct event_enable_timer;
 struct evlist {
 	struct perf_evlist core;
 	bool		 enabled;
+	bool		 no_affinity;
 	int		 id_pos;
 	int		 is_pos;
 	int		 nr_br_cntr;
-- 
2.52.0.457.g6b5491de43-goog

