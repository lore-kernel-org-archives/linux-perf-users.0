Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA8205ABD
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461289; cv=none; b=u782U3trDhcZdYKOp1WGpU0LG7poWUuFrg4HXE2ucrN8+779A92vYMAKOThsXfepOhmefUC7D42mNyK45CtvQppHI0nrmEohhdxBztwoT91+8oYOxxQAIZ3IToyAIVblFPgzLp50f0douIAx2a81sn2fRVP5kDBwmZPjp+hEO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461289; c=relaxed/simple;
	bh=3/t2IbEPz4rN8sB6XlwyAEYEFBdFqxnzZyoasEkvKao=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=MsB/Mp6U2Td6EIrQ/6dT2nzH73UAUSAW4Ntkruit5ZMPmK7/BKqD+C3aHdlbPn/bjmhUnclNOqvgyfCUhPcsuoM0EKd1Lq4h+AaS7mrlouhcevNsZccehGRUfCCpBW8ujq+Vn0bJRyOTnVW0My0HNJveEFQf5Njn/An5GvCS9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSTAHjDW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSTAHjDW"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e450e8637cfso3449224276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 14:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736461286; x=1737066086; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsJqu5S2FVCHZY/sqyRxwjspJ6Srprq184fTFcf/+o=;
        b=JSTAHjDWhoZLKmHIJz2+S89SM72knykF2CFWf2ClaauyJHLeA5ZikUG19K8yXG1O08
         8emeb0Eu0Jtck84vilZUSUZ9+LNTOAr3gt9h0qt5bfi66/KLoHoxwykXvJvPZoR2FhrD
         zUMYSQxUnyKgUAePDo+tTSNlkfLIaWdLPjC1fr/3en1Pun3j1FS3ZbuRB6F2YfPjiA1z
         kyeUJn/zNWJj/NKUDyr9xJqO11Q2SaUcTuszCgoOwretPQTLm4ZxrswQpgqXR8293Ssa
         azQESFG/c/itTnOpcY6ArafYjI7o51NLL44o/6FYqkYLyILGUtQSkAiTqTCk3iSOt37c
         aITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736461286; x=1737066086;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsJqu5S2FVCHZY/sqyRxwjspJ6Srprq184fTFcf/+o=;
        b=PgOf1oNQOPuijqykpYheAEBIh/GqBOO0HbBal3CGpEZkiqTgGCzuiOvCH7KEqpD2Vt
         o4XCvnLmAxjC7L8jzGk0CwEqw+0zwcXwUTeD4/Xt9B/DMoNhlktuBc0ZiHXneBJ5PEO3
         AlnIWGBaSSgIG95zEbeDXGFthUQ6k0oc9L7Bmi6HpXEJWQuTD03mjN8ntKTxbTJpnpZk
         OQzW1sNIFlTvGYFucRHFoBasW6McZd7MBTiay1nEwnl7EY4nKWKUUKj0IxI05TIiPkKG
         2KjtXoLTf7HRXT7+ZC5QZumgtj0suZy0oW0Q+22+1rFCKewGYUTMRMfnvQXXt5MOvu6V
         Zduw==
X-Forwarded-Encrypted: i=1; AJvYcCXMaiOQ/cgmzgWKOYPVN0RN33jUhzSFviCjAG4uQYJQW075N2nmjjLV5VbFMYDGyhbbAZpw5odtoW4YFUWAJ2ww@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9kHGSn0wgKQL5SRO5FusErLP9AstjgUl/EOeSUWL43PxyV38b
	8V7lbY/1wdxtXhq/yjGXC/oMMyH7KPtDNTKXA1Xw+gd6hObO7fb+s1iJjEPjQWyCTIHkUPHSVdH
	dQ1tEpg==
X-Google-Smtp-Source: AGHT+IEXohZUiNGulGWYxxa9jPStItqRL+DLtO3nSjOZouCsxMSz7OlT/0B4kAaPv8IwLIzy5bxqbbNnO+TI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a81:b3c5:0:b0:6f0:21d6:44a2 with SMTP id
 00721157ae682-6f5312034e3mr265957b3.1.1736461286468; Thu, 09 Jan 2025
 14:21:26 -0800 (PST)
Date: Thu,  9 Jan 2025 14:21:07 -0800
In-Reply-To: <20250109222109.567031-1-irogers@google.com>
Message-Id: <20250109222109.567031-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 2/4] perf stat: Fix find_stat for mixed legacy/non-legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Legacy events typically don't have a PMU when added leading to
mismatched legacy/non-legacy cases in find_stat. Use evsel__find_pmu
to make sure the evsel PMU is looked up. Update the evsel__find_pmu
code to look for the PMU using the extended config type or, for legacy
hardware/hw_cache events on non-hybrid systems, just use the core PMU.

Before:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1
 Performance counter stats for 'system wide':

       215,309,764      cycles
        44,326,491      cpu/instructions/

       1.002555314 seconds time elapsed
```
After:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1

 Performance counter stats for 'system wide':

       990,676,332      cycles
     1,235,762,487      cpu/instructions/                #    1.25  insn per cycle

       1.002667198 seconds time elapsed
```

Fixes: 3612ca8e2935 ("perf stat: Fix the hard-coded metrics
calculation on the hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/util/pmus.c        | 20 +++++++++++++++++---
 tools/perf/util/stat-shadow.c |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b493da0d22ef..60d81d69503e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -710,11 +710,25 @@ char *perf_pmus__default_pmu_name(void)
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
+	bool legacy_core_type;
 
-	if (!pmu) {
-		pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		((struct evsel *)evsel)->pmu = pmu;
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+	legacy_core_type =
+		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
+		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
+	if (!pmu && legacy_core_type) {
+		if (perf_pmus__supports_extended_type()) {
+			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+
+			pmu = perf_pmus__find_by_type(type);
+		} else {
+			pmu = perf_pmus__find_core_pmu();
+		}
 	}
+	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index fa8b2a1048ff..d83bda5824d2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -151,6 +151,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 {
 	struct evsel *cur;
 	int evsel_ctx = evsel_context(evsel);
+	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
 
 	evlist__for_each_entry(evsel->evlist, cur) {
 		struct perf_stat_aggr *aggr;
@@ -177,7 +178,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		 * Except the SW CLOCK events,
 		 * ignore if not the PMU we're looking for.
 		 */
-		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+		if ((type != STAT_NSECS) && (evsel_pmu != evsel__find_pmu(cur)))
 			continue;
 
 		aggr = &cur->stats->aggr[aggr_idx];
-- 
2.47.1.613.gc27f4b7a9f-goog

