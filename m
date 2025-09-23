Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACD2D8DCA
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601184; cv=none; b=DB2NVDX79iZ0IJkesLTXSt8g/CWZz7vkCTkl/P0YO59VBm5I9a4rnSNa6VgCVxuttyIGXEFDC4xuS71AaDWovJAXyPKj1GCP8seZNFK9n/7mDMfheV8iwACJl0psImyj1cbFRrhqawfcSQXktvG6IeCBOpMdv1U5jfK7NamWfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601184; c=relaxed/simple;
	bh=luwZRNv0cwausX9DyzkSxwPPCb+bpc4Fbcw7XNow1CY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HGI/D3xyThJ08v4swmT4JKnWIUyhhcqt7b9e1d25aMyklE8EAbF2b0NfNwQ76CViQXEYBLcJ3MLT68pu4B1kgzNqopDV7VeZrf8dN1jCbTkLnMTAg7P06Zj+y1R5GNYUyGaCh6IUbqwvPNYIMeV2R0AMmCOsVUxD/qX+1x0UCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0mG1B4k; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0mG1B4k"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77e13772b37so3054317b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601181; x=1759205981; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaTTG9m1t55nqlYCplpxcuoDY1QX8geYe7NsmZ1Ka2k=;
        b=J0mG1B4kGtEzPmBltkx55ptflGOAi3ZKEvzvkIuhUFCtl3xsRleg6CrnMxbIvH/LVh
         63WQ5u4Hmdk8xweBlhiorOJEDO0OpvE5MrhyzuSDkEEaycuG/0o5ldem4jftLm/3Ytyj
         8lhQxcEOZRlINdlNQ3wCYe85k5HAHUktbd5Qqe2t6ljzQqvK077lKUFaC8GFWCCYSpAy
         0wAonsgkNTUiyWhQJLomlSPOzyBPkM09Qce0uSQzm1iCKDmm+i7LE0LtxXcJTHL/tBRN
         KoThFLD/8C6i/WbeZeoYtqLfOYpphX4DlruEVLMbMB6umD98/4GvYrdn+kM7ijFW7ouY
         xdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601181; x=1759205981;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaTTG9m1t55nqlYCplpxcuoDY1QX8geYe7NsmZ1Ka2k=;
        b=TrFLVNIV2DnGQCrl08JroTsbE8CS4p3uAuk2c/QtrfEahgBLNE50MRHO0EmJ3uR3yc
         /oYAwugoijO5jJBuL42sIV/x9q7BIqUnqs1pfr1i6e3rMLK8n7jsJ8P9Rsm2YArGm6VD
         eO/J1EZp/xBGKDrI8yqSX5nE9tQ132OrhqHnOuKhlkeAUuEc5UuDQnPpk15T+w/Cq/1Q
         zMN9hge1sJCPCal566P3wuzVBZ7GWHY2Q28EjjkvU6B73ue9nfKANNjmHblcDxl07scc
         /3fEnJjm70XZBE5cP2ETMJ1MOunJSxt7uDQhJE75+iTA5VRBlyby5AI9FSXew7v7Bzs0
         S2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+jt5nlWg6oXiFRLwVvcuYfe/qNANq/DVjWFU6PYbEjOVQqSWGJRxWv9bL/G9/06utQBTm7LzSks+ltr0HBKu@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtRCkFxcMzfxjOrY/0oZ1QFL73HzVA1qZL3fmVhcrX7NpSYNV
	XNm1Qa8J+nI1OjFUlXpxxyd/Mh7DOEEHGZuag6nkxHLInkoQlSQkIgfMUaAR3MF7Y8dlmxxh5aM
	7DC3hfFBvyQ==
X-Google-Smtp-Source: AGHT+IHYlj20vqeSEohxb2vor4OR+20tRstlEetpT7hA32d1j73qpPueIZCh6ZHCax6hgPVse5eSBaKMNOgY
X-Received: from pfll11.prod.google.com ([2002:a05:6a00:158b:b0:77f:352f:809])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e083:b0:263:71ee:51f7
 with SMTP id adf61e73a8af0-2cfdb1f0de5mr2191703637.24.1758601181574; Mon, 22
 Sep 2025 21:19:41 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:43 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-25-irogers@google.com>
