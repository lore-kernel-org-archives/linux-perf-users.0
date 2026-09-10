Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44735F182
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007520; cv=none; b=ESfEt+eUjvMNPPEaJOhsIjc7jdg2B5ghYZT16L7y89UlDgKqfkYUvhx0jnqXqEh843ID7swLkO5G7SXojGaWaBrHkqz60Jda6YxxcZ3LtRWWxC+4fsooOKRcg5O1zadc1i29HeU0jtKPSfwOE3Ug742Rc56XCRsyTew4VcNTK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007520; c=relaxed/simple;
	bh=AkUhW63lsYMS1kn2/ZT+v+cv8lVWg8USKa64IK7rGuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LuS4gKhYghYXgRVfnD+UPWGvHiY3bhjRm9JWGi3Ff4begJd6kdwWV9HfCwj4uCj29GPAf0nrzCeIur7ju5t4OrYW/+zHSzIwIurr1jxslvuHikBvxFhJkqKIxYp2GFsId/yhtlmLkFv7sQ+nEwSt/0K5ZpxRGwR4+ZSgmt2bTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lPAUUM40; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lPAUUM40"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso758732a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789007518; x=1789612318; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4l9pfCxAqROy9dMetwLy4Hi2HOjTkAgX0HE8E8onqqo=;
        b=lPAUUM40tBowkc0dJC3FwPOWUR864caRMX8e+kf8xlnbEfvOKxYkTC/ZOubXnlXKQq
         R2RnuSeMeI/+NpH38F9fIhV0KyWZ67cW8CSwGez90XZFe+14FxTR/NANOewMdbvIUkZd
         dtzMGOtn8WPaT2foetioBLV1aKp4T+IGFp8gttJUCED21q3gMTdVx9qkPp5ivIdHJDir
         DV4xvyIJCH3+b/0fYzuWxIiadqKGzICGNrtMg8NksV07dkwkRuL6mR+z6HZ2+8Y6HRXV
         UmVPAHjbu44RUmUvkDFQuzU2IglU5RUoTHB3vsZ/Ac8ICRiQ9H3wahGFuesMJoAYt1om
         nhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789007518; x=1789612318;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4l9pfCxAqROy9dMetwLy4Hi2HOjTkAgX0HE8E8onqqo=;
        b=g6A2ICJrtPl++10ULRoATHAKTrZQ4gVtZGZ+06gkKR0/7dg621ZcVuGCBcsfGJXrzM
         UxYUdIyArbmATnGH2TIIxxaqfTciGYV5/KFiOwNjwqNAs3NTkugWrIg4vt5Xshev81PP
         d8w10GvG/VA2sZGnmDcy787I9EjiGyOjDSSN+ToKIy7k5ItEDTqTLbBAWHOZr4PnmuJO
         gMWdT87wfrhlfNlOTwfZMcyYopCfXADPrQ8pmZMgI2zvMiW91dlsJUURgfpB7+qWmjLv
         pmo6wyd2Y6DD7LZst5yHNraZTEn1bORFqEUj4hTetwxQgHCf0xHP3610jDxqMMN6UvGo
         y6Dw==
X-Forwarded-Encrypted: i=1; AKwUvBw6x657rW5nWsR1Mre94ZzJBEcdnDptb7vdJmODkq8IcNUc6uQJpKKBkK9nN0eg2kCllglabDHhkTDaubiqmB1h@vger.kernel.org
X-Gm-Message-State: AFuF++mmAC6oXf4L4zIcgli9a4ZYkr3UYFtgb06WzE8duhZ+yIf4zmMk
	L06Gu9plrTMCWQA8HOuEx97aqntDFhNY4kG9hK7ZjH61Y2sNm17264nNqGq4VgR2eQs=
