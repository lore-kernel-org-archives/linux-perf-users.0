Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263220AF9C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052266; cv=none; b=GYIJHMQmX3q5qweCM+E/H/u1grOh2U6lxqlXF2VkERrt8mgHNCGqs6haXmxAwR2A3fp2i3twNzYHrc3m44JuOr1HHis7Q8vteCp/qGVb1/ei0oNoNgJstMxVvBQUbaTQ4NLos95VxhRFogN6H0RQkaIgh1AzRERzfvkLNm2JZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052266; c=relaxed/simple;
	bh=5qnWJjXV1yscRGW3Z8MrgpRa/BOaZk2dYgJaEfH4ujE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lOJE719vKxVL58LSYGnaKCMhVSdusobKfNXOLXE6v1InzoGCQjTFTlAowkf6kaYUPUEbdZufpsKfpM8izCohrNHzqtgcIcXar279jA8Ubxbo/+3t4YOmUxU1CVbAEO9fxyFTGbrhHatcCBOoB4oAyY6LsUam8g5hcv1utq9QzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nW5UvM2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nW5UvM2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3613e6aso130861b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052264; x=1751657064; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7d6C2lXVAfC01Fe0gAHfj6nm96vm08japImtMus97hs=;
        b=2nW5UvM26o2eU7jRUFchcAuPKLYBU1ujpWcb1JbmtIkFkB9HQsCXWG0tyyiAB1mOOC
         oiRH8JQxQ4OPEmq1au9L9Avf4FJ6+TF5+iL2IB5uaJuZD7jUd8UdG8Q0lZ3pSfL1pXke
         S/O/WrabZvv26+abCiYPYHotAVslOgxdCnwXGWgJ6uVESIhAaBWVCOTh6lui6A1Jl3m4
         hzqGnPygc8EmhGiFhee0Db5FCJViimbupNfjSVMCTKaGmj4NxaNyvqx+U94m4l71uYNt
         0sWY8lFtTB1FIK0zTVAbfSQj6Mk/vKn4vI+DGppA2ZUTjxDbC6gdZcjsppS+5CFGkrre
         meZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052264; x=1751657064;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d6C2lXVAfC01Fe0gAHfj6nm96vm08japImtMus97hs=;
        b=fwfia2X0kRwQxVnAO6TfY4cNduhDx2/3eDjTYAqWhdZm+Sk4A6ut+vK79q/aN3G6Xb
         nBp6/KmPUf0DVITYiqG0ksQRO328oUeQN1bAm67YZx5S9g7BPMsk59ME4jjGnRFFwXb7
         6l/q/q90WOTFgAYYUW7xdz+Db/0i6rof1mqPE2X9/FoA6uSeuzcyzSNg/5s77BPi5qfz
         3Q/naGZeb8oLpec70ExfX3dPP4gmZLlwJ3f9nYmtCxFR9ke02wJ2sPVaSLF6DGn7N1nO
         9VPYyIy85XqvNCMhNC4QOHuWcSYSZdBtp9HWw2Gu2HLwUprvIo/ZzvYbtwxensAujHed
         vjcg==
X-Forwarded-Encrypted: i=1; AJvYcCWf1KJ1Ffu9ufGjjbjGU5wEfr0oaz57BBTHDfCmK+pUUbvt8YQbtLt3NFStNnjg+VfHYgGDWe0Pn8M9TYzntNqr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g3mcaLMfvlqV9I0jVa4fSep/C8Hw4bT54/1AvAe0XYXwc8L3
	ymEFjMPD2aNKFbAdTY8DhSGrXHP5J+PCY6QYugdRpGwKBORIj2YMLdd5GHNkTCp37/EO0CLl+mH
	q9ovU5ivmeQ==
