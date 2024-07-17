Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815175804
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256469; cv=none; b=evKcPuHeKXP6UtH9tQPGUmPFHjiL1T8mgfy1ohRvdL/caJRrPKdnQMpmC53256FgVVuunXQ7WzXWYUaVxXxP9Zvq9jaNXK3upcVM6FsVRkpYnG872H+qGVu3GNPw5zuTzILcjMXy4dJ+qW5ePJHjD3JokGvR/43STFfjwhxJVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256469; c=relaxed/simple;
	bh=vXnQhbin+nQKx7EvHi/dTqGLgSRRVMsSgXeOitPIA0Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CaJvJ0Wls1n+TGXUGgePzkELIc5+TncFl3rkRS8C65m5URR6yovGNSVv0zQSI24grrg/FF0xNTF3kEaY446/v/JGLZ9xpQ8GkQtcal+BkJhB2ODSKgkuiQx48Nz72rkH62Z1+d7mN/KukYjxI1iMMj/kvW3cDSDdz3D3TbMIJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaARsyLO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaARsyLO"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654c14abdcfso5375537b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256467; x=1721861267; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07dbUcOHVzfNvgP42n0WKJm07xg7m6Zt3c+s/XZJ4AY=;
        b=oaARsyLO0Ux/V9MwhYkcTVGv1HxifjRPi1+fAwjspRLxmHOB/2WcvbhvW9ZaWSZ5ot
         ErarQmtio/DzmuWjwz7gNtALd9PqBdpQicRsNGiEsAvurEVufEGt5bIaCNRrtK4v8ghx
         MH7wWlJ1/n9awX5fjA41uSlKUfPAaG+fItJmJSFmeYshCRhdN4hMYbDHGDVfjlgFjm+k
         vYS/E4L9XXlWZh9wX2CtslkY1W/w5q1YGoRoQAujF1NLHvDMpuQhI+sJ1zCbwa4x1Lg3
         RIdOA34u6xQhqkmgkyHEQZtg/rOI3KkKb4a1f9NoxWbjq7FDyXa88AWbG12V4g8gXo6R
         x7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256467; x=1721861267;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07dbUcOHVzfNvgP42n0WKJm07xg7m6Zt3c+s/XZJ4AY=;
        b=wfN1lhm/n006r1cAEk+/kbYJSobkrAthvL26iQ+7IvnpSODts0Tvh9kUgjTlILoQ+J
         656vvZ5IKfCphStEh3dZNNmfdOx3GC0ZRRNpzxd2aywn13P/r+YTp9L7qAK0k8Tiultt
         RevP4VYRMj2GulD6Gr0MneXfQ91KhwOFJKG800buiEwHu33Y0OYJsfeFO73cog/wSKGo
         G3dWcGPNPOEnV7kD+hsS2F60MWfJaZ2R1UbzWVPWtqtzNrBbZ1OAgdFo5y/ej+UYrOIU
         v/oS5vS6xutK2MsRUGxTJvvdcvJiZyxkQ0GybL0r3DjUO+b1MOdf+pS9NSidhyTdVLJw
         cs2A==
X-Forwarded-Encrypted: i=1; AJvYcCVGS9lBw5SuSoNfXj6ZhI7PQL7AWm7604mV6MJgG7uzxYwa0hOxtV99nxGvvcVqSv6qnkHAE3zC5lbznAvPSXwCHeoczW6f8DvmzpNLXNxKdQ==
X-Gm-Message-State: AOJu0Yy4JwEPhfAfwy49y92U8PRheJbJfIy4VKAJRPuPx8eeBAb5qfep
	6Ydzv1uiZw6hOBQYRVphcYoAoLsDsFItIC2gkz2zXYOi2AjUmacwqWCAeE88FLVCKHu8fXbW2Ac
	KfvjyDA==
X-Google-Smtp-Source: AGHT+IEQzUOqt1R2zA4YoYl+BUWxXZw+FnH6EjlXC7f/QZ+1bZXaeM94zJuD8YbypGj3+TlpRIgWzUDjjvB2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a25:ce94:0:b0:e05:7113:920c with SMTP id
 3f1490d57ef6-e05ff327141mr12295276.6.1721256467381; Wed, 17 Jul 2024 15:47:47
 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:31 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 5/6] perf parse-events: Set is_pmu_core for legacy hardware events
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

