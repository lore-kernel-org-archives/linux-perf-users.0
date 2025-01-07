Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810111F2C35
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273364; cv=none; b=Kx2LOQdea7qbMki6RZ1NIsAHAv2dfQ2nkIVBZ6A5sWwvR0mJCEAE9wkW1NXHIqe0D6oO+q2Xgo4qEvmNoB17YGKmS8dbE5oKwAge3xQsj094f0MJy8vOeB+7KRrKdIz1iHvMTCVBvVEY9i0IA3h0HqSz/b/t3VKmXyKz9xp2gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273364; c=relaxed/simple;
	bh=3/t2IbEPz4rN8sB6XlwyAEYEFBdFqxnzZyoasEkvKao=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=H/Tj7K4iXMP3a+/RRYdn1ondm7WrKHmczDVh9j7Sk/EiqqhyH6vGrtM+isAvuBh1WA73JWDd8y1hu5NozQFYrQQbBiOJGTnXh+yG6H5EpqnPTV0Jpnlpv7JQLAW8LQPi3d/kY/O5+miUxH/1xbL0vr/O0vEKhAh60zevYV4LyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkklKNO2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkklKNO2"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549e7072fbso6768014276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 10:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736273359; x=1736878159; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsJqu5S2FVCHZY/sqyRxwjspJ6Srprq184fTFcf/+o=;
        b=BkklKNO2+7imfXW7x75Na3+4o5Q+fkR+8vbyaKHtMy3v4glKowR3IX9zNchNngf9s3
         0Fsz9Tvs9MzsOx6EENwJN8zxbmdg1axZ9ATjaWK/LMOkK/1iwu6e00HZXfFSRAxkuSLp
         HhYr+HVRaDJT8RYrOxZzAfLBdnoHriHe6OIXStwaN0/pwGsxj5+PO8Z8S93n7SmGHOuJ
         h4L8SJbaHn42aHMTNALiDC3zPvBnZl+/A2hiSu7Ml609A/1ghQtoKL1CDVZNxHMbDhDZ
         Bef7ncLJ8A+8wN3gXY9KJChfJ8OZIPcvvudFxQqqLHb66ZHIao2Ox9BaLi13WIcO3yco
         CNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273359; x=1736878159;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsJqu5S2FVCHZY/sqyRxwjspJ6Srprq184fTFcf/+o=;
        b=n+fowZsZTV5NZEOHhyiVXQ72+wc3+J/Izzx8gZh7S5hJhCkYLvfhkLZGBEHR1vB7mc
         IMPJjqOmY+o/JoCx7YFtykyNjirESx2TraP6wfT0JQOxZ9w25Jxu7G5AteH7v33i7Y1s
         KUaiI1StMsG/G2zG2gMh+Tv0eDAgLMHXcnqeFQ2HIplbhfo40Ms+IxwUoWu39VEBlqE6
         Mozc4nrXP1O95FJpz+NO+uLz3QJCP507k+8EOkRp99gsybim3gysAvhrdQQigtS+kjeH
         8529TFNxhcvZR0Zyj2ayC1n4hcih/3sZ2PEgeoHsG1nKo/lhOLhqOZsdOr3t+KlTbS4V
         70Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXhkNEw3S8lkoID2mGbw7Inqjx/jg/zk2ZV1qu5pH+hRKH/RbselqrcGUtdmkDhMXeK4acAn8GOTIPEH6ZNRn1F@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzV9I2mcLMrY8SsXsnDjH4zPmu1BaOrJa7pbF4FsagK1N5muO
	iSdWbjZgnvIpw+bx6EyKCYq8q7+6Kw237AvndfxUN1GRacsO6JeTt+w6LRMOaAavM1ELCQiFcO1
	o4gteQw==
X-Google-Smtp-Source: AGHT+IEXuCh6QcRMzYXeb67JLDoqi6EvpTvf4F+FY3EUZs8ddIo2R7QzCJ0n0HLdN2toAHdcS4AmbdyhLcXw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a05:690c:6605:b0:6ef:3402:f56b with SMTP
 id 00721157ae682-6f3f80df0c6mr2573127b3.1.1736273359442; Tue, 07 Jan 2025
 10:09:19 -0800 (PST)
Date: Tue,  7 Jan 2025 10:08:52 -0800
In-Reply-To: <20250107180854.770470-1-irogers@google.com>
Message-Id: <20250107180854.770470-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107180854.770470-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 2/4] perf stat: Fix find_stat for mixed legacy/non-legacy events
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

