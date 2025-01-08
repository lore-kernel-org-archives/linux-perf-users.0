Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE691A706F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314493; cv=none; b=aP3BRsorXm0HSdGP3Hk4swIjEHi2+eYTUbXhmnNmyqeaB2k0OPrtvyRc0+ReEvGpMVjmvjleYdw+hEra2R+7BMV7CIQi8vS8JFxBSZB2SmMviUPm8kJrUgW9hfaFhgeRfo4HFqp4jAE66ZdNAKtzUJ/g9M77+x61X0tPdWCWwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314493; c=relaxed/simple;
	bh=pU3q7gcfHF5YJFJO82z2GpY1D+Ad/Z/0AoIS1WPrJj4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eOXtp7HarLyLomMH8cQNGyExPLcc1ntarZb3O6HbLpagcBU7vSlzjMt6K+wKDDkpiyoorcSyCJiflXVtnFRYuNREl7GpCcg+iLq9/3XHYLjDJedSMB3bvLZ1GPRD2lViEeq1kLFQNN/8V/AY/fiH415r4Tps7avwvUWoV9aAmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOpGT0Ov; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOpGT0Ov"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a1bc0c876so37357433276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 21:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736314490; x=1736919290; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FF1+dR5Lo7oMmZmNU3Ip/TUs1XkJ0WZAvmFs9ECk2g=;
        b=HOpGT0OvHQT9L23a61RD+HaqCJ8bwWC4uAb4zQMtLWMWqB9t/ZF8BxufgVg7xsazy5
         4A6y65BvOam+yaumHaYrH4WzIgaDh/YQ+pLt3oHzNwLEYRV4s7bFCCBd2MzJL1qZw079
         eJVVEKQuyUUl5sHCeisjoECFxfSOcF9BqS3sYKuSEWRaSzEVcXZIHMNcgH0MhQVR/VZD
         PrHJ2o7xv/6ITxVGqUxzyKVzHPNdT0fKEJyDkYMe6hjlPtAirLXsZtOZtLSVuRi+zKA6
         vXYhVhLYrWoefF1IXYoOTLJw+JjC3qc5W2YITyPaemT9ANk2rINvHy01DWhAVyiAQRS+
         zI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314490; x=1736919290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FF1+dR5Lo7oMmZmNU3Ip/TUs1XkJ0WZAvmFs9ECk2g=;
        b=PWpPm4hGHNmuWEyZFXapreUpx9nVYvM8meRV0YOuzAaFj1OwAZZP3LSSvWnTqVTexY
         YjmXPaoXswPhijsGut/u/C/3G0wK+eYNDwYb1igqZ6kF7WHbl+McNXqkv16p7n6N0Nws
         R5FmQbR9+E2Xsd8+Gl3Tbix74XI77SNMBN8muGgZA5MJVFYUZZ26IvuwBGFH9Wmdu2zE
         qCqjAGN4JjOvhkxdes41gc7wYfctTuGhMpH1sXDolB51+mKqlpyL1g0QqeHeladWQMK0
         0CSkFSbgtWG2UhM63jypf6gukd9eW8yQE0rLzTiXwa/gSAGmEMgYAk7i80mGeP7NhOam
         4tbA==
X-Forwarded-Encrypted: i=1; AJvYcCWoWH7asW7H85RuLf/1PcwpQSrCIiYUWhjb1jAzHH1TdVAmPwjI36/gdXJ1zhnrgWc1N4mO9MvRIlMiSwGh5dds@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sBg1/1k+In0744ylUn7Ry6nkEobOdH0jRUyxd3ONDjMMxmvQ
	uPSWGGwc58mpdPN/ntVmaVHof4ouWckEKj5WuPsspez6Tul5aqs4qQBSSCZsI5YRlPm5T3zXOo+
	pFV1piw==
X-Google-Smtp-Source: AGHT+IEUKIlCLJcb4EXajotMSIYDCcsHbs9Nh5LAlws/3NJnHcyVabzgEL04vNJh/CrGAixRszW7Ydk2FO36
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a0d:dc46:0:b0:6ee:3fb4:45b9 with SMTP id
 00721157ae682-6f5312b4c37mr41297b3.4.1736314490615; Tue, 07 Jan 2025 21:34:50
 -0800 (PST)
Date: Tue,  7 Jan 2025 21:34:27 -0800
In-Reply-To: <20250108053428.1724490-1-irogers@google.com>
Message-Id: <20250108053428.1724490-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108053428.1724490-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 3/4] perf parse-events: Set is_pmu_core for legacy hardware events
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
index 1e23faa364b1..4bda4141e9e7 100644
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
2.47.1.613.gc27f4b7a9f-goog

