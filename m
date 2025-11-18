Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616B31ED61
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500440; cv=none; b=LbvTQ3xD7gvol/kvkMm378adtVrDj1Q9fX45hHPb7zNw0nLLmpj9qlYh9kv8chjtEjoBvYf++n9Glfwu0fMw3TFpr6oodTnKPOwAfwPtJLPCJzO3eEe1mZGDfESutbRITgkPTSVCdo1T0Ex8qYufdZ4f44ruv2xdjwRANWkhNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500440; c=relaxed/simple;
	bh=VEpT3v6RLJRFkj8ymYX48s+IRBrIsnUY0acR3wn+Eso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QyvFWoN4N2FHjUdmAQMbK5WQSX0BLgmuyhBK1hSbE6bxxDZ4nBHce4+sEaFVqKHEciuD9GOMxxBKTkh1paV95RHeJOc0uMlBS2ZdxmCDIQew097xK2B2UWNNXEuY/ok2of13LlUzgVkaUGH80QgiwfKtfNhXE3QdbZHBlh5nSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZhwNc1r; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZhwNc1r"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9d73d57328so5332003a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763500438; x=1764105238; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/H5xzxd1i+W7d1YbcZd00dgpIJmb7baAkr21TY30fQQ=;
        b=xZhwNc1rAqfYNnZ2fJul0pyGNgU+ENI5ORWxiIe7Xdu0UT1pmKIFVMZdn9fYBl3ALj
         ghKh5A+yQuPhSAxiJq4uQq/p8GNZ3r+InGyJDQkahu8ca2RCOXkuS44Nn8jyxS3WPyN+
         M2hpFQ5Zm68Q1uaZQnImlDr+Rd26CNooLOWuUefrmKujkrDPlPDycb4zp7ci1G0UQx6o
         M7u54xulYmSYxT/zgfVdJBOtz3ROPXz/YhGKaf7WFbZpnmAV/hPlguboKp4teN6h/F0I
         RJKsD8h033wbyK1+fj7q6iBvhBEMnaeBWTvtM+dyaYn+CAh6+3ddUURslCxE8A226kf8
         gVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500438; x=1764105238;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/H5xzxd1i+W7d1YbcZd00dgpIJmb7baAkr21TY30fQQ=;
        b=YZnOnTaBAf8eot1EtgfyUSnd+tGRgrAMNBb9XZBBcL4yRf0UA1qZgFu9uCzylNABwg
         neH1/B9bnDGYe1sxgTJzOUTO2eLXLk6ITddfcanRJjsMdgnmUro3b8IK476B4esxns/G
         6KJ5bT7DVbKOdaQmMIa1/Sf5z2/KLMsDeeWityXC+TkTvxCV/uh/AkZL2mrNLHPCcBiD
         9SHXRc3Zc3UVYhFzoFn6SUXgNO6kTMIwouVaaqxcTxFrdQTZ93qE/rnHkKXnO5HsyUOH
         S05SJdT1z9qBFWN6hfiwbWFMdW0j4ftOauMRcCOcXuMyYklpK0vGdyLGhJkhBd/ga4ai
         7Jhw==
X-Forwarded-Encrypted: i=1; AJvYcCX0M2hy55VWE0mcGmEUHgePYA3Ef1PjDv2HQC6xoaNNSYTsVSliMPUmZXp0dLdqnaMXlS+SIjdOv+1BviewESWG@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuGO/7SzjmzwMIOv9Da9ewbPTmWp868gd7afSHmHQyTdzX0yv
	0HyILYYySrQUh3aM0Zv1MU8Ysu4jte1yLHeJbGZ2viIfLhFBWGvBvebVmQkuwy5TUnqaxvXWh9e
	44y03RpSj8Q==
X-Google-Smtp-Source: AGHT+IGbvg38YhDssyfKkYHn/snXNT9UvFEofmzb4xmuUEiykWtfWmAMNadvzY7zVR7Qj4GyH+waQLA+HD0Y
X-Received: from dycns6.prod.google.com ([2002:a05:7300:f786:b0:2a6:a0f0:d7bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f292:b0:2a4:6df3:b95b
 with SMTP id 5a478bee46e88-2a4abb2612emr5957465eec.19.1763500437789; Tue, 18
 Nov 2025 13:13:57 -0800 (PST)
Date: Tue, 18 Nov 2025 13:13:26 -0800
In-Reply-To: <20251118211326.1840989-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251118211326.1840989-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251118211326.1840989-4-irogers@google.com>
Subject: [PATCH v5 3/3] perf stat: Add no-affinity flag
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
index aec93b91fd11..709e4bcea398 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2415,6 +2415,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool affinity = true, affinity_set = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2543,6 +2544,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
+			"don't allow affinity optimizations aimed at reducing IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2600,6 +2603,9 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
+	if (affinity_set)
+		evsel_list->no_affinity = !affinity;
+
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b6df81b8a236..53c8e974de8b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -368,11 +368,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
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
index b4604c3f03d6..c7ba0e0b2219 100644
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
2.52.0.rc1.455.g30608eb744-goog

