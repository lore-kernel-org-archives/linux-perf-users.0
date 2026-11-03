Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749516;
	b=sFEGPKEC/inMKfdvSh6IsVPyNDD+kpC9VzzEzlT4yqbtQjUI6nMwhlsQozxalLIR1bYf
	 iV6vUWYO77W//5aYHxjUkDnULOR0F27P23Fryq9EWUSYLoTuCdJZCJBG0NuE3BT1kzO/G
	 lhQ+dNWgp2p7bm1yKUuf8jZQ/B8IbtpE99tddF0+ifs0ME79XlvMfLQUZod18OVfRvaoS
	 IA/61KsPuqwlH3HtUNsYPVLEk79ndWBgYD1SyisBLk5gqJC8kmu36tdGZNIbOf/J3paPv
	 IF4URh+tVC+qCoHZPMIGrraTTyOfdbmM/i6iuib5//rBOSQhnZUK2HwibOXthhVrEuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=AP3n1pmMCFqhOzrxZaVg0Ftl7DARlR5jn0d9YEc0Ef4=;
	b=AIJtsu6XeLRoirhzvxGGTRLHDI2vV6CzOCFSEzE4GYX/99bHVKFlDT502RbK5UL0Rk1X
	 XxdFBaeVs2caIR//zE3R1gjrwUjX8jg9XEgyqBLTEZ2TLBgYNmV3IHqUgKHBGIGuXI5QJ
	 DN57Uh+ZBKSEHWThH95bUFrWbdJNiDXR+jz0mftchhGrvfcGAFYyt20gHCA+Mvk0J+hgX
	 rj0LG6AfayKpxErI+I19LE1+nJHxJlHPDBVSdzff3tpD+vEgevjSCp2z/SBlw9ewb/ri3
	 RJNw0tVxwK/xmMC8yDqNhEZV4RPHm5ZquMwCemzPAbf/XH7qR3CPUBuLgyi/cTd/otQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CZhI4MMz;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28999606A338
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28999606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CZhI4MMz
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so300126eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749515; x=1794354315; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AP3n1pmMCFqhOzrxZaVg0Ftl7DARlR5jn0d9YEc0Ef4=;
        b=CZhI4MMzHpmMtiRXUnnG/vN+ndWqGnYngKhP1ZcrG7D0VrzNKiBZYv3Wv+0rwlgT16
         7lqmTu509txNo6lYbXGwgNTrdkt4TkZGbA3yYF7Gp3iVme+tzq7XKLbEkjodJoErH6mN
         zLluV+C2iaFnFOrJvmpKDKoFcEEbkdH6XUeS9TDPuH9t+0Ay8mi4BIv+bKENq3WLeozy
         mCAxkNC71Ic2T8Ng7V+Krxw6RpqXFCsaYmuFNzjdY6qjQUy6+y6vkGQEzMuPfJEPvCj0
         6ttT1X7odN8i6NJR60z+ENXh+VFCdGggg4jfDDI8ZjhMqaSApuj3UMn8as9+aJeXWRJN
         hrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749515; x=1794354315;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AP3n1pmMCFqhOzrxZaVg0Ftl7DARlR5jn0d9YEc0Ef4=;
        b=MvK9SdaaqR8IcMksmC7IT7owjSGXWDZhiLX4eC5nH0Z1MSFHVPjOLM57mICzpqNdPE
         hEC7oLbly0CahVHCu/ffbHF+IG/LvVC1kWwjJpP32hVn5l6G/j4lWCgM3JjjaPaBSuFu
         8EwjIYLAdS4A0ZeVj9PREOs/4fDygHaCLA66GAZ7bEtkMM8Zcc9m68gow7shZYuNF+5/
         4Cf0MIk2RwWlan+C4g/c95ZVGnMOBI8lgUDmb5CEr3jsgA99ASTSBivF0bsky7lx8BPW
         5fm6jnX2WKCe+c7Ii10cDOTRyqBrfxrbf0+0C0wYNATGmO66FpHBB24Qp3DljhP1al+P
         BtnA==
X-Gm-Message-State: APuU4Z/DxKo/NrIUPvwprdWvk70ssGIETe1CDjOGh5ojYD8DED38sE+g
	opdi50xFdpe2b2AkHOkI+x2fqU3HEgzqYq/EfVJRK7lpxROz7/R3PNmAGbHDoFC4fQLeHWsEA3r
	QkeAJXTKgRQ1zIOFlojAh/Im/lBi0xThK8l2K2Bnd3qJnQiJcbpU7VOSJd0aNWdcHrPY9UmX3f9
	Dk9SFdtbfYUH8hhX5pWKdp/WFhEbPJGsqRwb5jBtT16fXJz5sjVs9gJgY=
X-Received: from dlbqc2.prod.google.com ([2002:a05:7023:a82:b0:194:c5c4:fa82])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2582:b0:1ae:e0f5:2cdd
 with SMTP id a92af1059eb24-1aee0f52cf9mr21250364c88.28.1793749514613; Tue, 03
 Nov 2026 15:45:14 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:19 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-4-irogers@google.com>
Subject: [PATCH v1 03/41] perf pmu: Add from_env parameter to perf_pmu__init()
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a boolean from_env field to struct perf_pmu initialized via
perf_pmu__init() to distinguish PMUs reconstructed from perf_env
headers from live host PMUs. Guard tp_pmu, hwmon_pmu, and drm_pmu
callbacks on !pmu->from_env so perf.data-derived PMUs do not access
host tracepoints or cast plain struct perf_pmu allocations via
container_of().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c |  4 ++--
 tools/perf/util/drm_pmu.c     | 14 ++++++++----
 tools/perf/util/hwmon_pmu.c   | 14 ++++++++----
 tools/perf/util/pmu.c         | 41 +++++++++++++++++++----------------
 tools/perf/util/pmu.h         | 13 ++++++++++-
 tools/perf/util/tool_pmu.c    |  2 +-
 6 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e6e4f4cf1fa2..acf8e8ee1237 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -514,7 +514,7 @@ static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
 	if (!pmu)
 		return -1;
 
-	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, pmu_name) != 0) {
+	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, pmu_name, /*from_env=*/false) != 0) {
 		perf_pmu__delete(pmu);
 		return -1;
 	}
@@ -566,7 +566,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	if (!pmu)
 		return -1;
 
-	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, test_pmu->pmu_name) != 0) {
+	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, test_pmu->pmu_name, /*from_env=*/false) != 0) {
 		perf_pmu__delete(pmu);
 		return -1;
 	}
diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index b8badae7015c..cbbd5aafd24b 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -68,7 +68,7 @@ bool perf_pmu__is_drm(const struct perf_pmu *pmu)
 
 bool evsel__is_drm(const struct evsel *evsel)
 {
-	return perf_pmu__is_drm(evsel->pmu);
+	return perf_pmu__is_drm(evsel->pmu) && !evsel->pmu->from_env;
 }
 
 static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t line_len)
@@ -116,7 +116,7 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 	if (!drm)
 		return NULL;
 
-	if (perf_pmu__init(&drm->pmu, type, name) != 0) {
+	if (perf_pmu__init(&drm->pmu, type, name, /*from_env=*/false) != 0) {
 		perf_pmu__delete(&drm->pmu);
 		return NULL;
 	}
@@ -658,11 +658,17 @@ static uint64_t drm_pmu__read_for_pid(struct drm_pmu *drm, struct evsel *evsel,
 
 int evsel__drm_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	struct drm_pmu *drm = container_of(evsel->pmu, struct drm_pmu, pmu);
+	struct drm_pmu *drm;
 	struct perf_counts_values *count, *old_count = NULL;
-	int pid = perf_thread_map__pid(evsel->core.threads, thread);
+	int pid;
 	uint64_t counter;
 
+	if (!evsel->pmu || evsel->pmu->from_env)
+		return -EINVAL;
+
+	drm = container_of(evsel->pmu, struct drm_pmu, pmu);
+	pid = perf_thread_map__pid(evsel->core.threads, thread);
+
 	if (pid != -1)
 		counter = drm_pmu__read_for_pid(drm, evsel, pid);
 	else
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 96aeb379e169..fab9f09d0253 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -132,7 +132,7 @@ bool perf_pmu__is_hwmon(const struct perf_pmu *pmu)
 
 bool evsel__is_hwmon(const struct evsel *evsel)
 {
-	return perf_pmu__is_hwmon(evsel->pmu);
+	return perf_pmu__is_hwmon(evsel->pmu) && !evsel->pmu->from_env;
 }
 
 static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe_unused)
@@ -365,7 +365,7 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 	if (!hwm)
 		return NULL;
 
-	if (perf_pmu__init(&hwm->pmu, type, buf) != 0) {
+	if (perf_pmu__init(&hwm->pmu, type, buf, /*from_env=*/false) != 0) {
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
 	}
@@ -763,12 +763,18 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 			  struct perf_thread_map *threads,
 			  int start_cpu_map_idx, int end_cpu_map_idx)
 {
-	struct hwmon_pmu *hwm = container_of(evsel->pmu, struct hwmon_pmu, pmu);
+	struct hwmon_pmu *hwm;
 	union hwmon_pmu_event_key key = {
 		.type_and_num = evsel->core.attr.config,
 	};
 	int idx = 0, thread = 0, nthreads, err = 0;
-	int dir = open(hwm->hwmon_dir, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
+	int dir;
+
+	if (!evsel->pmu || evsel->pmu->from_env)
+		return -EINVAL;
+
+	hwm = container_of(evsel->pmu, struct hwmon_pmu, pmu);
+	dir = open(hwm->hwmon_dir, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
 
 	if (dir < 0)
 		return -errno;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..531641e66ef4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1188,9 +1188,10 @@ static bool aliases__equal(long key1, long key2, void *ctx __maybe_unused)
 	return strcasecmp((const char *)key1, (const char *)key2) == 0;
 }
 
-int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
+int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name, bool from_env)
 {
 	pmu->type = type;
+	pmu->from_env = from_env;
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->caps);
 
@@ -1240,7 +1241,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (!pmu)
 		return NULL;
 
-	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, name) != 0) {
+	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, name, /*from_env=*/false) != 0) {
 		perf_pmu__delete(pmu);
 		return NULL;
 	}
@@ -1695,9 +1696,9 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 	struct parse_events_term *term;
 
 	if (perf_pmu__is_hwmon(pmu))
-		return hwmon_pmu__config_terms(pmu, attr, terms, err);
+		return pmu->from_env ? -EINVAL : hwmon_pmu__config_terms(pmu, attr, terms, err);
 	if (perf_pmu__is_drm(pmu))
-		return drm_pmu__config_terms(pmu, attr, terms, err);
+		return pmu->from_env ? -EINVAL : drm_pmu__config_terms(pmu, attr, terms, err);
 
 	list_for_each_entry(term, &terms->terms, list) {
 		if (pmu_config_term(pmu, attr, term, terms, zero, apply_hardcoded, err))
@@ -1857,11 +1858,11 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	info->retirement_latency_max = 0.0;
 
 	if (perf_pmu__is_hwmon(pmu)) {
-		ret = hwmon_pmu__check_alias(head_terms, info, err);
+		ret = pmu->from_env ? 0 : hwmon_pmu__check_alias(head_terms, info, err);
 		goto out;
 	}
 	if (perf_pmu__is_drm(pmu)) {
-		ret = drm_pmu__check_alias(pmu, head_terms, info, err);
+		ret = pmu->from_env ? 0 : drm_pmu__check_alias(pmu, head_terms, info, err);
 		goto out;
 	}
 
@@ -2118,11 +2119,11 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
 		return false;
 	if (perf_pmu__is_tracepoint(pmu))
-		return tp_pmu__have_event(pmu, name);
+		return pmu->from_env ? false : tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
-		return hwmon_pmu__have_event(pmu, name);
+		return pmu->from_env ? false : hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
-		return drm_pmu__have_event(pmu, name);
+		return pmu->from_env ? false : drm_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || (!pmu->events_table && !pmu->is_core))
@@ -2139,11 +2140,11 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	size_t nr;
 
 	if (perf_pmu__is_tracepoint(pmu))
-		return tp_pmu__num_events(pmu);
+		return pmu->from_env ? 0 : tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
-		return hwmon_pmu__num_events(pmu);
+		return pmu->from_env ? 0 : hwmon_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
-		return drm_pmu__num_events(pmu);
+		return pmu->from_env ? 0 : drm_pmu__num_events(pmu);
 
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
@@ -2275,11 +2276,11 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	size_t size_rem;
 
 	if (perf_pmu__is_tracepoint(pmu))
-		return tp_pmu__for_each_event(pmu, state, cb);
+		return pmu->from_env ? 0 : tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
-		return hwmon_pmu__for_each_event(pmu, state, cb);
+		return pmu->from_env ? 0 : hwmon_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
-		return drm_pmu__for_each_event(pmu, state, cb);
+		return pmu->from_env ? 0 : drm_pmu__for_each_event(pmu, state, cb);
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
@@ -2784,10 +2785,12 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	if (!pmu)
 		return;
 
-	if (perf_pmu__is_hwmon(pmu))
-		hwmon_pmu__exit(pmu);
-	else if (perf_pmu__is_drm(pmu))
-		drm_pmu__exit(pmu);
+	if (!pmu->from_env) {
+		if (perf_pmu__is_hwmon(pmu))
+			hwmon_pmu__exit(pmu);
+		else if (perf_pmu__is_drm(pmu))
+			drm_pmu__exit(pmu);
+	}
 
 	perf_pmu__del_formats(&pmu->format);
 	perf_pmu__del_aliases(pmu);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2c8916ad073e..ea55882ce670 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -161,6 +161,8 @@ struct perf_pmu {
 	uint32_t cpu_common_json_aliases;
 	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
 	bool sysfs_aliases_loaded;
+	/** @from_env: Was the PMU reconstructed from a perf_env header? */
+	bool from_env;
 	/**
 	 * @cpu_aliases_added: Have all json events table entries for the PMU
 	 * been added?
@@ -345,7 +347,16 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 
-int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name);
+/**
+ * perf_pmu__init() - Initialize a pre-allocated struct perf_pmu.
+ * @pmu: The PMU structure to initialize.
+ * @type: The PMU type identifier (PERF_TYPE_* or dynamic sysfs type).
+ * @name: The PMU name string (copied via strdup).
+ * @from_env: True if reconstructed from a perf_env header rather than live sysfs.
+ *
+ * Return: 0 on success, -ENOMEM if duplicating @name fails.
+ */
+int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name, bool from_env);
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name,
 				  bool eager_load);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index d2f7591747d9..6054d5d5aece 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -714,7 +714,7 @@ struct perf_pmu *tool_pmu__new(void)
 	if (!tool)
 		return NULL;
 
-	if (perf_pmu__init(tool, PERF_PMU_TYPE_TOOL, "tool") != 0) {
+	if (perf_pmu__init(tool, PERF_PMU_TYPE_TOOL, "tool", /*from_env=*/false) != 0) {
 		perf_pmu__delete(tool);
 		return NULL;
 	}
-- 
2.56.0.385.gac671c819a-goog

