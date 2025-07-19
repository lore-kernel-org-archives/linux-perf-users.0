Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743C22D9E3
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894359; cv=none; b=HwUIpUYia1oTUOIx9IRl7x1sq69Cno6CVP7g28tCuRDjLizQ9OuNaaJWq8E86cb5YT612ZfT5jjkKGjbxLJedaOoL23OqFbedp98v/8pOFeO3pvdi/vURRj/Y3zB7voMUEPjO4AG1AzXB/QzplYKXm+MqBXwQ6/3ybmh1/xTGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894359; c=relaxed/simple;
	bh=KH6S1EVXcp2k9GpaDuxbo9DEpDyEC5StJ9+FpyEM40M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZfknJmjZzvZCFnX4n4clc5iaKSdzUZeBUNNkB8DbczkmNjALRnJqChiHT90ns+bS8yFF6QpIq/gR/xJnxaCdqEfjMsnj2404Hlbr6kDRXWTwEZ27hJx8hfbVr8Z0fS5JdFRFgtB2GsWfx+P6fh1jENJ6+47y+p6lpPgDWnt4+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KDpJz4d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KDpJz4d"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so2297103a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894356; x=1753499156; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEQY36OrLpdtDDbFz4O1+R1L/HhHBHEcsXBUC9UAOjs=;
        b=1KDpJz4dk33s5+qeUT8pyPEAPGMJ4Ek+dTnKvK3BUgR9tEjSyguxViTRvCjabQsbCy
         AP1V/brQAcfTlcSeXcXhW1jOXUg/voacGjZ5sGss+/QRZicVib8dc3TUfG3IYI8JDItZ
         IkVwex4WbR86U97AfOanqkY4vP8BEiyEYnGd1vprYvl47MFhpf4crKONyNnHyIaSQ4ir
         49N3pnad177ED0bvC25iPLNQj8R8bwOhDS1/Td9DvxDeeKTJyzOMzWzZRgJkk7rJBLVh
         Ci9DI91eq2p6UU1fLUcXnXky7l6WkdQRHFKMcXIDJqcZGhRwaGVOtCljPpyALHaxmf3q
         VHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894356; x=1753499156;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEQY36OrLpdtDDbFz4O1+R1L/HhHBHEcsXBUC9UAOjs=;
        b=L0HmpUz4yU5HbW4q+qPHOmGXdPDhVG/TqvLFDRA+N77DUCgEM1lHoyvem4xu01O4Dv
         KgT6VF7QH0XrhYU3msRyoLS1nPkC1mFBLBClTXVhlD6xgf/ukZ7FCICRhkzygFtjOuBO
         HIq9WTmxRDTxrIvdRl8ax6ACtWpSfAJvckfzVbtoa9hfySf8N2EvwySIdUL70OtJWzIr
         WOYyFB49PISHwUk1kQpY7WmAtfbleOIvLQHtKXSzQZ9nDFuE7srSgG+3IQs0uZCpfAX8
         JASt7Ha01f2YpttEmXmt06z2lRI86ERb+mqAwGJ7fMBQXXaA3k60ljPbdaRjEZ6ycMCb
         fueg==
X-Forwarded-Encrypted: i=1; AJvYcCUoz3xCpWXvRUo/kPmX/2+BYhPpScQ9ExZHr64n0zqvboFbAOs610B54jDi7z7/nGFlI4L2Nq8PhVy5fU/JIAVj@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnJ0A3QZLgEres+nD2Wz9U4XN5gxXYaxxAdo9BA2tdwxA4BRZ
	9kPx/EaTz0LFVWDs2f1r3NVh8bwt9PYpYBx5Ec9yMWZ29yNdNlQwlTQz/ndmDpYnI9UTqfUhuxX
	6muSa3AeESg==
X-Google-Smtp-Source: AGHT+IEjgLpESqb9x5G3AgQikzLLP8Ql1eepMkTRr1oFLDd9jCuc/7CRagtVBm1fNTsvWHcdziXRpggSRHAs
X-Received: from pjbsi4.prod.google.com ([2002:a17:90b:5284:b0:311:4aa8:2179])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8c:b0:316:3972:b9d0
 with SMTP id 98e67ed59e1d1-31c9e5fcacfmr20143537a91.0.1752894355693; Fri, 18
 Jul 2025 20:05:55 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:14 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-13-irogers@google.com>
Subject: [PATCH v3 12/15] perf parse-events: Support user CPUs mixed with threads/processes
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
 tools/lib/perf/evlist.c        | 119 ++++++++++++++++++++++-----------
 tools/perf/util/parse-events.c |  10 ++-
 tools/perf/util/stat.c         |   6 +-
 3 files changed, 87 insertions(+), 48 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9d9dec21f510..3ed023f4b190 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -36,49 +36,88 @@ void perf_evlist__init(struct perf_evlist *evlist)
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
+	    !evsel->requires_cpu &&
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
@@ -98,6 +137,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 
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

