Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE7259C93
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786184; cv=none; b=CmtyHlQXa94X0MziH0eL38h2Vn5FmUcPL7v9ZwQbRKS5XKPOB14FXlzc6HuKOOPzroUa12kmnysnr/95wK1KCmIvJaV84g2TSvKKqG/iceU8rJ9ZnNC2mFFwbf4+eIp/99dcdA/4K//x1S8MEY9Ik9HRe3o+Kx2WGoVx35Sw2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786184; c=relaxed/simple;
	bh=ILKxxdhVKBL3H3T+k9tCVz/84PR5Y8ZVsZPuSrjtHFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hnEVQwijPi5CFejUGLpnxzcgfGck9gZXP8TIEHVp1WZLX+NkZGJ6/TleOAnsjSCpOcFMBULOpLeMR2yfWrC6hQJLMHvnn1EOtO0x/itLNokECKxLlUTRPSclGekzJXNUJyMPkRujTr6gY11ErKus3a61v/TGs9ngeHJjqh+axfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POjGQDLr; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POjGQDLr"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-300254d9399so924725fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786181; x=1753390981; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HU89/GZC9oprC8rhKi3nOVfsuM3lRbUuTtm8KmujE+I=;
        b=POjGQDLrL0x4MJMu6yyzNob/C2dPMptPTib52VWDLh0C6lISoT9Tq4EogWhZu2tFWg
         NDinC10s7cGz8vb+NYZvC8rR1RxlgNShWbUjOVITyvxp2I6ePH0X0Bo+iIb8THKrH+V1
         aSUKh6yetGiT6bTTf8CgwfEljG+LS0TeEQ8N9XHJ9dP+WQKZ7kMiqwklMAwsMpBzEHvn
         sKXcskbSVpBsX6cg4d5gz+19eecUrCDgknEblP1YIxP3t2Q/oGqJvF3XF2GLq4ek8riH
         Fo/GFrWn903+kXAj3NnTKSIcmX/iVwpAgE/jZ6Tfi1Gr4DKySkvGUhmyHG8uNIuoGnV2
         7YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786181; x=1753390981;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HU89/GZC9oprC8rhKi3nOVfsuM3lRbUuTtm8KmujE+I=;
        b=QoWs35Je3jSxazzvkEESrb8o2F8muZ/luFSMaLiSrAdMvd38TUZ0tOw3+wqdjCFbrf
         9rw1XDBR52DI7o0//bE/EqTHRR0NZ75Y2jqxVuACffxJK2noreZ3CDqeVzlxQselDitQ
         kOf7ZQfoXEKEFfFeZrtC97BjGC2YIhJ52fuj0YAKriD/YcU4jyMjwKcmIiX36rcIKQ9S
         KwGYb+Dl4/Oz/DZ5Rrsct9J1N29BrgKfkqzLIxKDMqb0P0oVnAj34oHslFioTxD5axNd
         3IbzeyMoCwhmgTsZMLqdHLg7fSZGqaMspRAJYQ+KWnfysNCcXG6OGiWsk7pEuyPVISeT
         Q3eA==
X-Forwarded-Encrypted: i=1; AJvYcCULif1574HGfuPt3Ep1OOIJ4jFpMDi2S5Ocx2K2s2cQ0O9AMsaORpOoCWRiSm5nMPnUcSfcf9e9vZD3TSx2iHdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtSDNmy7TKUoP7CmeKQ5rtnd4ji7+tFwCEuA3N9nxpVjlmkbM
	8YX1h3hxm/Pag5BJ0KDL6m6+Fz/NgbjTlyiQSgUEe/lHHfzWH8R6DZBP2HlksfTcg+4gZXQ4OOG
	MjL5y1b1yTQ==