X-Google-Smtp-Source: AGHT+IGxVVW6Wl9FoYgf65siOYfc6Hro58qDPxO34loRXfOqL/G1tEZu0nJbZPfRW9z4f1g5SNKUncaydpeZ
X-Received: from plez10.prod.google.com ([2002:a17:902:ccca:b0:234:aa6d:999d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bac:b0:236:7165:6ecf
 with SMTP id d9443c01a7336-23ac465cb20mr71404775ad.38.1751052264186; Fri, 27
 Jun 2025 12:24:24 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:06 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-2-irogers@google.com>
Subject: [PATCH v1 01/12] perf parse-events: Warn if a cpu term is unsupported
 by a CPU
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor requested CPU warning out of evlist and into evsel. At the end
of adding an event, perform the warning check. To avoid repeatedly
testing if the cpu_list is empty, add a local variable.

```
$ perf stat -e cpu_atom/cycles,cpu=1/ -a true
WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cpu_atom/cycles/'

 Performance counter stats for 'system wide':

   <not supported>      cpu_atom/cycles/

       0.000781511 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c       | 15 +--------------
 tools/perf/util/evsel.c        | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h        |  2 ++
 tools/perf/util/parse-events.c | 12 ++++++++----
 4 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5664ebf6bbc6..a3c4d8558d29 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2546,20 +2546,7 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 		return;
 
 	evlist__for_each_entry(evlist, pos) {
-		struct perf_cpu_map *intersect, *to_test, *online = cpu_map__online();
-		const struct perf_pmu *pmu = evsel__find_pmu(pos);
-
-		to_test = pmu && pmu->is_core ? pmu->cpus : online;
-		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
-		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
-			char buf[128];
-
-			cpu_map__snprint(to_test, buf, sizeof(buf));
-			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
-				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
-		}
-		perf_cpu_map__put(intersect);
-		perf_cpu_map__put(online);
+		evsel__warn_user_requested_cpus(pos, user_requested_cpus);
 	}
 	perf_cpu_map__put(user_requested_cpus);
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..0208d999da24 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4071,3 +4071,27 @@ void evsel__uniquify_counter(struct evsel *counter)
 		counter->uniquified_name = false;
 	}
 }
+
+void evsel__warn_user_requested_cpus(struct evsel *evsel, struct perf_cpu_map *user_requested_cpus)
+{
+	struct perf_cpu_map *intersect, *online = NULL;
+	const struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	if (pmu && pmu->is_core) {
+		intersect = perf_cpu_map__intersect(pmu->cpus, user_requested_cpus);
+	} else {
+		online = cpu_map__online();
+		intersect = perf_cpu_map__intersect(online, user_requested_cpus);
+	}
+	if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
+		char buf1[128];
+		char buf2[128];
+
+		cpu_map__snprint(user_requested_cpus, buf1, sizeof(buf1));
+		cpu_map__snprint(online ?: pmu->cpus, buf2, sizeof(buf2));
+		pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
+			   buf1, pmu ? pmu->name : "cpu", buf2, evsel__name(evsel));
+	}
+	perf_cpu_map__put(intersect);
+	perf_cpu_map__put(online);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6dbc9690e0c9..8b5962a1e814 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -572,4 +572,6 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 
 bool evsel__is_offcpu_event(struct evsel *evsel);
 
+void evsel__warn_user_requested_cpus(struct evsel *evsel, struct perf_cpu_map *user_requested_cpus);
+
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d1965a7b97ed..7a32d5234a64 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -257,6 +257,7 @@ __add_event(struct list_head *list, int *idx,
 	struct evsel *evsel;
 	bool is_pmu_core;
 	struct perf_cpu_map *cpus;
+	bool has_cpu_list = !perf_cpu_map__is_empty(cpu_list);
 
 	/*
 	 * Ensure the first_wildcard_match's PMU matches that of the new event
@@ -281,7 +282,7 @@ __add_event(struct list_head *list, int *idx,
 
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
-		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
+		cpus = perf_cpu_map__get(has_cpu_list ? cpu_list : pmu->cpus);
 		perf_pmu__warn_invalid_formats(pmu);
 		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
 			perf_pmu__warn_invalid_config(pmu, attr->config, name,
@@ -296,10 +297,10 @@ __add_event(struct list_head *list, int *idx,
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
-		if (perf_cpu_map__is_empty(cpu_list))
-			cpus = is_pmu_core ? perf_cpu_map__new_online_cpus() : NULL;
-		else
+		if (has_cpu_list)
 			cpus = perf_cpu_map__get(cpu_list);
+		else
+			cpus = is_pmu_core ? cpu_map__online() : NULL;
 	}
 	if (init_attr)
 		event_attr_init(attr);
@@ -331,6 +332,9 @@ __add_event(struct list_head *list, int *idx,
 	if (list)
 		list_add_tail(&evsel->core.node, list);
 
+	if (has_cpu_list)
+		evsel__warn_user_requested_cpus(evsel, cpu_list);
+
 	return evsel;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog

