Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE620ADF8
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894354; cv=none; b=YmPXrDjeVhoH3Qw2/M1nlOr0u8PA2CmdAtOf/Lycsym64ZJPiMMKDWpbGUoMv3Rkjd8n7Sf8yqfXJZt9F32kcHA45zlkC5C+3dxE3T9CrHTQwg6CJwgwTuIFkTOfZGGZGzp7xY8B0dlpyYo64v+z23MoUy7xPwGssskTXwtBK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894354; c=relaxed/simple;
	bh=jEgvDggwtQddGz/4ZXMmANkYODrHYVg1OL8Si0VZ5M0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kpYv0FFRwjtRqjuyL3cm1driTvIg1qI+hAPO3XjdubFICFgm9bkx/RVeSUoyvrGhf1semqM9TZdaj/zb9DRL6g+xHyhqXCItf97OeD0f0Tco2+HRDZ9OtGzT96We8CRuuqyIrxgcw3XMXmJy8TKayB26gMVZWIA/QG/yd8ZuVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qg/0B+6u; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qg/0B+6u"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e8e969090aso2688239fac.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894352; x=1753499152; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbO2FaLlRAtP3MPRgVDa/ZaeF16Ze9Vrmjj4VaK1jxk=;
        b=Qg/0B+6u0J2HgxoKg6/74lqLvHYs5P9h4OmbgpTEDkvEzn+t9S4AW+NarHsrhtEL3e
         upjvxsqyhoLuGxdSmDcg6+ivbJc3qsQh+LHWua6puHcFvelVnT77Y2UJfmDfKO7J5CUt
         GmMbXZ1SE/8oxkl7rZ6rVaZyjsYden1WKxUFCshPPlAB6EHs3mU7Xps8iTcQzAXIqFT7
         lfgXgc1A5yhlDAOH0nVYFOvy5a8STDKhMCGcNQM0rSjoS4oeeyYNvGq6ap0xz5S9qWbv
         BoLMK6bn2kH8abPJ6eITjGfjHtFbYbcOj5Dxr7+8m5jXlfKnEA1Nnj2YuPLEuGisnq9k
         Mahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894352; x=1753499152;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbO2FaLlRAtP3MPRgVDa/ZaeF16Ze9Vrmjj4VaK1jxk=;
        b=mFcSMGD57xQtyvEGQ8jInnrwKDgxE4Rj7qnO2rg7X1Fm1nF4oQUDrDQrYV8Ukdx8cx
         6JYIehaMlsbmqfIfqskYYBgNXZIyHakOajqEWjJL//rlKUVlRAFeJQlYhjsaQmSOf9Le
         fVcfZBYFskcLqSJ322tWnKVsJUetRHAgbhX2VixnvVAdRjwiolAdOXyrmJ4uO3RrQJXs
         AoLC8lp2rRso4VOymc8L75cyu8eF97B14vOq8WKIORPnQG25jVlHEHNCkzG25ceACo1y
         eYZQNBeJIodozHfLbLiw+vqdVFBIoG+pVe56M1mxnMrTabQt6tHGWUv2d2JD257U64tz
         nh9w==
X-Forwarded-Encrypted: i=1; AJvYcCVvD/kB4OLo74CE+Q2iry4BuZ3U7z89BPqGJ36o+5C6DatY2gD9ndizGriioPYdNzOUsyZecqysBHgpjft4C0QE@vger.kernel.org
X-Gm-Message-State: AOJu0YxamYOJIsv5JVFra9r2PWrsvM5iO+S8lTjTrG58dUZaLJ+NVCBP
	1sjhAChr7cjAOnu24WVSUhf/M0n2R7XqJjeup0Pix8Mq+da3bgLGQRwh7R0qXR9qanXNgz5yMVI
	TeK4+ODq41A==
X-Google-Smtp-Source: AGHT+IH9mQssBop1ojQqFEkRCfHDS5fXdwoIedZ8y4RWCt//Bq7XXGqKMaiiV+8DtXnKcOcE+95CnISBh2tw
X-Received: from oacpz15.prod.google.com ([2002:a05:6871:e48f:b0:2ff:a540:5c40])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:b0e:b0:28c:8476:dd76
 with SMTP id 586e51a60fabf-2ffd256ea33mr7239613fac.29.1752894351636; Fri, 18
 Jul 2025 20:05:51 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:12 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-11-irogers@google.com>
Subject: [PATCH v3 10/15] perf parse-events: Minor __add_event refactoring
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename cpu_list to user_cpus. If a PMU isn't given, find it early from
the perf_event_attr. Make the pmu_cpus more explicitly a copy from the
PMU (except when user_cpus are given). Derive the cpus from pmu_cpus
and user_cpus as appropriate. Handle strdup errors on name and
metric_id.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 69 +++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d506f9943506..bd2d831d5123 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -259,12 +259,12 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, struct evsel *first_wildcard_match,
-	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
+	    struct perf_cpu_map *user_cpus, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	bool is_pmu_core;
-	struct perf_cpu_map *cpus;
-	bool has_cpu_list = !perf_cpu_map__is_empty(cpu_list);
+	struct perf_cpu_map *cpus, *pmu_cpus;
+	bool has_user_cpus = !perf_cpu_map__is_empty(user_cpus);
 
 	/*
 	 * Ensure the first_wildcard_match's PMU matches that of the new event
@@ -288,8 +288,6 @@ __add_event(struct list_head *list, int *idx,
 	}
 
 	if (pmu) {
-		is_pmu_core = pmu->is_core;
-		cpus = perf_cpu_map__get(has_cpu_list ? cpu_list : pmu->cpus);
 		perf_pmu__warn_invalid_formats(pmu);
 		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
 			perf_pmu__warn_invalid_config(pmu, attr->config, name,
@@ -301,48 +299,77 @@ __add_event(struct list_head *list, int *idx,
 			perf_pmu__warn_invalid_config(pmu, attr->config3, name,
 						PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
 		}
+	}
+	/*
+	 * If a PMU wasn't given, such as for legacy events, find now that
+	 * warnings won't be generated.
+	 */
+	if (!pmu)
+		pmu = perf_pmus__find_by_attr(attr);
+
+	if (pmu) {
+		is_pmu_core = pmu->is_core;
+		pmu_cpus = perf_cpu_map__get(pmu->cpus);
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
-		if (has_cpu_list)
-			cpus = perf_cpu_map__get(cpu_list);
-		else
-			cpus = is_pmu_core ? cpu_map__online() : NULL;
+		pmu_cpus = is_pmu_core ? cpu_map__online() : NULL;
+	}
+
+	if (has_user_cpus) {
+		cpus = perf_cpu_map__get(user_cpus);
+		/* Existing behavior that pmu_cpus matches the given user ones. */
+		perf_cpu_map__put(pmu_cpus);
+		pmu_cpus = perf_cpu_map__get(user_cpus);
+	} else {
+		cpus = perf_cpu_map__get(pmu_cpus);
 	}
+
 	if (init_attr)
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel) {
-		perf_cpu_map__put(cpus);
-		return NULL;
+	if (!evsel)
+		goto out_err;
+
+	if (name) {
+		evsel->name = strdup(name);
+		if (!evsel->name)
+			goto out_err;
+	}
+
+	if (metric_id) {
+		evsel->metric_id = strdup(metric_id);
+		if (!evsel->metric_id)
+			goto out_err;
 	}
 
 	(*idx)++;
 	evsel->core.cpus = cpus;
-	evsel->core.pmu_cpus = perf_cpu_map__get(cpus);
+	evsel->core.pmu_cpus = pmu_cpus;
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
 	evsel->first_wildcard_match = first_wildcard_match;
 
-	if (name)
-		evsel->name = strdup(name);
-
-	if (metric_id)
-		evsel->metric_id = strdup(metric_id);
-
 	if (config_terms)
 		list_splice_init(config_terms, &evsel->config_terms);
 
 	if (list)
 		list_add_tail(&evsel->core.node, list);
 
-	if (has_cpu_list)
-		evsel__warn_user_requested_cpus(evsel, cpu_list);
+	if (has_user_cpus)
+		evsel__warn_user_requested_cpus(evsel, user_cpus);
 
 	return evsel;
+out_err:
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(pmu_cpus);
+	zfree(&evsel->name);
+	zfree(&evsel->metric_id);
+	free(evsel);
+	return NULL;
 }
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
-- 
2.50.0.727.gbf7dc18ff4-goog