Subject: [PATCH v5 24/25] perf stat: Avoid wildcarding PMUs for default events
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
is typically just a core event. To make perf's behavior consistent,
just look up default events with their designated PMU types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 133 +++++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 303628189004..4615aa3f2b7f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1824,6 +1824,38 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+/* Add given software event to evlist without wildcarding. */
+static int parse_software_event(struct evlist *evlist, const char *event,
+				struct parse_events_error *err)
+{
+	char buf[256];
+
+	snprintf(buf, sizeof(buf), "software/%s,name=%s/", event, event);
+	return parse_events(evlist, buf, err);
+}
+
+/* Add legacy hardware/hardware-cache event to evlist for all core PMUs without wildcarding. */
+static int parse_hardware_event(struct evlist *evlist, const char *event,
+				struct parse_events_error *err)
+{
+	char buf[256];
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		int ret;
+
+		if (perf_pmus__num_core_pmus() == 1)
+			snprintf(buf, sizeof(buf), "%s/%s,name=%s/", pmu->name, event, event);
+		else
+			snprintf(buf, sizeof(buf), "%s/%s/", pmu->name, event);
+
+		ret = parse_events(evlist, buf, err);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /*
  * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1947,26 +1979,31 @@ static int add_default_events(void)
 
 	if (!evlist->core.nr_entries && !evsel_list->core.nr_entries) {
 		/* No events so add defaults. */
-		if (target__has_cpu(&target))
-			ret = parse_events(evlist, "cpu-clock", &err);
-		else
-			ret = parse_events(evlist, "task-clock", &err);
-		if (ret)
-			goto out;
-
-		ret = parse_events(evlist,
-				"context-switches,"
-				"cpu-migrations,"
-				"page-faults,"
-				"instructions,"
-				"cycles,"
-				"stalled-cycles-frontend,"
-				"stalled-cycles-backend,"
-				"branches,"
-				"branch-misses",
-				&err);
-		if (ret)
-			goto out;
+		const char *sw_events[] = {
+			target__has_cpu(&target) ? "cpu-clock" : "task-clock",
+			"context-switches",
+			"cpu-migrations",
+			"page-faults",
+		};
+		const char *hw_events[] = {
+			"instructions",
+			"cycles",
+			"stalled-cycles-frontend",
+			"stalled-cycles-backend",
+			"branches",
+			"branch-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(sw_events); i++) {
+			ret = parse_software_event(evlist, sw_events[i], &err);
+			if (ret)
+				goto out;
+		}
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 
 		/*
 		 * Add TopdownL1 metrics if they exist. To minimize
@@ -2008,35 +2045,53 @@ static int add_default_events(void)
 		 * Detailed stats (-d), covering the L1 and last level data
 		 * caches:
 		 */
-		ret = parse_events(evlist,
-				"L1-dcache-loads,"
-				"L1-dcache-load-misses,"
-				"LLC-loads,"
-				"LLC-load-misses",
-				&err);
+		const char *hw_events[] = {
+			"L1-dcache-loads",
+			"L1-dcache-load-misses",
+			"LLC-loads",
+			"LLC-load-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 	}
 	if (!ret && detailed_run >=  2) {
 		/*
 		 * Very detailed stats (-d -d), covering the instruction cache
 		 * and the TLB caches:
 		 */
-		ret = parse_events(evlist,
-				"L1-icache-loads,"
-				"L1-icache-load-misses,"
-				"dTLB-loads,"
-				"dTLB-load-misses,"
-				"iTLB-loads,"
-				"iTLB-load-misses",
-				&err);
+		const char *hw_events[] = {
+			"L1-icache-loads",
+			"L1-icache-load-misses",
+			"dTLB-loads",
+			"dTLB-load-misses",
+			"iTLB-loads",
+			"iTLB-load-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 	}
 	if (!ret && detailed_run >=  3) {
 		/*
 		 * Very, very detailed stats (-d -d -d), adding prefetch events:
 		 */
-		ret = parse_events(evlist,
-				"L1-dcache-prefetches,"
-				"L1-dcache-prefetch-misses",
-				&err);
+		const char *hw_events[] = {
+			"L1-dcache-prefetches",
+			"L1-dcache-prefetch-misses",
+		};
+
+		for (size_t i = 0; i < ARRAY_SIZE(hw_events); i++) {
+			ret = parse_hardware_event(evlist, hw_events[i], &err);
+			if (ret)
+				goto out;
+		}
 	}
 out:
 	if (!ret) {
@@ -2045,7 +2100,7 @@ static int add_default_events(void)
 			 * Make at least one event non-skippable so fatal errors are visible.
 			 * 'cycles' always used to be default and non-skippable, so use that.
 			 */
-			if (strcmp("cycles", evsel__name(evsel)))
+			if (!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
 				evsel->skippable = true;
 		}
 	}
-- 
2.51.0.534.gc79095c0ca-goog

