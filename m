Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469D2D97AF
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601186; cv=none; b=J+FDJRKEoS/x1aT9DKG53bm+kyRigee2iCMgcBtP8iTm1T0EymN/X184j0pDNeDf70uJ1CBaQBPrQQBEqWLTyBS9bT3MZVLfmhVbvzZlNyTKJQjhXxxdlFf9QtLmpwe23DDrAMkXj/ktE9gE0HcxNEJzslLVImhS9JNKLYp2dxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601186; c=relaxed/simple;
	bh=6bAtb38zV9J/DL1V7CMqXHrxyyDh/espMrQBxm4h/pM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dPRzvOvZ9GNWnxhAZp6Pr1LzT/KkAUa2mJNhK7nu0hOaHG5qmQe/sSNabTpErWORNbJFvVztnC43stim66YwJWuiVDU6ayvjHfLXS97qSNM6QUZJ5TWKZBd3ZBeAWJvcOGJEkZ7YxFl6TOTWmoYw2te5+r6IfCyoQ5JK3XC/V5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36FS5Acn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36FS5Acn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so5131334a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601183; x=1759205983; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GD6dJGQu7Fkw7LxMA7kNIP84YIqKTjc1I229dIn5uGU=;
        b=36FS5Acnpak+ApAf2uOEbtAQaaRNjcsNdJ3vCBeYUhL9BRofJf4kNgt8NpMpA/FTW4
         bt1Pvv/Ffvl+vZny1eHhwCBQM6K9kTsXqyEFV2pe/8J3NGtXJFGH761+s84At2OPGwIr
         YbXK10UZS2HiLB4KIQJvj8Gaene/A9FmoD/M3hGmOoDiUiSqlbE1NmyXba1NvzlQtm3v
         0wp77JOhRqkPx4ARhDT7cg7TXOmBkQ5+VmVv4xdr4+UBY4At1ILhdqoKJmI1g9u9XTZw
         4DCjTUAh/YQQG4oxYqtQofSuCvLhjiklCF86FFDh7Rl8tLRli/3KCB3sR3fTQClNk2cz
         kQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601183; x=1759205983;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GD6dJGQu7Fkw7LxMA7kNIP84YIqKTjc1I229dIn5uGU=;
        b=Hi4bHDWnSzgTObIp0UyGERyWAX4/PEnyMEHzl9yc3vS2sS2HWDJ+hbO0oaTsdIkgU7
         +yHs38krWwL8f6hIJt7gmW4H6ia2jxk5X2yRlYAIVbp/iucporgRuN+cx0qb0w6zW96F
         SA8NM8Out7t4mdtgGCmKcVS1eSLl6bD12UNv+lJOgJebcWLrDEu6K9drXXyfQaMSbgfa
         35N1+aopR59i67PgWfKw6vm+cYC8DeqtI7i19m1xhGDI1nxtVRAUmlqYsynCVSHzde46
         Zd/mUNVxxr+AivVJM3EjV1ibAsOD1uOxhumycqT5Idw8Nf/KTh8h6yraDpcK93SWHjX1
         TTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwKjk6U6J9+BvR65tqzL/Zg/oKJ0O/o6iExR1dFa2v24bgF/iOy2IwihOgTH+K/PhryS+xqevuhUoLHg1/DkP9@vger.kernel.org
X-Gm-Message-State: AOJu0YxAuLeYzxEr2t0i0k4VJoqnVA6rqExXVi7wGSOO1J9bxF4O7TyF
	Ql/+1XlvUWBQ63VU53AkNva6RFX8DjjmqChtNh8UU7skbuDjalzRnRvVSyOyvGQpZ4z3hi06hRU
	iorJCeRRf6w==
X-Google-Smtp-Source: AGHT+IHEz625DgPgfCvdS8u12wp6hVm4KSQDVZQWJmPvAmlYj3P+j8YaXSnCyG6O61FyddtdSZfdsEtSQ9iC
X-Received: from pjbmf6.prod.google.com ([2002:a17:90b:1846:b0:32e:bd90:3e11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8b:b0:32b:656f:5a5d
 with SMTP id 98e67ed59e1d1-332a95e4d90mr1628708a91.29.1758601183502; Mon, 22
 Sep 2025 21:19:43 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:44 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-26-irogers@google.com>
Subject: [PATCH v5 25/25] perf test: Switch cycles event to cpu-cycles
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Without a PMU perf matches an event against any PMU with the
event. Unfortunately some PMU drivers advertise a "cycles" event which
is typically just a core event. As tests assume a core event, switch
to use "cpu-cycles" that avoids the overloaded "cycles" event on
troublesome PMUs and is so far not overloaded. Note, on x86 this
changes a legacy event into a sysfs one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c     | 2 +-
 tools/perf/tests/keep-tracking.c    | 2 +-
 tools/perf/tests/perf-time-to-tsc.c | 4 ++--
 tools/perf/tests/switch-tracking.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9c2091310191..4574a7e528ec 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -649,7 +649,7 @@ static int do_test_code_reading(bool try_kcore)
 	struct map *map;
 	bool have_vmlinux, have_kcore;
 	struct dso *dso;
-	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
+	const char *events[] = { "cpu-cycles", "cpu-cycles:u", "cpu-clock", "cpu-clock:u", NULL };
 	int evidx = 0;
 	struct perf_env host_env;
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index eafb49eb0b56..729cc9cc1cb7 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	CHECK__(parse_event(evlist, "dummy:u"));
-	CHECK__(parse_event(evlist, "cycles:u"));
+	CHECK__(parse_event(evlist, "cpu-cycles:u"));
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d4437410c99f..cca41bd37ae3 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -101,11 +101,11 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_event(evlist, "cycles:u"));
+	CHECK__(parse_event(evlist, "cpu-cycles:u"));
 
 	evlist__config(evlist, &opts, NULL);
 
-	/* For hybrid "cycles:u", it creates two events */
+	/* For hybrid "cpu-cycles:u", it creates two events */
 	evlist__for_each_entry(evlist, evsel) {
 		evsel->core.attr.comm = 1;
 		evsel->core.attr.disabled = 1;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5be294014d3b..15791fcb76b2 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist,
 static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	const char *sched_switch = "sched:sched_switch";
-	const char *cycles = "cycles:u";
+	const char *cycles = "cpu-cycles:u";
 	struct switch_tracking switch_tracking = { .tids = NULL, };
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
-- 
2.51.0.534.gc79095c0ca-goog

