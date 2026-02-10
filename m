Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADE32D0F5
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703452; cv=none; b=eTvktBUPzh0/dTEP1KdO17X2Wz/thFjimHmVBRPFj342bO+YTHwM04LKE/ZNtfQjxpAi6EosnMTO+ug7x60sYymXTJLGiMpX/Xe4Uo3w26/9fXv3tYhMAbQvEh2j6ykuSySUExZ2Zz+w9KnwqCC078P7MV6fS+rGPH95bbfM0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703452; c=relaxed/simple;
	bh=m6NLJ4Vb0UEPbPzi83NUsogmV6qs5B+5r17ynjkDPV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PPUBmfH0psyDYoR411xJps6e5wb+lR14w2AcGli7qqMcFrwHaRMWvRPGuYh4CiFyEfdH9OnlanWP+DOJHPJlU4DCglh/RvnoOKUcROOd3mvrZw3CJr6ZtxLN/tfQBvGkp/YnDNylOwLPwK2vpBEeX+w+ZxNiAT3jxEF76R7nyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqrcSOFd; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqrcSOFd"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a95b6f61so3017735c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 22:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770703450; x=1771308250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOJSg9cHyId65pfgpXUFicdk0Bjz5b4dGSwLC1Zzl3E=;
        b=FqrcSOFdByniHRDVVhL6jzIYgr2ExYpJeLe5tZvpOpG8+pR1/XATNV/3R7YaTloiPn
         zyzzGSU71422ZevKn17i8y0wAUrYa2oBHfgoBsdllgoeOXT8lZkA10m2EwVVBiWSmfR7
         Amd94gZjO/0wbg/FpsK/fVp6gG2sj3ggPUkRDBAdBL2H8499GDfqWr/zK0riuX77YQhM
         W2CUd6DfKnQOikn/98YyAfs+7r5Y33mTEAruJeyTuRTAeGyKhsimXik2KXfeMA7M6SPy
         XWGW68RszIuhaux51lI/XTaaDhipZzif1Ha6l1J+rKsenhya/SHOj5hC2SzkIebvEA/s
         hEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703450; x=1771308250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOJSg9cHyId65pfgpXUFicdk0Bjz5b4dGSwLC1Zzl3E=;
        b=a8p6tS/AID/l4DYSIetOsh4GNBlFbq5IXZgFiPWOSW7ZFUjNweGaiooULtNNtiv5XQ
         J9hVZ7Wwjx3FIr64DMs1CU2d53PXLXLd13O9Z1YHRreEIq09c4y/SBn40/eLnxPpQNsQ
         tpB4EwcWBT3OK70bKkhuSW03rk66T/nNOI12JgWhWzHbZkoAZhIzHZvqc6VrHxfgj27W
         fypAUGJQhEbGoog4+hZXaFH38xAmNtsMNvjS0it8IuKhdfgeA+DHKFcMymzBfVXtHNYA
         aJ1PRk9w7ee6t5yEAq7kQXMn6T8tPhWmDiJ84mGkSIHhukqfQxBWYDLqg1vRnzpsE5Pf
         1cdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/r8m4Ae6CbhBD8BugWbhN4lopxalLRZmILnRmnZpyTfUH4OUGOwogsq0ktOoKqhVxM1nchypuk845nbOc9UDE@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkZ7I7rb1Ojbuo0ZiXKm7b5RkfsZFKR0rP1yNnnNQkExDX8LO
	/rsCvZUBgx3neUNPmv0SmNcSfgWZIzuqB5Pc32Uz/S9KeemyzWucEypVwDVD4sgTBcNUCBEDGqk
	eJkCQ/NDtvw==