X-Gm-Gg: AYBFou2zIdfcI4HIHZi7yvHwWxhcHCxkiFVI4FOTdsO2kh3cD/HHlHxal5Co64oBU8+
	niOEspyeYGOy8XA1pswCkjdFOuzzhN/OUaRgmvX7PtgXsvwnwPBJrx4X7WO15lsO1hTQ9VEQJ0u
	uQMjj2mZegQRegPKHlQl7Jp9RGCNcxxBHShAhdIIXfmM9LVq8zAPu6J5Lo+X0Z8YwlI2yLAW7pm
	3jjOIlROpE0meMKiUNd66XCjM85f6MLJX78R1t8r6++bfw3BCRow0PASZJ/bqzjJvlHOuLLKyU8
	YEjaGpHUlgi9hCEV32HbERIA5IZzDmEngBrTmLJ1Mpc9rbwsp803su1HFMqn09WdvCAubTJ8MO5
	WZQ8gQ0VYaNAZOEJc8BSzSLotwSY2PWL0NS7No4fEp01qRgvjMAgWx1zl8PkKourivtW7Wv/dD9
	6YxoGhtouFsKS5oHlPaGl2VutJZVvb1T4aQd4FObJEmXHnPXIF65RcNRP9hsGfNJV5kTA7HzGvy
	mL9Dp082w==
X-Received: by 2002:a17:90b:50c6:b0:398:9be6:f997 with SMTP id 98e67ed59e1d1-39d70c0a87bmr7025034a91.22.1789007518413;
        Wed, 09 Sep 2026 19:31:58 -0700 (PDT)
Received: from sw08.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm53182833eec.30.2026.09.09.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:31:58 -0700 (PDT)
From: Nia Su <nia.su@sifive.com>
Date: Wed, 09 Sep 2026 19:31:52 -0700
Subject: [PATCH v2] perf evlist: Don't restrict uncore events to PMU CPUs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-perf-evlist-uncore-cpu-b4-v2-1-dc673a1f4592@sifive.com>
X-B4-Tracking: v=1; b=H4sIAJcWomoC/42NQQ6CMBBFr0Jm7ZhpUxBdcQ/DAupUJlHatNJoC
 He3cgKX7yfv/RUSR+EEl2qFyFmS+LmAPlRgp2G+M8qtMGjSDZ3JYODokPND0guX2frIaMOCo0G
 j2sGRUyfbEhQ/RHby3tvXvvBUFB8/+1VWv/WfalaosCEz1rUlXTN3SZxkPlr/hH7bti8/SmLyw
 wAAAA==
X-Change-ID: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nia Su <nia.su@sifive.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=nia.su@sifive.com;
 h=from:subject:message-id; bh=AkUhW63lsYMS1kn2/ZT+v+cv8lVWg8USKa64IK7rGuY=;
 b=owEBbQKS/ZANAwAIAYihNJa3+YfgAcsmYgBqohadwtzTzZ7VX3HqvgjOBc8pQ/pv0eCJZeMrN
 6YAgCXo0e6JAjMEAAEIAB0WIQThGl/T4FqBBU9NhIeIoTSWt/mH4AUCaqIWnQAKCRCIoTSWt/mH
 4O9ZD/9zg4a2XdARP7Iv7FT/IBnjSLxzaLbby9d7blxD3sC7HSTyz9Q4fs4TjTR8lveZTvoxTDg
 L36+YuIYGF3W9xQ0h3hM1iZhkiBOxx5cWHapm5Jnnb6tfKfF+C6ettompYCUfux00u7a7Hc4GbO
 uJcglld0UohZXLALHbzTqaQ31kPJS61vmbdY8QoMvp1G1fEgwzaY2wu/rIwX5zLG5hFBuonwoNt
 rOovOhawe0IyEB/o6Yr/AyDEpm5OeJkXR44P6Yzy4lz9cixSEksfNbSEOGMh3jADoHRPSk4NkjM
 j2utwN3PpXbWKQhGRyihgaoEslt/Atzgnxmd9clozf18xYD6hefTvZA9C5kil78P+1nEHyfVjc3
 taZVw+82LEjEHwsv5seIeMpPEuH2DKjipX1wZx8VQdqvhown5g0sNZrSq8R1cK2L+w5s7yrqNP7
 yyOGVe9WUoaytljgRneklknjiIgxDlf6dhexJnS1lqCIkdKlRHtwE+k4BXdhxzzoXjFVDyDZrIF
 FC9AaJ7J5gjPZ7EDuIuXLe9uiM9zNj3U1WrvSBjx8C0hCjdvZlNlbpWINlRkXu6ar2e1APFaCri
 WQq9HVVxhB6VyZOFbygoo7iTNjbMjlQ/ZjXdQz2EL0Fq8rLNLhFt+PBoXdOYMjfk21u79Q9NFXi
 ELneAByZ+sH1bag==
