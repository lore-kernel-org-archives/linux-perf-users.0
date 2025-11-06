Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053132EE617
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413184; cv=none; b=Gl36FaML1/1nmoT7iQoRfT0JBSpImhzdv6OBxw3xoHlRKf33j8kz/WbJNFC6l5Qm5//sWT5YGRqfZcogqRZrORxY8Ym+bQrFc6NAqgodgcAEi/1CZwMjy7zDKYAimD/D1533WkOEmfu8JH3voAV1UQnDVZVDFt7ndY2BSXxp+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413184; c=relaxed/simple;
	bh=baW/PP9vuOXOepoc3ZzKNVeVqn+YVFSWu3Wdb3YH+qI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=efTF55ycswGTox0sdvigmbvuGTW3GsQJynKFvsTYgf+lFPdG7jkp5KIDHI/f6S0rDSr+DO+fEqZ8g2RiTJ15IdYtHP8aZu3egJTt23Qvxkwg5/rHHXiOQh6TQtlaW4BGjKa+C/Qm/IYQLt28W6m715KbPjNeCQkDm3RmbgDaaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jp41COIl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp41COIl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9ceccbd7e8so118657a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413182; x=1763017982; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9ZhWJR/a4jUzE3S599HAQn9Ex0tBJc68Cyk87AziX0=;
        b=jp41COIl3kshd8F54ki0AIAlhzfrPWu+a82JLFbTtanQYzf3w2GwDWbmgw58zdtO+c
         lVp2ALCQv0qEPuydZ9UU9wr6eO2sbiB8SUzfhs9ZDpDr8eYBpyQcwCxDqqQrsJ9rJI6x
         S8sRlawflEhk0hBXpGNsYUUGLq098Mz8WTYdojD6bLzLphz3DPFaiE/7qOm10AtWIPEj
         08SKLuEQDJBuj/CyGHLSwzHMISqb8KaqTvj9Xvde88d3Jnt+aXRKTDoShNY3+lsZqzTw
         L4uuAiAVItluCXHzSC/o3XzWNWLzOG0w3nnZOrv/9gtsvR30CdgW8fDXMO8//f9VSHyU
         yHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413182; x=1763017982;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9ZhWJR/a4jUzE3S599HAQn9Ex0tBJc68Cyk87AziX0=;
        b=FmfI1Sbu2JkQcPfXUu4LP3RVQNj2H4tE8GzAT1XBEq6dit9A+qz4YFXm9EpmflH2nB
         4kEV1hx/OAAZpp7S4lhrxXEcDEk83maMVK+9ufzh97c2AFk3z4F+2fdpkEiyS/eILKam
         oqMdnTCJY7AdIMJemyIEpjCmk68aBSURz4Q7Q/6LDFzKdX8TNmVGuuUdW2K/U7v3/qEg
         1vwTPqPsR0mXyoh7VguzdEfRvCbjklihyvTvoINx524RG/crztR+8its2sarGyuASOIW
         YfJOrDZmJeVOZc4OO5URw2QAtFnf81UEtQwveaYpjlKOx3kdJSdGeoM3LR7zKZBPRe9v
         uUdA==
X-Forwarded-Encrypted: i=1; AJvYcCV0JHXNY3/dRDrCnVHp8OEgMKgT1TJ5+SUuOvO3WDjGK1x967IeLgPQ/rZX0JvUICym7NdKwirtiBx63JtcFiem@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaj6XYbnTNBE6xbYkdPYAhLHAufsRZrZoSa/ssNIT9n6g1968s
	NW9WxsH6+KTZKcCLevvH9zrpmPit0dXhXD4TOJEgDkQ/ytjP2b0K1E91auHOulCnm5bm7UOjcjr
	afMILLLK1KA==
X-Google-Smtp-Source: AGHT+IE226Se0eAuwakSfAwq7yVrK/hma19wGPnIC5iTTdwVG+sTf6vfeyZ6rqw5EP3YtKPbdGB+kq+zuvoc
X-Received: from dlbrs16.prod.google.com ([2002:a05:7022:f690:b0:119:49ca:6b95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c3:b0:341:6d44:dfd5
 with SMTP id adf61e73a8af0-34f8580ad59mr8097329637.33.1762413182363; Wed, 05
 Nov 2025 23:13:02 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:40 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-10-irogers@google.com>
Subject: [PATCH v3 9/9] perf stat: Add no-affinity flag
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
index 75ff08c5f0ed..f2f149f0c2cf 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2479,6 +2479,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool no_affinity = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2607,6 +2608,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN(0, "no-affinity", &no_affinity,
+			"don't allow affinity optimizations aimed at reducing IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2664,6 +2667,9 @@ int cmd_stat(int argc, const char **argv)
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

