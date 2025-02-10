Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4D257ADD
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212702; cv=none; b=CmrP6ylE8xd0qZNHi3fbnGHuZ3SUnnzmEGgtrdHA45LohwGrKhZRU775BDHqU+MJANmLTbhS2iX6ulpWhSqlBQeORFHWIPUcJ+fOtBQ7AmJ0HRtcLkCRCNYT6PqxNncCmIq5LI3DVtAO/F7xKJS3DYHwb/843zdRLE9OOtkJdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212702; c=relaxed/simple;
	bh=vzR5dnuhJdQwnCFop8Hjt6OgqVnfdAEzGZEHKRU9r3Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lAN0/Ntz9W+wtiHDKBahHgRByTZabjvjKOsj8m03EWCSzxHrt9X1upaluF6POq5rIGj8dBZwQHTSFVditn+BOG+BlPSUJo5LS+K6Tj3FC8gArcg29I9tYvVsNlBp6iNcOFtocPIbr4+5iBXbSglyx0DZqvsN9Z+1EFd6aSCHtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WQxRp8g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WQxRp8g"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2b386136aso69262617b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739212699; x=1739817499; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zE/xALH3ZlNnHvoxZ6fWkHxnSbY7yQ3Nej5cU7cHGVE=;
        b=3WQxRp8gevlCvYKOymSsVKUYMnndo4BS3U2J40lOvEDTNOJfmBVT/1ErM5jxg0lpSs
         7cVBFcdXFTHyMihSMI5FU23NJV/7/oG41xYnUbdQPHjJq0Ycp0berdMJvmsvmHZxW4fw
         cPpbA5LLhNepDuuv8qNowJawMJ39p6gGeBOBx3t9PUBYrMPrc1jdUlxYH43p8rLnNPK8
         LhuDPou8+lBWyWf/MaXd0epO16Hk7rJ7Sh3m06JKVBasn44bj17icfOz3Bw2ykXHqgXi
         tX+EVK/AOLq9Lnj+N5objzL555aKDbeDcSabcCSguL8xTzOd3Z3WpWyA1oCPs3jPEZiv
         njDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212699; x=1739817499;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zE/xALH3ZlNnHvoxZ6fWkHxnSbY7yQ3Nej5cU7cHGVE=;
        b=nlpaKSEVaXX9axHrM5zPtkhtGgylyDAQxIhY8nfhbSX58O1ikJPqpXwziFAV2iVivP
         Nwz4Y2CBLr/3Tn1wT9E9C1Yi8vwCFQHQJRHajv8yjFQQ/w3V5+RLOAd1LbVQEhQETI43
         SJtaLTxSzPWAkZYCbicHyQB7OnjZlJAebkez4JxzFczX2GAv4jw407/nf5RxXpDkNGEM
         zquB/EgXOdulywQ8HueutBX9uHjA0owh6vpcax20KvFG6t34jo39FJ40q2JtWH/nlY9L
         EzyagcQReBigKPUiMsFnocrUIaNmhGl/9mn4wZ0IXjI+azs6/zg3wWFz8V652Tj8/8sf
         wq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU02vU9Pk7lb9d1WMlpcAltAUFnwPCfC7lw9x9qJJUHW5YLm9PyXZ2dv1X8PJDBEI1wGs3vBJz/Vhv3TL9HNzEd@vger.kernel.org
X-Gm-Message-State: AOJu0YzuagoIjfS4jjPgQH6b2vYc/fxT6aldK5vso5i866yqJB6Qf/hn
	9InMyCtdKZCcQiZH4CSap/hKBP4A1pTBe7YG+FVQhPGb8cDYlBFcVeAdMd6zLOj3B5P8Dc1WGE5
	fdpmbJg==
X-Google-Smtp-Source: AGHT+IGSXC7oLNGvNYsSKydOfp1VLqOjftKvAPrI7Jeo4bci0el2VhPVUjCWQFgWVbZxKP5hoCQI33JGd5EM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c64e:af58:30d4:168d])
 (user=irogers job=sendgmr) by 2002:a05:690c:2fc2:b0:6f4:beb3:1d8b with SMTP
 id 00721157ae682-6f9b2a0e02cmr1182077b3.3.1739212699512; Mon, 10 Feb 2025
 10:38:19 -0800 (PST)
Date: Mon, 10 Feb 2025 10:38:07 -0800
In-Reply-To: <20250210183808.130522-1-irogers@google.com>
Message-Id: <20250210183808.130522-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v5 3/4] perf parse-events: Set is_pmu_core for legacy hardware events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Also set the CPU map to all online CPU maps. This is done so the
behavior of legacy hardware and hardware cache events better matches
that of sysfs and json events during
__perf_evlist__propagate_maps. Fix missing cpumap put in "Synthesize
attr update" test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c |  1 +
 tools/perf/util/parse-events.c  | 37 ++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index d6b4ce3ef4ee..9301fde11366 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
+	perf_cpu_map__put(evsel->core.own_cpus);
 	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6c36b98875bc..8cccf1e22cdf 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -231,21 +231,30 @@ __add_event(struct list_head *list, int *idx,
 	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
-	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
+	bool is_pmu_core;
+	struct perf_cpu_map *cpus;
 
-	cpus = perf_cpu_map__get(cpus);
-	if (pmu)
+	if (pmu) {
+		is_pmu_core = pmu->is_core;
+		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
 		perf_pmu__warn_invalid_formats(pmu);
-
-	if (pmu && (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX)) {
-		perf_pmu__warn_invalid_config(pmu, attr->config, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG, "config");
-		perf_pmu__warn_invalid_config(pmu, attr->config1, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
-		perf_pmu__warn_invalid_config(pmu, attr->config2, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
-		perf_pmu__warn_invalid_config(pmu, attr->config3, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
+		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
+			perf_pmu__warn_invalid_config(pmu, attr->config, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG, "config");
+			perf_pmu__warn_invalid_config(pmu, attr->config1, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
+			perf_pmu__warn_invalid_config(pmu, attr->config2, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
+			perf_pmu__warn_invalid_config(pmu, attr->config3, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
+		}
+	} else {
+		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
+			       attr->type == PERF_TYPE_HW_CACHE);
+		if (perf_cpu_map__is_empty(cpu_list))
+			cpus = is_pmu_core ? perf_cpu_map__new_online_cpus() : NULL;
+		else
+			cpus = perf_cpu_map__get(cpu_list);
 	}
 	if (init_attr)
 		event_attr_init(attr);
@@ -260,7 +269,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
-	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
+	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
-- 
2.48.1.502.g6dc24dfdaf-goog