X-Developer-Key: i=nia.su@sifive.com; a=openpgp;
 fpr=55235C875092ACC578EFCE6CD1699E646B29B1AF

The PMU CPU map has different semantics for core and uncore PMUs.

For core PMUs, pmu_cpus contains the CPUs on which the event can be
opened. Intersect the user-requested CPU map with the PMU CPU map to
reject CPUs unsupported by the PMU.

For uncore PMUs, pmu_cpus is read from the PMU's cpumask sysfs attribute,
which lists the default CPU to open the event on per socket/die, not the
set of CPUs it can only be opened on. The user-requested CPU may override
these defaults, and the driver can redirect the event to the appropriate
control CPU.

Currently, __perf_evlist__propagate_maps() intersects the user-requested
CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
pmu_cpus, the intersection becomes empty and the evsel is removed before
perf_event_open() is called.

Add evsel->is_pmu_uncore, set once from pmu->is_uncore at parse time,
to skip the intersection for uncore PMUs. Core PMUs, and other
non-core PMUs such as software events, breakpoints, or tracepoints,
continue to be restricted to their PMU CPU map.

Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")

Assisted-by: Claude Sonnet 5
Signed-off-by: Nia Su <nia.su@sifive.com>
---
Changes in v2:
- Add a dedicated is_pmu_uncore flag instead of reusing requires_cpu,
  since it more precisely represents whether the PMU is uncore.
- Link to v1: https://lore.kernel.org/r/20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com
---
 tools/lib/perf/evlist.c                 | 5 +++--
 tools/lib/perf/include/internal/evsel.h | 2 ++
 tools/perf/util/evsel.c                 | 1 +
 tools/perf/util/parse-events.c          | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 1f210dadd666ff818a23712ab95acaa659ccf8dc..c1c5b0684eedb7a6ab8f3df85f326fbd5ef809a2 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -79,8 +79,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		}
 	}
 
-	/* Ensure cpus only references valid PMU CPUs. */
-	if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
+	/* Ensure cpus only references valid PMU CPUs, except for uncore PMUs. */
+	if (!evsel->is_pmu_uncore &&
+	    !perf_cpu_map__has_any_cpu(evsel->cpus) &&
 	    !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
 		struct perf_cpu_map *tmp = perf_cpu_map__intersect(evsel->pmu_cpus, evsel->cpus);
 
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index b988034f13710ec4d49d942d486c4b9afe21a1f0..35447bed0f9586b538dad40c223e70d50486c5f6 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -128,6 +128,8 @@ struct perf_evsel {
 	bool			 requires_cpu;
 	/** Is the PMU for the event a core one? Effects the handling of own_cpus. */
 	bool			 is_pmu_core;
+	/** Is the PMU for the event an uncore one? */
+	bool			 is_pmu_uncore;
 	/** Does the evsel on read on the first CPU index such as tool time events? */
 	bool			 reads_only_on_cpu_idx0;
 	int			 idx;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d45ae2f9133709ff3248b54163ce0..5acec3f6345099ef9e46e81614b9df2595925b1c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -551,6 +551,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.system_wide = orig->core.system_wide;
 	evsel->core.requires_cpu = orig->core.requires_cpu;
 	evsel->core.is_pmu_core = orig->core.is_pmu_core;
+	evsel->core.is_pmu_uncore = orig->core.is_pmu_uncore;
 
 	if (orig->name) {
 		evsel->name = strdup(orig->name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc7ad331a49f34536f66724370b8bb94ab65bacd..8302be207c1d6ecf8ae6fd67f54d66d08d50e01c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -269,6 +269,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.pmu_cpus = pmu_cpus;
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
+	evsel->core.is_pmu_uncore = pmu ? pmu->is_uncore : false;
 	evsel->core.reads_only_on_cpu_idx0 = perf_pmu__reads_only_on_cpu_idx0(attr);
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;

---
base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80

--

