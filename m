Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969037F75B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159114; cv=none; b=HyhgmoApS832ItwxE2qUmEqPbz/8XuU8r/Kf5ZNSEzj3MqX+NMfQCobcx279yKdbD13CyBMreCzUKNogQiGTNWWZp0zOYFZ6GR6bvIEIkjxwS6M6NnBWmgT+WajBJi7FvJ5+tO5b2NlCZ7Pva9QlPYA4VLw5zVgvAy6gTEX1480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159114; c=relaxed/simple;
	bh=4dzqlAY6Jwfn5UZRMxqibkJ/WzReutE/CulfgusKL0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WKV4poaljufae+oYiaIoLCH/4sMw/6F5gUAnXL29QPhTQtF4Cxt5fPWR/z1uDVFBSD3MTFDN0V08ziAl7uGoIrCE2DZZ9URRampY/4wP8wxsQVzKAvc5Wl2FNUn78ac+GQ1ZD8AKmPy+exkp8Zt3f/1USTLooEWMA0bytbvGXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sj8H1v7R; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj8H1v7R"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81f53036ac9so118170b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 14:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159113; x=1770763913; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNGV+9W9psENt274mz6PMhj6c8c5MewbEM3NGZmHhlM=;
        b=sj8H1v7RTkZ2CjP69ZBd+bKMeopp7+up9Fz+sQELAW4vZIjYMEB92bgCSfe9q3+HLW
         2iis+PSQe3jhdpPkz09dm91gJW8PFEW/aa/o0va1vv9I/wiyr2HATuhtdH1P8Xe+EAHG
         nqn5p+PDmC1QNzidWeQjfjc6JBGkt6AXVRkVsMIUFyn8Gnv9JNhJCzSF9W2yErpOQYLk
         3S8zgJSLPo2Q5TeHheg2mPAtn10D1Xm+vqFfnGqOm5qSIH+DvAh1tZWkkjJv2MUd1rTr
         yAcSvLA3KTE3CD3qUqaTdbfBtN4783iwcx4XSzlJ9pcXMhQubKN/2dnQC6nOZnCxQn51
         5ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159113; x=1770763913;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNGV+9W9psENt274mz6PMhj6c8c5MewbEM3NGZmHhlM=;
        b=igdSym2CAMB2/bI+9Vwu+Xw8kblX13x8lU23v+uqu33agj9Z5OT/l+2cbEUtQ7HmLy
         h6tGRhaqmkXIwJpNBdaTa3aKfB8+6HJwhnuKcof+77mmPqubqwRo7jVunXE1lcpGm1Gb
         tH+3yadoR4g1goAG/8fbQFPcW2KKWZTMrYytZsUYT24yEmxtgb3fH+2K652yGdcLSqcu
         Mf0H9ByBVG+UsvSiFvM5+dN3AxhhEHvbz5mSte113IHRNR2pGZuEJN23LHgmxZfOpLDP
         NK//tczwth5hx7LJWjXVO5U+OqhqOKjQZ01UnHhbwmHUO8J+4Y0YVNIQMQAQ4ZusQYmN
         cpXg==
X-Forwarded-Encrypted: i=1; AJvYcCUNY3jShX5aToUp7EZbq4PCreft1m00cHNyCVCBcAIAVt2WkqsoRMD119+EvQxix4bLErYAkTSg7s7PkZryq0G2@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJ6fU11WtelRx4OpspAsGjX6Uv00N6qUNvTqGkhTxK3+lokzd
	KKxVdZqBm5fHz0yIvA16KXtttOzhMJt+s0bqbk9rC2XkpPUlS1v70kQByJSKs6wyi0eg/QS7f3X
	R/PjwVAar7w==
X-Received: from pfjg11.prod.google.com ([2002:a05:6a00:b8b:b0:81f:7db9:83d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1709:b0:81c:5694:c544
 with SMTP id d2e1a72fcca58-8241c637192mr908753b3a.56.1770159112816; Tue, 03
 Feb 2026 14:51:52 -0800 (PST)
Date: Tue,  3 Feb 2026 14:51:29 -0800
In-Reply-To: <20260203225129.4077140-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203225129.4077140-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203225129.4077140-7-irogers@google.com>
Subject: [PATCH v7 6/6] perf stat: Add no-affinity flag
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Andres Freund <andres@anarazel.de>
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
index c1bb40b99176..8bbdea44c3ba 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2426,6 +2426,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool affinity = true, affinity_set = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2554,6 +2555,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
+			"don't allow affinity optimizations aimed at reducing IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2611,6 +2614,9 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
+	if (affinity_set)
+		evsel_list->no_affinity = !affinity;
+
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 45833244daf3..591bdf0b3e2a 100644
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
2.53.0.rc2.204.g2597b5adb4-goog

