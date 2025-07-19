Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0521FF4A
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894344; cv=none; b=IqnEYWpN0k74heCNbKrM+qBklPx+I5ywJDP/l7mruwDwYuVKeLgGv639lNi6ApaaKHMG1Fhprd6/yBTLk/VIrIEGo9WTA7VOXl+E53ujknKXatQqpr+ehNa0RwnYgRZD1mRGvLlGc5marNlCYOxCc2CE7S+6H+XzHY76dc3DKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894344; c=relaxed/simple;
	bh=5J3GWGp3X0qKm/PVDdnh3hIcgm2jxUOFfVXtpeT61dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gQEgS8en4hxX1HTV4N+gBIdsU2W0JxeBbDBuC1RlFI8ueix+r3mBQ9hAc7SPadf1Xp1jh9NMQRWRKUafk4NYSWFwslRr4P1KGphCjZVcdFBXk2vOXXBc5/KAihmd8mcFlyQejHSxLcL5W3uPDeMEgty+Om5GGOB2LKudg/OBfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSZmeqCc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSZmeqCc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235eefe6a8fso20982975ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894342; x=1753499142; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cEtMLLOSHTjrlHrzBNeeaYGWDamKeHqpltFXvpLlqk=;
        b=BSZmeqCcgzaUgTX+WEV5Ss1R5VSYCTtFYLUHpi/V+Pk/uCupWgbBo9HphjIY2K5bP9
         o8gqnubvsI0xw3K6HipW8iAp5n+VLrpOmypw/5OnXAWTdXPc/Ztv3urysbZTAAwBiFCt
         sFULRw+drfooXV4V1UMfC5PzKkbx89HRI5Vg8p4f47ZjU75o4VUr9CzgW2jS3egx31Uh
         aDmy0rGX0mEWq+ApUA9saDi/+puxSg/PLIPkSMEh0a14/JzgNW9u+8IqXGmQP+kiltcT
         zFMgioYfSe9wRPM9R/J+rqHAoP/X/JTwigIqJuGQT+fx/SlaxXhVr0A2cZatFSKWLiRy
         ywHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894342; x=1753499142;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cEtMLLOSHTjrlHrzBNeeaYGWDamKeHqpltFXvpLlqk=;
        b=fdZaX6+lmgD5C1FdH/ul1twOaJiLAi+AWL0orBPDJ+58uKBrNLSe9kew6+PIIiiZ8k
         KYiC4B/dX0exRYNRUvTIxY/mrsaZ897ojRYbCDfqaBVAygJ3cvG4SiBGgSC1U15c0Rjf
         d8fYjxluyjbjUaj9jOL3DniCv5nhpNoGPYhQQY8i34q6hrMw2v7STM5XP6VzR+3lq8JQ
         p3pfuCny47x7X3H7jRhH3XpUVWnjZ12Yj8zvR9GeJ7bn1n4UUNcHVcxEXS9DY0ncTH3U
         7Evk+X0v1mdURMQU0+EbG7UrG2amz+wno4BA8giUF0xgRYGGFx0i3PX5mUFvLL0Vg/pL
         twWw==
X-Forwarded-Encrypted: i=1; AJvYcCWcJKqsMOlYVUxCK5GS21cu1d8X6YGQH9PpcpjxZQGFpfqK7/cEsFwUXzkuNzvJi+CE0XpNMISPXQG3mm6ujnDl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9frKD9qmommPgJf7LANowO+O/ywV77/wmdtBgVXfL++hwMZ1i
	8xQwRNDUTFIgBBnjjlSlCWaHby7M4O5LfxBycsQZUuzrrYkeLSkmOopuaJK6wOnf8IVrzYVycEM
	iKx3XXY6KwA==
X-Google-Smtp-Source: AGHT+IG1h57zo4JiDzg/FBsTu/ZB2FkzD5xKCvN1jWhLb8fozoI3BRVnMYDIpY5b3Saf2yGkUfm3u7KE/8+w
X-Received: from pjbil4.prod.google.com ([2002:a17:90b:1644:b0:31c:c1a6:4452])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa3:b0:235:e76c:4362
 with SMTP id d9443c01a7336-23e3b79a5acmr55958335ad.18.1752894341814; Fri, 18
 Jul 2025 20:05:41 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:08 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-7-irogers@google.com>
Subject: [PATCH v3 06/15] libperf evsel: Rename own_cpus to pmu_cpus
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

own_cpus is generally the cpumask from the PMU. Rename to pmu_cpus to
try to make this clearer. Variable rename with no other changes.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                 |  8 ++++----
 tools/lib/perf/evsel.c                  |  2 +-
 tools/lib/perf/include/internal/evsel.h |  2 +-
 tools/perf/tests/event_update.c         |  4 ++--
 tools/perf/util/evsel.c                 |  6 +++---
 tools/perf/util/header.c                |  4 ++--
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/synthetic-events.c      |  4 ++--
 tools/perf/util/tool_pmu.c              | 12 ++++++------
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index b1f4c8176b32..9d9dec21f510 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -46,7 +46,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		 * are valid by intersecting with those of the PMU.
 		 */
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
+		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->pmu_cpus);
 
 		/*
 		 * Empty cpu lists would eventually get opened as "any" so remove
@@ -61,7 +61,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 				list_for_each_entry_from(next, &evlist->entries, node)
 					next->idx--;
 		}
-	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
+	} else if (!evsel->pmu_cpus || evlist->has_user_cpus ||
 		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
 		/*
 		 * The PMU didn't specify a default cpu map, this isn't a core
@@ -72,13 +72,13 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
-	} else if (evsel->cpus != evsel->own_cpus) {
+	} else if (evsel->cpus != evsel->pmu_cpus) {
 		/*
 		 * No user requested cpu map but the PMU cpu map doesn't match
 		 * the evsel's. Reset it back to the PMU cpu map.
 		 */
 		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
+		evsel->cpus = perf_cpu_map__get(evsel->pmu_cpus);
 	}
 
 	if (evsel->system_wide) {
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 2a85e0bfee1e..127abe7df63d 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -46,7 +46,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 	assert(evsel->mmap == NULL); /* If not munmap wasn't called. */
 	assert(evsel->sample_id == NULL); /* If not free_id wasn't called. */
 	perf_cpu_map__put(evsel->cpus);
-	perf_cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->pmu_cpus);
 	perf_thread_map__put(evsel->threads);
 	free(evsel);
 }
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index ea78defa77d0..b97dc8c92882 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -99,7 +99,7 @@ struct perf_evsel {
 	 * cpu map for opening the event on, for example, the first CPU on a
 	 * socket for an uncore event.
 	 */
-	struct perf_cpu_map	*own_cpus;
+	struct perf_cpu_map	*pmu_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
 	struct xyarray		*mmap;
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 9301fde11366..cb9e6de2e033 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,8 +109,8 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
-	perf_cpu_map__put(evsel->core.own_cpus);
-	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
+	perf_cpu_map__put(evsel->core.pmu_cpus);
+	evsel->core.pmu_cpus = perf_cpu_map__new("1,2,3");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d9b6bf78d67b..ba0c9799928b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -488,7 +488,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 		return NULL;
 
 	evsel->core.cpus = perf_cpu_map__get(orig->core.cpus);
-	evsel->core.own_cpus = perf_cpu_map__get(orig->core.own_cpus);
+	evsel->core.pmu_cpus = perf_cpu_map__get(orig->core.pmu_cpus);
 	evsel->core.threads = perf_thread_map__get(orig->core.threads);
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
@@ -1527,7 +1527,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->core.own_cpus || evsel->unit)
+	if (evsel->core.pmu_cpus || evsel->unit)
 		evsel->core.attr.read_format |= PERF_FORMAT_ID;
 
 	/*
@@ -1680,7 +1680,7 @@ void evsel__exit(struct evsel *evsel)
 	evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->core.own_cpus);
+	perf_cpu_map__put(evsel->core.pmu_cpus);
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53d54fbda10d..d941d7aa0f49 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4507,8 +4507,8 @@ int perf_event__process_event_update(const struct perf_tool *tool __maybe_unused
 	case PERF_EVENT_UPDATE__CPUS:
 		map = cpu_map__new_data(&ev->cpus.cpus);
 		if (map) {
-			perf_cpu_map__put(evsel->core.own_cpus);
-			evsel->core.own_cpus = map;
+			perf_cpu_map__put(evsel->core.pmu_cpus);
+			evsel->core.pmu_cpus = map;
 		} else
 			pr_err("failed to get event_update cpus\n");
 	default:
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a337e4d22ff2..d506f9943506 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -320,7 +320,7 @@ __add_event(struct list_head *list, int *idx,
 
 	(*idx)++;
 	evsel->core.cpus = cpus;
-	evsel->core.own_cpus = perf_cpu_map__get(cpus);
+	evsel->core.pmu_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->pmu = pmu;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2fc4d0537840..7c00b09e3a93 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2045,7 +2045,7 @@ int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struc
 int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel,
 					     perf_event__handler_t process)
 {
-	struct synthesize_cpu_map_data syn_data = { .map = evsel->core.own_cpus };
+	struct synthesize_cpu_map_data syn_data = { .map = evsel->core.pmu_cpus };
 	struct perf_record_event_update *ev;
 	int err;
 
@@ -2126,7 +2126,7 @@ int perf_event__synthesize_extra_attr(const struct perf_tool *tool, struct evlis
 			}
 		}
 
-		if (evsel->core.own_cpus) {
+		if (evsel->core.pmu_cpus) {
 			err = perf_event__synthesize_event_update_cpus(tool, evsel, process);
 			if (err < 0) {
 				pr_err("Couldn't synthesize evsel cpus.\n");
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 7aa4f315b0ac..d99e699e646d 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -357,10 +357,10 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *resu
 			/*
 			 * "Any CPU" event that can be scheduled on any CPU in
 			 * the PMU's cpumask. The PMU cpumask should be saved in
-			 * own_cpus. If not present fall back to max.
+			 * pmu_cpus. If not present fall back to max.
 			 */
-			if (!perf_cpu_map__is_empty(evsel->core.own_cpus))
-				*result = perf_cpu_map__nr(evsel->core.own_cpus);
+			if (!perf_cpu_map__is_empty(evsel->core.pmu_cpus))
+				*result = perf_cpu_map__nr(evsel->core.pmu_cpus);
 			else
 				*result = cpu__max_present_cpu().cpu;
 		}
@@ -386,12 +386,12 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *resu
 			/*
 			 * "Any CPU" event that can be scheduled on any CPU in
 			 * the PMU's cpumask. The PMU cpumask should be saved in
-			 * own_cpus, if not present then just the online cpu
+			 * pmu_cpus, if not present then just the online cpu
 			 * mask.
 			 */
-			if (!perf_cpu_map__is_empty(evsel->core.own_cpus)) {
+			if (!perf_cpu_map__is_empty(evsel->core.pmu_cpus)) {
 				struct perf_cpu_map *tmp =
-					perf_cpu_map__intersect(online, evsel->core.own_cpus);
+					perf_cpu_map__intersect(online, evsel->core.pmu_cpus);
 
 				*result = perf_cpu_map__nr(tmp);
 				perf_cpu_map__put(tmp);
-- 
2.50.0.727.gbf7dc18ff4-goog

