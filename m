Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934D2EBBA2
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052275; cv=none; b=t5h5M40pAhlIjifcF6diDS8EjLs8I07MW6Zs/HJP0GLCe+wh0hcPh9UJmAuBCiGEy1Ukw/0So1vplchoimdB1XOJH4VjuEvceNcTJPbiWujqQ3thUt/wW28zrwnntqd+2zyw55T3Rky3Ccb+CMkKbd4Y0ceJ/dOrALrYawvLuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052275; c=relaxed/simple;
	bh=/4CLgBy/fjx97fBfSdwsj+wi3iZIrTBu+PBkAgAbVS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AvdUGmOITVMPNJg4BvsbM3bFT9eD9it3NI0GUJP+dFgo/vCHKAy+SImOTWbgxJniTollYENwlDV+U1Uq448CKHpf0YPX1DjXVaijthL4k65jd+JRZJvELt/z0kNubQOBUm5Q2jm4JRuP8pfMlTSqBKHWj38mSDawAlY2wKyeWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWKDWgy2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWKDWgy2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so219311a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052273; x=1751657073; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIK/VhL2jt+EzGvDP61su+RxHBQCsqze3SJLxs5udE0=;
        b=HWKDWgy24EIiZg2aeEYwAGkdGA2M/7F3GP/BkE1TC1AOVnUw5UzGEOYFZBt2BtbyUV
         mcrV4l7eXn28zSmpxrPfJDMVzyCxfWtY8eVzQfH5+hIASJgUC7M+DdSZwbGrMONT66Uh
         2LFSMgoacCGUWK8EgKnqJx5G0XMae5NA0reXlnxPkS2RMjMEIR/cFDqS+WbVXvhfR2aB
         upPEYwEkxMLqB+3GdqpK7Et0ILp06Aqewejg/Cltgpdxo8L43R525fVzWRrADWi7lIvf
         qrreyEcZ13cs3TlD61s/eASWc4T5JE6v9XeZ+1p4X8vLWUOYj+uSf8WhmqyBBeN6a3LN
         Vorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052273; x=1751657073;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIK/VhL2jt+EzGvDP61su+RxHBQCsqze3SJLxs5udE0=;
        b=tQuTEtjDVvy3nJFwDnmrcIIy7ZsQvgwZJLnGPFrfueBrXygjPlTEKmK79vh3Gamu5f
         eSInNhZuts8+q42ODvTSFRZJNmDC+wTIJB1gA9T3YW5xNF7JkMvVoJwdvmIyU8DKe1z+
         NmreyS45uSntumBypbkrTkRqMlpGn9noP8C5o0Nfvt/Vxylulk0kunD+u4OxdW9pDi0Q
         cKJrPv5cWi3DQF6TDDTFu3KP3JGeaS3hhm44wIo2atP38LqHydQowWA2tJQ9nSompi+J
         F8uv8lIuR3aAp3d7k1maukV2Qw+ZoIplACbtWAdwKrRl+7K7uyvgyj9spMaRM1Hu2Aga
         g3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUdVa8JH+FqnxNoih2I692Sa8jHjGILOtZ1SBxvtqKi8ARRmTHomFl585XwiOapCu1u/Sm8bqnZFS2crDEi5fje@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcXzcsx4Z+liarXz/yJiZ647KHxFEWu8PanheDB38hiX9vr02
	cYUrxpryAtU/zShY8fzQZonMboJOVKblzPozZqDRm9ut+qsbHL9SI1cTzQ8X/XLCMRrh6q5wojv
	xQt+lfQE5uw==
X-Google-Smtp-Source: AGHT+IFVUwapu1S9IeBoAD0gPx9hrv5lWJugnYAAaSx4EfmTs3M2GJ8ymqEp6hiwdZWAyVlF8uUXIUirzpZU
X-Received: from plbkz8.prod.google.com ([2002:a17:902:f9c8:b0:234:a0aa:5b34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244d:b0:237:d25b:8f07
 with SMTP id d9443c01a7336-23ac46527c1mr85394545ad.44.1751052273573; Fri, 27
 Jun 2025 12:24:33 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:11 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-7-irogers@google.com>
Subject: [PATCH v1 06/12] libperf evsel: Rename own_cpus to pmu_cpus
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

own_cpus is generally the cpumask from the PMU. Rename to pmu_cpus to
try to make this clearer. Variable rename with no other changes.

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
index 0208d999da24..8caee925bd4c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -487,7 +487,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 		return NULL;
 
 	evsel->core.cpus = perf_cpu_map__get(orig->core.cpus);
-	evsel->core.own_cpus = perf_cpu_map__get(orig->core.own_cpus);
+	evsel->core.pmu_cpus = perf_cpu_map__get(orig->core.pmu_cpus);
 	evsel->core.threads = perf_thread_map__get(orig->core.threads);
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
@@ -1526,7 +1526,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->core.own_cpus || evsel->unit)
+	if (evsel->core.pmu_cpus || evsel->unit)
 		evsel->core.attr.read_format |= PERF_FORMAT_ID;
 
 	/*
@@ -1670,7 +1670,7 @@ void evsel__exit(struct evsel *evsel)
 	evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->core.own_cpus);
+	perf_cpu_map__put(evsel->core.pmu_cpus);
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2dea35237e81..234641aa6b13 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4480,8 +4480,8 @@ int perf_event__process_event_update(const struct perf_tool *tool __maybe_unused
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
index ef38eb082342..a78a4bc4e8fe 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -323,7 +323,7 @@ __add_event(struct list_head *list, int *idx,
 
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