X-Received: from dlb29.prod.google.com ([2002:a05:7022:61d:b0:127:1508:19ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:419c:b0:124:9dea:188d
 with SMTP id a92af1059eb24-1270405a026mr5730471c88.30.1770703450210; Mon, 09
 Feb 2026 22:04:10 -0800 (PST)
Date: Mon,  9 Feb 2026 22:03:56 -0800
In-Reply-To: <20260210060359.2233425-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqHTfCoW1bGmJF4@google.com> <20260210060359.2233425-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210060359.2233425-4-irogers@google.com>
Subject: [PATCH v9 3/6] perf evlist: Special map propagation for tool events
 that read on 1 CPU
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Tool events like duration_time don't need a perf_cpu_map that contains
all online CPUs. Having such a perf_cpu_map causes overheads when
iterating between events for CPU affinity. During parsing mark events
that just read on a single CPU map index as such, then during map
propagation set up the evsel's CPUs and thereby the evlists
accordingly. The setting cannot be done early in parsing as user CPUs
are only fully known when evlist__create_maps is called.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                 | 36 ++++++++++++++++++++++---
 tools/lib/perf/include/internal/evsel.h |  2 ++
 tools/perf/util/parse-events.c          |  1 +
 tools/perf/util/pmu.c                   | 11 ++++++++
 tools/perf/util/pmu.h                   |  2 ++
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 3ed023f4b190..1f210dadd666 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -101,6 +101,28 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 	}
 
+	/*
+	 * Tool events may only read on the first CPU index to avoid double
+	 * counting things like duration_time. Make the evsel->cpus contain just
+	 * that single entry otherwise we may spend time changing affinity to
+	 * CPUs that just have tool events, etc.
+	 */
+	if (evsel->reads_only_on_cpu_idx0 && perf_cpu_map__nr(evsel->cpus) > 0) {
+		struct perf_cpu_map *srcs[3] = {
+			evlist->all_cpus,
+			evlist->user_requested_cpus,
+			evsel->pmu_cpus,
+		};
+		for (size_t i = 0; i < ARRAY_SIZE(srcs); i++) {
+			if (!srcs[i])
+				continue;
+
+			perf_cpu_map__put(evsel->cpus);
+			evsel->cpus = perf_cpu_map__new_int(perf_cpu_map__cpu(srcs[i], 0).cpu);
+			break;
+		}
+	}
+
 	/* Sanity check assert before the evsel is potentially removed. */
 	assert(!evsel->requires_cpu || !perf_cpu_map__has_any_cpu(evsel->cpus));
 
@@ -133,16 +155,22 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *n;
-
 	evlist->needs_map_propagation = true;
 
 	/* Clear the all_cpus set which will be merged into during propagation. */
 	perf_cpu_map__put(evlist->all_cpus);
 	evlist->all_cpus = NULL;
 
-	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
-		__perf_evlist__propagate_maps(evlist, evsel);
+	/* 2 rounds so that reads_only_on_cpu_idx0 benefit from knowing the other CPU maps. */
+	for (int round = 0; round < 2; round++) {
+		struct perf_evsel *evsel, *n;
+
+		list_for_each_entry_safe(evsel, n, &evlist->entries, node) {
+			if ((!evsel->reads_only_on_cpu_idx0 && round == 0) ||
+			    (evsel->reads_only_on_cpu_idx0 && round == 1))
+				__perf_evlist__propagate_maps(evlist, evsel);
+		}
+	}
 }
 
 void perf_evlist__add(struct perf_evlist *evlist,
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index fefe64ba5e26..b988034f1371 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -128,6 +128,8 @@ struct perf_evsel {
 	bool			 requires_cpu;
 	/** Is the PMU for the event a core one? Effects the handling of own_cpus. */
 	bool			 is_pmu_core;
+	/** Does the evsel on read on the first CPU index such as tool time events? */
+	bool			 reads_only_on_cpu_idx0;
 	int			 idx;
 };
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f631bf7a919f..b9efb296bba5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -269,6 +269,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.pmu_cpus = pmu_cpus;
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
+	evsel->core.reads_only_on_cpu_idx0 = perf_pmu__reads_only_on_cpu_idx0(attr);
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
 	evsel->first_wildcard_match = first_wildcard_match;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bb399a47d2b4..81ab74681c9b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2718,3 +2718,14 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	}
 	return NULL;
 }
+
+bool perf_pmu__reads_only_on_cpu_idx0(const struct perf_event_attr *attr)
+{
+	enum tool_pmu_event event;
+
+	if (attr->type != PERF_PMU_TYPE_TOOL)
+		return false;
+
+	event = (enum tool_pmu_event)attr->config;
+	return event != TOOL_PMU__EVENT_USER_TIME && event != TOOL_PMU__EVENT_SYSTEM_TIME;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7ef90b54a149..41c21389f393 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -350,6 +350,8 @@ void perf_pmu__delete(struct perf_pmu *pmu);
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 bool perf_pmu__is_fake(const struct perf_pmu *pmu);
 
+bool perf_pmu__reads_only_on_cpu_idx0(const struct perf_event_attr *attr);
+
 static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
 {
 	__u32 type;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

