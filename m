Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD0247291
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786181; cv=none; b=ZEVDmGmLMsKHRAKYY9enMeIUQY3JFeaRhgb2Ufhp0+K8B+TZ8o5C8JgZRW1CQ0IZNWxIQrAHTdPq2YrrkyP3Bp8nCOU0vi8amXOHOMJNmoBA46ay+14xRXFlBYUOnoAyhPiCwWulc8RXjJyNZL3uH9dcIU6o7TzkmTEM945n4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786181; c=relaxed/simple;
	bh=IZ1dP4fsOOPT7GVDaxQeOs0A2G/SQ78gec0XJFeHBGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aDEtJ/xoBALCrh/Y9pwfdXI6t8yugSz3AWSK6tE0skX6YPqQCBeZFMwQlUafRc/V6aAX9KUupB6adNmrPYV5Rwxd05ZXY2cpChLeaD2aMFffn7Q67yI0CogRY+uZmrft9J5djTJFWxy1MiKa/GSdmgb8yJXjmn8yTHegG3uS5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OA6JqKBR; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA6JqKBR"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e33af599bcso233436885a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786178; x=1753390978; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJyT4HLCqXHRxMmnshYz2066eN/wkiwo71q1NVZg9fs=;
        b=OA6JqKBRlJxTh/aFvs1pio9VTmUYnZZFO881boQuyV+BY+C7P9Yzje22cy+8KhqSmt
         HYqaHjxiWPi8Nwtv1t2keFyCj6BF3M08xTxGYnXyR5bSNVjvhBVtyQmIzYmGTcu21v1/
         K2T2GEq4EG9q/+eaZhDMxYn3qdyvZCR/DzJQPNBxPdFcxip8YcYlB4OPBP64SngAaP+r
         7I9aquuiXrYIT8zjJlCy6j8PLe1DEwUS2HoAeSS4ykNdg7ZiNRL0XulBQwhgtKTvIcqN
         H4sn4jG3ZnkLRtWhXXnBGvWXsGUqt8BJRxbcF9fI4TKuLoiyL17jG0jNEBbJS0pgGW31
         Mgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786178; x=1753390978;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJyT4HLCqXHRxMmnshYz2066eN/wkiwo71q1NVZg9fs=;
        b=NQXQENQ8VZOsFkcApzWZiDuK4PuPMH1a/8dLyK+zUgxBzLQjJg9vCp1EbLUbQuagMR
         xIagxKCGM3uUT0D+7HWx4TCps0yZzMvA0/MxEP6H+ikdMgOYLK+TlqTNShAK/n6lS9cB
         le07ZRgt3YHFOYAqAYDwu/B9gNU6oM7GXyjvSM1aGWggwtbESPcVZjDLTfxnwXx7vejt
         i8PXFNSxK5NBzUILDBeKHuilvVPcv/0FqbNng3G+rR7DRpySrl3CUyS2OlmSlbAUZ8kt
         1PNvefRSrc1ZqcCT4jELSQkjeyABSYHPdBSSYJ4DscEewrsB9hTjQfoxfjM5JqZCqg/j
         MrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXERh7tV2AfQS6N+5ousMXyoBNk3iuOE0O8RCIsTWUrFc3ziX9wBp+wcuG+oNnASANDnLWQy0VLnQ55aIMdWZYc@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzSjTSL4SzlqujlRu7jjMoYjEO5oS798t+NDjl6lgEt4QVAG5
	RSl2R3l2E7TC+T/Vvg+QMN9kl+KinJGDDWmL0mCUQI3lwJoemTGFb9Yy8/Jx881deM4BfpD9KZ6
	aHwhMkj6iPg==
X-Google-Smtp-Source: AGHT+IFvJUdN2LoRlCp7zjevHjV8W0jDJbhWqJ+H1qjSiTAF99L0cjVkdvAxGZJH83D2GJXVolUxKi7VVswZ
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f87:b0:311:abba:53d2
 with SMTP id 98e67ed59e1d1-31caf8db642mr6789448a91.17.1752786159527; Thu, 17
 Jul 2025 14:02:39 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:22 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-2-irogers@google.com>
Subject: [PATCH v2 01/12] perf parse-events: Warn if a cpu term is unsupported
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

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c       | 15 +--------------
 tools/perf/util/evsel.c        | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h        |  2 ++
 tools/perf/util/parse-events.c | 12 ++++++++----
 4 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 995ad5f654d0..80d8387e6b97 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2549,20 +2549,7 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
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
index 3896a04d90af..d9b6bf78d67b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4091,3 +4091,27 @@ void evsel__uniquify_counter(struct evsel *counter)
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
index b84ee274602d..cefa8e64c0d5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -574,4 +574,6 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 
 bool evsel__is_offcpu_event(struct evsel *evsel);
 
+void evsel__warn_user_requested_cpus(struct evsel *evsel, struct perf_cpu_map *user_requested_cpus);
+
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a59ae5ca0f89..3fd6cc0c2794 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -252,6 +252,7 @@ __add_event(struct list_head *list, int *idx,
 	struct evsel *evsel;
 	bool is_pmu_core;
 	struct perf_cpu_map *cpus;
+	bool has_cpu_list = !perf_cpu_map__is_empty(cpu_list);
 
 	/*
 	 * Ensure the first_wildcard_match's PMU matches that of the new event
@@ -276,7 +277,7 @@ __add_event(struct list_head *list, int *idx,
 
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
-		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
+		cpus = perf_cpu_map__get(has_cpu_list ? cpu_list : pmu->cpus);
 		perf_pmu__warn_invalid_formats(pmu);
 		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
 			perf_pmu__warn_invalid_config(pmu, attr->config, name,
@@ -291,10 +292,10 @@ __add_event(struct list_head *list, int *idx,
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
@@ -326,6 +327,9 @@ __add_event(struct list_head *list, int *idx,
 	if (list)
 		list_add_tail(&evsel->core.node, list);
 
+	if (has_cpu_list)
+		evsel__warn_user_requested_cpus(evsel, cpu_list);
+
 	return evsel;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog

