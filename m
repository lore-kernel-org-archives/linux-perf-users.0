Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED9286A6
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262654; cv=none; b=NR34YuCdedXpp0d6iwxXXX/B7JO1KwJiZdySVjYN62JV8p6rSGPlX/smlGTaUQqhhG7QKr7LMzSqE4PYQIFxa4fw7tTfk8RmNkAgHTP5eq1BZWAFN/vPOMfL09KDdTXkViMPtVIYv0dj+Q5YSr5kFew91Ta9kOBQAmuzJp3L7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262654; c=relaxed/simple;
	bh=vXnQhbin+nQKx7EvHi/dTqGLgSRRVMsSgXeOitPIA0Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qEwBz1MauyPMX917UcUEhgV5RwOrdeoEDwEfAch3w5YvqdU6IMGjwZtwIyAjXWlkthGvZ28vBt5cVOZfjHFQab9kVtfJVZ5g7GIngWJP2YRtsXUfx3z6+x5iQD4lD2MkUM4Aiyjp31FSY+M8aaPDI/CkVIgSTEX0DNStowxYYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7rHSmlX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7rHSmlX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e410d310so577224276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262652; x=1721867452; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07dbUcOHVzfNvgP42n0WKJm07xg7m6Zt3c+s/XZJ4AY=;
        b=u7rHSmlXym/YvS4/0TCxeHHy0H0fTptRya3pnrZ1ovoI79j6bRxRQhDIncEIWu/r57
         Ghb2JX7j5KXXTQtdpGlmE60ayQyJxvgraskLVC4T1D56oZzxm3KhOSZCJ32oIRjWkHbW
         eRleYcm1LKs8HaSsI66O7XZEPgKtORi4y0AqrlMUNDV8XsMtfZktvPhxdrfWuVE0bvMA
         LNm1h4SDrQmXCT6SeTNbdJ4yVJVDZFp59f6WGAcqEKM7zUcXVS7qXgqf9q0AXKR5xgNJ
         WTBdqbD6+kC7B+X5WitAIMlsRBkZiaZAf2xhQ1PjjzKhLY7i6h0oZwFgxVqVKan+ZyD5
         Zr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262652; x=1721867452;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07dbUcOHVzfNvgP42n0WKJm07xg7m6Zt3c+s/XZJ4AY=;
        b=wBwg3ndBHxfUKq8a3aLRrTtCyL3ruOB2prk53mpkb7Zn4XZVa2sFb0M9Qvbcd5DNnj
         uTVjdotx5Jwg5S73g2Vrg50DgN8aO2K8+gHwL9IkTf6Shp+Xn6Dq1CRgmBaDbnvs3Byp
         94K5S1/or+dRAmP/k+q/mErAtTgCl1QcmTJp+BVZhOurUmPPM6doK6GurZovYmo7xMY8
         CuAtSDarYVK4PiJ/0+wgBRQf9gHrrGuaa7eUnMsnWhTXtEsRCqAfGNEOKP1C/Ejl16k7
         8619tllDlklo9bFq1RtALAbzK3f1k9rVDhax/bVqaQjE+BLLwCvQcb++FZxTTRb8+oj2
         7ukA==
X-Forwarded-Encrypted: i=1; AJvYcCVaFvjsxs0knq6fchendWwe5RuUs3Lk9VLpEE7H9sE6xm3O2277sNgJFrScK0ZJ7R3A6fY0W/MMqICV7CWO695mfcVN+kF0tVKbEtyZN5J0SA==
X-Gm-Message-State: AOJu0YwG7Qsk40gZaW9RuuZEqYgU6Ib5N8kPC+u+nrATFZ3RDVrG7M4/
	mDWogvOZ137oyZAMLqz8Bdvolgp5JScqc2Yfgtja8orBHBAbTVJyuU9J+1QDzNpsdtvrjoPRbiK
	Nvf6c7w==
X-Google-Smtp-Source: AGHT+IGzrHMh2pPQKwOTaoY7O7XukvUQp8PPPO80ZjO1RUYChGGAOHdA6CkgCd9Cu9Is5SFMyHPP8i8mlXJa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1024:b0:e02:c84e:61a3 with SMTP
 id 3f1490d57ef6-e05feb31053mr1739276.6.1721262652014; Wed, 17 Jul 2024
 17:30:52 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:24 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 5/6] perf parse-events: Set is_pmu_core for legacy hardware events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

Also set the CPU map to all online CPU maps. This is done so the
behavior of legacy hardware and hardware cache events better matches
that of sysfs and json events during __perf_evlist__propagate_maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 37 +++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b181f83c9678..8c0c33361c5e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -230,21 +230,30 @@ __add_event(struct list_head *list, int *idx,
 	    struct perf_cpu_map *cpu_list)
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
@@ -259,7 +268,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
-	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
+	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
-- 
2.45.2.1089.g2a221341d9-goog

