Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F52DF15D
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874553; cv=none; b=DaJgdliyi0Lh5IlmHASSjTKNdeGNYbTtdQINWs/RgZ/2t0tZNaj89w8M92PBmQ0mBNvSwFj0FsOJmZWkIfnyGb1Q3CzlAj0K3SiXPO9CjpLaHFDcvTmUQ0gT7kknbvGlNy2kNdDPKgHMgRGu1Vty5fQLLPy7AMxg2auKyZmoMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874553; c=relaxed/simple;
	bh=kHCFkoShNUOlHMlQ879xfha1TjDoflpSxnCnwqm/tOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YwKauuZm5vMIWTftGnsJi6kb0dlN029OGpUyXECqMUCwhdZEF0GZYIcg+LxXVlFL8Lkck3SF4URAzYXA3BB7dvkQ0wbgNPa2ftM8eGrc8Ani4qFAQvgTecCEcYhOIJYzn2orqNp2FYQplVITNR9hNJ0BvvCOW6cLcMtQKslsm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxWnHjna; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxWnHjna"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32deaafeb5bso4013392a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874551; x=1758479351; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALDUZA03/UTXBYu9euaSzX+Yf6hYZQnIYDNKkWvFhVE=;
        b=DxWnHjnaldwzNC2iTQVPj0qJMXHvzx0RXgxVdP3nWfdIA1ULVPDoE+wjzHbZ/C+ctK
         PFX/h0xWAaWkq0IH5rx/VG4hmceHE8+ccjEdWn+brvjHmdcinZpiXWVp6aB2kTyhp2Yc
         LK9cHlJUmwHwbP29vi8Id77FY6A9aWZfef6652a4Gx01jHkHhZss2pS5NXezR5V0NWMa
         iVhboCF6Bd1SVwpY8uGPwSPEfGBy+kgJvJiPVllL+cxgmdETjp9xiMFnt3ucjnTeuMgv
         F5K7FAZf4TTF8/5BH+3qQfoVLmhgRMv90VGKqMuwbLScDJRcaHJhGmxW290FR2JDR23u
         81fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874551; x=1758479351;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALDUZA03/UTXBYu9euaSzX+Yf6hYZQnIYDNKkWvFhVE=;
        b=NP7BiCY1AGRmqJ9KiFgcOaABz4q2fxzTwlDt5dFGmMgMc88eEaN8qAQXNkopSJrJPK
         E+A6QdnYWT2OVTEFNtQ8zXb0wb5vl300xF4o++ria9JisX84LHBWcXV80/gaXvwEKanx
         w3FifNQbxsP6aTBXFpytrGFW/Vc8oowu016Xbn1+lcP+b31/2XAVXz16CdEsnn9kdja0
         vzExXy0jfvra2zGbgL8taMd0Bq9xKCjYAnCzqNOrv91ijCSyWPa7eKO0nEaA+sWzHOIT
         L5ocCpcwuq82Xh5Y3uoENBUkpXoV+Fat/b08PxcW6mkk0O1IoPucGneDXFLG9obhQtUD
         2LxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz1XxdRnh4cpmM65AaXenb3p/jCB7L/qcNkw0F9ZQgIzTtlV4OmZiTMQiQSjsJl9CDBleee7Dbu5btn3m4HmQh@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJRKgOOojWOTF0Ec8LkPBIu3gSPz5S7Edcxx2pD6SSnLYICR+
	m2efJ+SGbc6sDvUivYb0yYFQiYXPbO1khRN+6tRE2zPcb8hoZiwBfjOEW0ulwi35WNNqpQoLuC2
	+FZz2f/W35A==
X-Google-Smtp-Source: AGHT+IFd71ZjRBakGhbafgnPTzrixccPSZLeSg9hHh43AJijBVxQ6iVQT+Cq9+9/FUnZC5J4hMdzOxh4UJP/
X-Received: from pjtu3.prod.google.com ([2002:a17:90a:c883:b0:32e:6111:40ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1648:b0:32d:d714:b3d9
 with SMTP id 98e67ed59e1d1-32de4f9be8dmr11359334a91.31.1757874551179; Sun, 14
 Sep 2025 11:29:11 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:29:00 -0700
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf stat-shadow: Display metric-only for 0 counters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

0 counters may occur in hypervisor settings but metric-only output is
always expected. This resolves an issue in the "perf stat STD output
linter" test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c |  3 +++
 tools/perf/util/stat-shadow.c  | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a67b991f4e81..8a72e019e6c7 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -944,6 +944,9 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	if (verbose == 0 && counter->skippable && !counter->supported)
 		return true;
 
+	/* Metric only counts won't be displayed but the metric wants to be computed. */
+	if (config->metric_only)
+		return false;
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..dd3a15b17eb9 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -320,13 +320,10 @@ static void print_instructions(struct perf_stat_config *config,
 	double max_stalled = max(find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_FRONT),
 				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
 
-	if (cycles) {
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
-			     "insn per cycle", instructions / cycles);
-	} else {
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
-			     "insn per cycle", 0);
-	}
+        print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
+                     "insn per cycle",
+                     fpclassify(cycles) == FP_ZERO ? 0 : instructions / cycles);
+
 	if (max_stalled && instructions) {
 		if (out->new_line)
 			out->new_line(config, ctxp);
-- 
2.51.0.384.g4c02a37b29-goog

