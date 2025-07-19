Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874C1E521A
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894335; cv=none; b=C2xFq1ZVE9b8a2r0w+kDMgy3pojnaHHKbZK6mNiDF6XFpSMXb1Ef4z/ZXP2zrC+58OUSVEzCJwi+XQeya7CNxng1WgguOW//h9I5CopgKLKodadmeA6q0wTe7/5rWRyJrJ1hxGhNpzOHbY8AjK+k9MqTVi/A9jbRqy329seQmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894335; c=relaxed/simple;
	bh=IZ1dP4fsOOPT7GVDaxQeOs0A2G/SQ78gec0XJFeHBGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hPEyWc4tfA+R9NdwmYIhFJv6H1vsgBeENGcScqbdPcrSZAYcQh+G/l1WTkZxHbxOW4vbl9DaC2qF+1sqoew8Mc4AqP1I2sC9soHaMHXj6ikX48ebVwNq/yRD2MFoODt/cc478DZMfGuS1p6AkhkV+fysGOPaXgK90HPH/oXNU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2EwRZuQe; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2EwRZuQe"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2f3bc8c5573so2711622fac.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894332; x=1753499132; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJyT4HLCqXHRxMmnshYz2066eN/wkiwo71q1NVZg9fs=;
        b=2EwRZuQeHaiQ4RuK7PONQ8MK168fqqniDkdNsuTkU+QxBjKErd9Utb1A9R9KBpPhcS
         3rvA4uAa3qt62X0UkrcqKu+CzqbUfkNS/H7DNTyZcc6qU/RIsJbrcYMbWf5BsEunPknP
         0cP2ukJLktQQlizs7+l1LvvA6aaMiIH4dYBqTxOPobmxTYsQaeZtxwSQGrPhoJ5L9mhN
         Nd830HXeIPyYIGlL/58iVluG3O2ZBpULdRTq4wZdVOLtYuDvA/kvF4r97MZjyGB30ARb
         eyrgjNU8ncITkyPtL26Prws+R2B6I2HMtuHho41E0ZF21jNJpZfk41DC2Wll19v0GufG
         t0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894332; x=1753499132;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJyT4HLCqXHRxMmnshYz2066eN/wkiwo71q1NVZg9fs=;
        b=jx6A0IpnlFsXZuJBgp7fAd1wuLY232nfiUFwQ/ey2qEJg47KnMMuCqiO3KNpDvWspE
         Nar8H8f4HzvBCN248nJz6kUUJIAG87siD0O8HxfJMBkqBdTyBA+FZV+s8WEKv15bwvHx
         JnHKtvnp8ix/tovcmaWIZ3xk+0Gwuf+wJAJ6ztD7GcT1d5BZ91od998iGK3kuLojZJbo
         15/cuUspMEwLcxuKbUKRsNUWUX576IchSqRP9Tzki6Rexq5NWscJxIuUaBFqfUsHqEMI
         VTrSqrZFvJ2/j3afaKmOdrbn1geAeHBWc0XJPUdOw1Y8idBlMQ6NjqW3pb9oogIpkIHP
         11tg==
X-Forwarded-Encrypted: i=1; AJvYcCW8zUBkGNeCU28xER3BBa8C1u7a+PYvkwU3u4xEBBaz6UizT7QzCPurdfxAKbQY886hhtF9tPofOF5RQNxSGA6L@vger.kernel.org
X-Gm-Message-State: AOJu0YywjAwfd8pfQtsPOx4y7x1Jusuxj6LdmmBmsARGWbmikGmuaL8N
	w9MIiX4qrPJ/N/lkoLfdLJR1mtbthbmUT6yQdRafoEmW5VziJFYndG6WbU9y8SaVrncdX13qqJi
	871gPjotXXA==
X-Google-Smtp-Source: AGHT+IGvucAyfOt+rnCRQE+RnfkOqny0fkGZY23GJuXWeAKQUZUS6CyLJ7eDt3lkYe/k8/LtvWQNhcF+RN3h
X-Received: from oabsa17.prod.google.com ([2002:a05:6871:2111:b0:2ef:e9aa:27e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:f603:b0:2ff:94d7:b006
 with SMTP id 586e51a60fabf-2ffb2251036mr9833040fac.13.1752894332424; Fri, 18
 Jul 2025 20:05:32 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:03 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-2-irogers@google.com>
Subject: [PATCH v3 01/15] perf parse-events: Warn if a cpu term is unsupported
 by a CPU
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

