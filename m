Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC0311943
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666809; cv=none; b=qFMNFHyEO/my07vsgZUw5/ND8fQBsP5497YHNJ3px3uMGSxCeO74jOBlde2X7PxK/HotkztVkaBD9DhUJgTOjj4y6hC7/RTCI/ytdzfOSszOhSMspVZaTlRsQR4fGq8k7tcBPXXIcFfVPG/EH6HLMVOqfd0GIctmQiwBgOgBAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666809; c=relaxed/simple;
	bh=luwZRNv0cwausX9DyzkSxwPPCb+bpc4Fbcw7XNow1CY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TH9fyGTNK+HZHfGM429WtDfnbDK9zLzd0Jm4/tTLYL1mraatMEEG9+cO5VvIU4R8FkV92S3cpOzoAzPibSYQlXZ2ERic3rIYAoHOk/ayBcLToei+Vc9NMMuuDrrlJFBv2DTxSBxlmtH/XMGYDlOmSkaTQmKztDsRoWxnUjw5h8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhuBckXZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhuBckXZ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-745c3f7e569so25344467b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666806; x=1759271606; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaTTG9m1t55nqlYCplpxcuoDY1QX8geYe7NsmZ1Ka2k=;
        b=QhuBckXZ6jsLAnzyRhPVr4jBaudlemP+i3XA4shJd6ijAUHc8kmxRCKe9aBlKKDngs
         fwy/CYYCAZaitrUvO0T5Qs6oMMkCJfRZ3zdj1CbQBqTuNnRuppUHjGU2FCO2Afum3gG+
         9rfdYQPa/XMGMCOIXZhMsiOTBcFNfUhgaFYt37eW3K2r19kRv7P4FdCwyaMCroIkYVZG
         Ct50xfTN+CJle/ZBFshgGPFyzXnbgbs2byE4WvtLkzuMmMr9t8TfZFCol+LXO5ny4HcG
         tv+I5i+Px3GsWlZizT1n3UX2H74IuJhYS1Wg+V4+Fpu734LYFAzWLGnACXBrQ3vgtkmx
         pwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666806; x=1759271606;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaTTG9m1t55nqlYCplpxcuoDY1QX8geYe7NsmZ1Ka2k=;
        b=YktPm6/uWO8Dgx5wfy7Cnl1brFsTnx9MnWRLWWnTbDS0Ix979hrgsYGLJXMdcXkaAZ
         0bo0/taWeXktgxjyTtalIVr3qTYQ1BNYirraSp4P8gXZ20wBSfEIHUBqX/S3nP61VmB6
         cMrENZ4HPCEj2qKVmi0SJa/2Hq0B77J2lmxcXw8yjalxCfaRmQVZWQAZQdc+xEv1sitw
         ZrBtgz9V9XKnLQH954+/58hL34bfYuHTSGdG5t1xpzAih0C1/Rxeakz6qbdYU9J0FmiA
         PCo3rtXf23sESJaNFm6sG41llhuE1tq9PZiYKN+951kxgFHauJSZIi8pO+UKVDIuplbn
         QTtg==
X-Forwarded-Encrypted: i=1; AJvYcCVFiiA8Jo5gNcBKsX6lsWGihVdew1loFYFpveOu+lkUl0eYAdmkSr9OdiROcRwFiPUc5rkvSTF5BW5C4WW/KzAN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+r7x/f6nynyi7z65ACAQSY2g/bBXV7r37DaIIb00TIZl7cvA
	FurwkT/hfDt0qM10uzUYjkSQfX3DuY9M2JAsvslPp8oObgRJLqW2boaQ7oxrOvSKQ6Pg0wTHW47
	sldEWDMsiyg==
X-Google-Smtp-Source: AGHT+IGT/OjsNEc+PfAToaXyOncv+i3ZDoGYd6AiDK9uBHLi3ylvmi2/SIs+cgAeL3Op1AtEdKXniSfKcxfw
X-Received: from ywbfq7.prod.google.com ([2002:a05:690c:3507:b0:732:fd98:aeb8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6d02:b0:737:523a:f7fe
 with SMTP id 00721157ae682-758a5f1f525mr38007387b3.39.1758666806158; Tue, 23
 Sep 2025 15:33:26 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:48 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-5-irogers@google.com>
Subject: [PATCH v6 04/28] perf stat: Avoid wildcarding PMUs for default events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
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