X-Google-Smtp-Source: AGHT+IHigQdoOyZEy7c9tzzUz/1uR4HwaqALfA65QRdvTfANkkr3uJO1yLb6/cTnCmoAffWT+V9K2E+kwQyC
X-Received: from oabrk3.prod.google.com ([2002:a05:6871:64c3:b0:2f7:9168:24fd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d207:b0:2ea:7574:e243
 with SMTP id 586e51a60fabf-2ffaf2bf7aemr6970652fac.9.1752786181359; Thu, 17
 Jul 2025 14:03:01 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:33 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-13-irogers@google.com>
Subject: [PATCH v2 12/12] perf parse-events: Support user CPUs mixed with threads/processes
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

Counting events system-wide with a specified CPU prior to this change
worked:
```
$ perf stat -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' -a sleep 1

  Performance counter stats for 'system wide':

     59,393,419,099      msr/tsc/
     33,927,965,927      msr/tsc,cpu=cpu_core/
     25,465,608,044      msr/tsc,cpu=cpu_atom/
```

However, when counting with process the counts became system wide:
```
$ perf stat -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
 10.1: Basic parsing test                                            : Ok
 10.2: Parsing without PMU name                                      : Ok
 10.3: Parsing with PMU name                                         : Ok

 Performance counter stats for 'perf test -F 10':

        59,233,549      msr/tsc/
        59,227,556      msr/tsc,cpu=cpu_core/
        59,224,053      msr/tsc,cpu=cpu_atom/
```

Make the handling of CPU maps with event parsing clearer. When an
event is parsed creating an evsel the cpus should be either the PMU's
cpumask or user specified CPUs.

Update perf_evlist__propagate_maps so that it doesn't clobber the user
specified CPUs. Try to make the behavior clearer, firstly fix up
missing cpumasks. Next, perform sanity checks and adjustments from the
global evlist CPU requests and for the PMU including simplifying to
the "any CPU"(-1) value. Finally remove the event if the cpumask is
empty.

So that events are opened with a CPU and a thread change stat's
create_perf_stat_counter to give both.

With the change things are fixed:
```
$ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
 10.1: Basic parsing test                                            : Ok
 10.2: Parsing without PMU name                                      : Ok
 10.3: Parsing with PMU name                                         : Ok

 Performance counter stats for 'perf test -F 10':

        63,704,975      msr/tsc/
        47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
        16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
```

However, note the "--no-scale" option is used. This is necessary as
the running time for the event on the counter isn't the same as the
enabled time because the thread doesn't necessarily run on the CPUs
specified for the counter. All counter values are scaled with:

  scaled_value = value * time_enabled / time_running

and so without --no-scale the scaled_value becomes very large. This
problem already exists on hybrid systems for the same reason. Here are
2 runs of the same code with an instructions event that counts the
same on both types of core, there is no real multiplexing happening on
the event:

```
$ perf stat -e instructions perf test -F 10
...
 Performance counter stats for 'perf test -F 10':

        87,896,447      cpu_atom/instructions/                       (14.37%)
        98,171,964      cpu_core/instructions/                       (85.63%)
...
$ perf stat --no-scale -e instructions perf test -F 10
...
 Performance counter stats for 'perf test -F 10':

        13,069,890      cpu_atom/instructions/                       (19.32%)
        83,460,274      cpu_core/instructions/                       (80.68%)
...
```
The scaling has inflated per-PMU instruction counts and the overall
count by 2x.

To fix this the kernel needs changing when a task+CPU event (or just
task event on hybrid) is scheduled out. A fix could be that the state
isn't inactive but off for such events, so that time_enabled counts
don't accumulate on them.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c        | 118 ++++++++++++++++++++++-----------
 tools/perf/util/parse-events.c |  10 ++-
 tools/perf/util/stat.c         |   6 +-
 3 files changed, 86 insertions(+), 48 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9d9dec21f510..2d2236400220 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -36,49 +36,87 @@ void perf_evlist__init(struct perf_evlist *evlist)
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 					  struct perf_evsel *evsel)
 {
-	if (evsel->system_wide) {
-		/* System wide: set the cpu map of the evsel to all online CPUs. */
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__new_online_cpus();
-	} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
-		/*
-		 * User requested CPUs on a core PMU, ensure the requested CPUs
-		 * are valid by intersecting with those of the PMU.
-		 */
+	if (perf_cpu_map__is_empty(evsel->cpus)) {
+		if (perf_cpu_map__is_empty(evsel->pmu_cpus)) {
+			/*
+			 * Assume the unset PMU cpus were for a system-wide
+			 * event, like a software or tracepoint.
+			 */
+			evsel->pmu_cpus = perf_cpu_map__new_online_cpus();
+		}
+		if (evlist->has_user_cpus && !evsel->system_wide) {
+			/*
+			 * Use the user CPUs unless the evsel is set to be
+			 * system wide, such as the dummy event.
+			 */
+			evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
+		} else {
+			/*
+			 * System wide and other modes, assume the cpu map
+			 * should be set to all PMU CPUs.
+			 */
+			evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
+		}
+	}
+	/*
+	 * Avoid "any CPU"(-1) for uncore and PMUs that require a CPU, even if
+	 * requested.
+	 */
+	if (evsel->requires_cpu && perf_cpu_map__has_any_cpu(evsel->cpus)) {
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->pmu_cpus);
+		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
+	}
 
-		/*
-		 * Empty cpu lists would eventually get opened as "any" so remove
-		 * genuinely empty ones before they're opened in the wrong place.
-		 */
-		if (perf_cpu_map__is_empty(evsel->cpus)) {
-			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
-
-			perf_evlist__remove(evlist, evsel);
-			/* Keep idx contiguous */
-			if (next)
-				list_for_each_entry_from(next, &evlist->entries, node)
-					next->idx--;
+	/*
+	 * Globally requested CPUs replace user requested unless the evsel is
+	 * set to be system wide.
+	 */
+	if (evlist->has_user_cpus && !evsel->system_wide) {
+		assert(!perf_cpu_map__has_any_cpu(evlist->user_requested_cpus));
+		if (!perf_cpu_map__equal(evsel->cpus, evlist->user_requested_cpus)) {
+			perf_cpu_map__put(evsel->cpus);
+			evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 		}
-	} else if (!evsel->pmu_cpus || evlist->has_user_cpus ||
-		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
-		/*
-		 * The PMU didn't specify a default cpu map, this isn't a core
-		 * event and the user requested CPUs or the evlist user
-		 * requested CPUs have the "any CPU" (aka dummy) CPU value. In
-		 * which case use the user requested CPUs rather than the PMU
-		 * ones.
-		 */
+	}
+
+	/* Ensure cpus only references valid PMU CPUs. */
+	if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
+	    !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
+		struct perf_cpu_map *tmp = perf_cpu_map__intersect(evsel->pmu_cpus, evsel->cpus);
+
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
-	} else if (evsel->cpus != evsel->pmu_cpus) {
-		/*
-		 * No user requested cpu map but the PMU cpu map doesn't match
-		 * the evsel's. Reset it back to the PMU cpu map.
-		 */
+		evsel->cpus = tmp;
+	}
+
+	/*
+	 * Was event requested on all the PMU's CPUs but the user requested is
+	 * any CPU (-1)? If so switch to using any CPU (-1) to reduce the number
+	 * of events.
+	 */
+	if (!evsel->system_wide &&
+	    perf_cpu_map__equal(evsel->cpus, evsel->pmu_cpus) &&
+	    perf_cpu_map__has_any_cpu(evlist->user_requested_cpus)) {
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
+		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
+	}
+
+	/* Sanity check assert before the evsel is potentially removed. */
+	assert(!evsel->requires_cpu || !perf_cpu_map__has_any_cpu(evsel->cpus));
+
+	/*
+	 * Empty cpu lists would eventually get opened as "any" so remove
+	 * genuinely empty ones before they're opened in the wrong place.
+	 */
+	if (perf_cpu_map__is_empty(evsel->cpus)) {
+		struct perf_evsel *next = perf_evlist__next(evlist, evsel);
+
+		perf_evlist__remove(evlist, evsel);
+		/* Keep idx contiguous */
+		if (next)
+			list_for_each_entry_from(next, &evlist->entries, node)
+				next->idx--;
+
+		return;
 	}
 
 	if (evsel->system_wide) {
@@ -98,6 +136,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 
 	evlist->needs_map_propagation = true;
 
+	/* Clear the all_cpus set which will be merged into during propagation. */
+	perf_cpu_map__put(evlist->all_cpus);
+	evlist->all_cpus = NULL;
+
 	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index bd2d831d5123..fe2073c6b549 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -310,20 +310,18 @@ __add_event(struct list_head *list, int *idx,
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
 		pmu_cpus = perf_cpu_map__get(pmu->cpus);
+		if (perf_cpu_map__is_empty(pmu_cpus))
+			pmu_cpus = cpu_map__online();
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
 		pmu_cpus = is_pmu_core ? cpu_map__online() : NULL;
 	}
 
-	if (has_user_cpus) {
+	if (has_user_cpus)
 		cpus = perf_cpu_map__get(user_cpus);
-		/* Existing behavior that pmu_cpus matches the given user ones. */
-		perf_cpu_map__put(pmu_cpus);
-		pmu_cpus = perf_cpu_map__get(user_cpus);
-	} else {
+	else
 		cpus = perf_cpu_map__get(pmu_cpus);
-	}
 
 	if (init_attr)
 		event_attr_init(attr);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index b0205e99a4c9..50b1a92d16df 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -769,8 +769,6 @@ int create_perf_stat_counter(struct evsel *evsel,
 			attr->enable_on_exec = 1;
 	}
 
-	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu_map_idx);
-
-	return evsel__open_per_thread(evsel, evsel->core.threads);
+	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
+					      evsel->core.threads);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

