Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C335C1B3
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057165; cv=none; b=UQBmnz7NDZhrJIuNCA4uhZNa4cKQBixhnrMiihBqye6mdsIxCqnmio8sG46pIr6vqOMDgVP/+DUzJiJbAxopJPkgYhRam9BsG1kmhlMv8X3nZBSaPHn20R6lcpFUpIoc6/2656XxrzmxFgQXl7pNEh1M7AFR4Dov3AKWe+ivQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057165; c=relaxed/simple;
	bh=tALcLrqXxNWDiOpY9UQxmoxjIfX4GTtZdrGYQN1kydo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EP1bAWQp3H44SKJpRl40gLivxIPh6F9Lhvo8s/b+PmPVkt47eOj15D0qi9CXv7eVPIzd5AU5W2axPzaWItHu0dawe3i6d4PqtMlqnJi21LC6aAqeJBHZIP+lZvq177d278Gt2eyUvvTrHqZGzGtX2c+oWJMIf0QcITbz2khLhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f73j4WWj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f73j4WWj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so946423a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057163; x=1763661963; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7BQwoR1zRfcoaLIGWF72ww+QsUvGUWtVBokWi10jMg=;
        b=f73j4WWjrPvEVlONYUvSWSQRw3RsgYoigEV/GkwY1Zkq6Q/zpdwV9+qeyDHeHG8D7j
         JimYgtUXrg0QULPfTySrhskygeoknfdE1bWLE0B+FBac5jHZbldFQ9zGjmBMqn+nXxl9
         7ftqlFqHaPnhGbEHiqXSQgEe3DAaSd2A2aIexAzivMICXx34jnvjO3Jo3lZxvs09UO8d
         1SmnGCrMIAO6OxGjus1xli5mZXdZOve6xtsIWX4y+1vsEbH4q1sjJKGgVtsO5bncR/MW
         UNsvn64p2fymXC9v6rGg0vL64gye2mdsAm3hOAu6sQVmznbh/YIkJM0aSR0QJFzhHd/J
         DZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057163; x=1763661963;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7BQwoR1zRfcoaLIGWF72ww+QsUvGUWtVBokWi10jMg=;
        b=lCV0JgIm0gPus30FPmOOV0bN/tmGozYeWs5oVKRoV1234HBEfhWmKF7Zfw/bv1+bKJ
         /R+/BoE6D3rc59fhNMnublqJfMBsGFgaVHqGSDv2R0y2epw3iu5vds3aA6S7QZkdqsmu
         wY5Lugtgk7vJygYDN87oYbMOZPq0Vz/05MojoRCthSzNEQJkyCYLBrM6uO64GQSZaZGd
         cPE9VSqz5JtyGRTAavECfFP4966Xu47XDkSjViztbmB5Yd9YarYltnMnltEGfS5V7hEO
         2q45ZGq9YCkotlWLF/QBNkis/uofxOGHqzzZLXysloQDHkrj2qELQUJK494d1eqtMipm
         oGow==
X-Forwarded-Encrypted: i=1; AJvYcCWoinEMf6FBa2PxZ/7G87ViPDWLv8VbSosMf695hjTKYhSTkXn5FKlWBXHuzjcWondOWVnF80y9c4Wr43K/ld9w@vger.kernel.org
X-Gm-Message-State: AOJu0YwmI3u8sTP1VokLVoVDgdrQTBULv8yr0aqWin6fg5Ynfg970irg
	cyK6CKOZFbdHhXxWyLMMqxQ4DfcBxmPtOnmpr/dBBFvBHlacBLKeZBZG2heNB2Tq1tuXZJ4h/Zb
	35c8k/LWu6g==
X-Google-Smtp-Source: AGHT+IE9ZNy2sDxlTj1psbp9B5u18SqT2MXKmQHk6xCZfp+KcS9kKNFdokFtVB9rtsA+pzTjYkPKn+0YDXn9
X-Received: from dlbrp11.prod.google.com ([2002:a05:7022:160b:b0:119:78ff:fe11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:d41:b0:119:e56b:91e2
 with SMTP id a92af1059eb24-11b411f0923mr82675c88.19.1763057163085; Thu, 13
 Nov 2025 10:06:03 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:16 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-11-irogers@google.com>
Subject: [PATCH v4 10/10] perf stat: Add no-affinity flag
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
 tools/perf/util/evlist.c               | 2 +-
 tools/perf/util/evlist.h               | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

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
index aec93b91fd11..fa42b08bd1df 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2415,6 +2415,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool no_affinity = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2543,6 +2544,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN(0, "no-affinity", &no_affinity,
+			"don't allow affinity optimizations aimed at reducing IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2600,6 +2603,9 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
+	if (no_affinity)
+		evsel_list->no_affinity = true;
+
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fc3dae7cdfca..53c8e974de8b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -368,7 +368,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
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
2.51.2.1041.gc1ab5b90ca-goog

