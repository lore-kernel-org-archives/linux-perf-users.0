Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599637;
	b=ayPPI1W7IBQYXEf8kLIihe1H4gJWu2NiVwb6pKk9JD5VmDSZVrHEyYC/4opzDCWfSySk
	 u6nCWOCzr2rbkAPvN7HRy51qSTojezmO/p/XHz6ILEVzkyZl8+aLJfveAVFVFg26RlIEJ
	 1hgdSNqWDeXkViKcsl13eXH3/wCrJEa2J9+uRj3gqyMOzsYIzFzELRMklyrTpuQffXDjo
	 oZ7eHPdG6RDac+PrKVumznQEB7i4v8W4WJCqig6fg0ClcItub3hDKJ47LO0n4fjtqNkNZ
	 sCXXZ29dS6S6WbePL287aQqTzhaHtWq9KbcJwnIsjGc+QDDPWUO+RUpaE/u9pk4Vl0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3+surT00D+b7yUCXgzs5YXgzm7Vyngawn5hQVHAMPEw=;
	b=NRXIZlLOYqPjWDBToVMZH+Ica+JOj3SBpv5iTc7fD+9xgURT4Hwzf+CMSnYFNreVEJAD
	 ybxXgr4INQ+PctW3BdTzOTKn/JmTDHgBQM/6vsDUze/LRMf6fgDupgB6zyxfOBEOAKm7q
	 sAdwNsQSV9I8I32Q5ghak0/GF0FeZBETFo9028tnox913qHeoeiE0b2vMzBxInYkImJQG
	 9/lXF1fDYvOleUTkDIMeAKX8eUWzj7uGHS6TVquOIlyTkDM2Kivh1JfHfqrqQrPvrTv5Y
	 y4oXrFAxYZG6TCswaeGm/MBSpgOXBSL1h/N9UlJJb9dREZiI6LBpNh3pXpt/wl/yVmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ABdAMabW;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33874606A8A0
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33874606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ABdAMabW
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1997081eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599636; x=1795204436; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+surT00D+b7yUCXgzs5YXgzm7Vyngawn5hQVHAMPEw=;
        b=ABdAMabWVcHBwUctSgkZp1exJ1ADw3LXPWywFsCa6elBAvtiA/8SohJqM4FQ0jo/zF
         +1mQ7pbp/JvjUb/kDm4uPaKQMlW/PWDa+cXctYHdEiMR/RRtWjdOzKoW8C0IJar3f4Vf
         2Z/3boKuEGSRvZeAP0aY3ZNATbdkpGt6Nc3UcY0e/GvR3ydnaIFQSw13nPC7YShyIL2N
         2yav6lKjPu9CeuKWASV6qA5VSIO2+VsDoRYWFHhlgnEM7O2ov0Hw5nyAuMgNEIhCoEIk
         h72/qzPEliUb0xUXWIuBVGWkC/q58ToLJBLwzzua8kCJ1dp1dYOqkL8BhvDHlihS2+yv
         3sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599636; x=1795204436;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+surT00D+b7yUCXgzs5YXgzm7Vyngawn5hQVHAMPEw=;
        b=YBlPgSB4EmZT2s0B9XstFsVLpm53M7CrsPztLCjnRFsuXaLONpvNJrT/7bexMoXTG7
         8SytSSjWYqyN20984NFx5wcDXTCG0aRkOecmd0Qbi0nKxs71ZoXXTPeM7hYcxFpnV0nz
         S9kKswOC7bKGvIhaNY0ujs+gnivCaynky7SVAHSHjeHbX4ZBqsPW+ZVf6/AB78LXWp3E
         4PlNKy9bjvMuBqBTWRb3jhaCOrxt/1PAlsPORYZBhjYgKKn2ty38/oKidB2cCx02ye4Y
         57jaWiNZeqQpuqBLxsTtm4BRI/V7zNbIsHdcncOQwxNSa41sBFWj5n3MCErriidn+ONO
         Ny4g==
X-Gm-Message-State: APuU4Z9p9xqVhvxfw6ZgDkOawhM2Rg6J42QVVH/YUiGMJF5ExfAQbX7g
	VghZANxTWefshtjxwudmZ7UC2NQzyVfy6rTRS/RGicb08e65NbcDUi5R6WONVAYrTkYtetttDeH
	g5bNcNopgtw==
X-Received: from dyaw28-n1.prod.google.com ([2002:a05:693c:415c:10b0:377:ed0:c747])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:829b:20b0:374:ba43:ae2e
 with SMTP id 5a478bee46e88-3796628d568mr3433950eec.14.1794599636209; Fri, 13
 Nov 2026 11:53:56 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:12 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-8-irogers@google.com>
Subject: [PATCH v2 07/30] perf pmu: Add from_env parameter to perf_pmu__init()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a boolean from_env field to struct perf_pmu initialized via
perf_pmu__init() to distinguish PMUs reconstructed from perf_env
headers from live host PMUs. Guard tp_pmu, hwmon_pmu, and drm_pmu
callbacks on !pmu->from_env so perf.data-derived PMUs do not access
host tracepoints or cast plain struct perf_pmu allocations via
container_of(). The hwmon and drm evsel open and read callbacks fail
with -EINVAL for such PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c |  4 ++--
 tools/perf/util/drm_pmu.c     | 16 ++++++++++----
 tools/perf/util/hwmon_pmu.c   | 16 +++++++++++---
 tools/perf/util/pmu.c         | 41 +++++++++++++++++++----------------
 tools/perf/util/pmu.h         | 13 ++++++++++-
 tools/perf/util/tool_pmu.c    |  2 +-
 6 files changed, 62 insertions(+), 30 deletions(-)

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
index 5e4bdd8e7fa8..7ef4126ee7e9 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -115,7 +115,7 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 	if (!drm)
 		return NULL;
 
-	if (perf_pmu__init(&drm->pmu, type, name) != 0) {
+	if (perf_pmu__init(&drm->pmu, type, name, /*from_env=*/false) != 0) {
 		perf_pmu__delete(&drm->pmu);
 		return NULL;
 	}
@@ -515,10 +515,12 @@ int evsel__drm_pmu_open(struct evsel *evsel,
 			struct perf_thread_map *threads,
 			int start_cpu_map_idx, int end_cpu_map_idx)
 {
-	(void)evsel;
 	(void)threads;
 	(void)start_cpu_map_idx;
 	(void)end_cpu_map_idx;
+	/* PMUs reconstructed from a perf.data file can't be opened. */
+	if (!evsel->pmu || evsel->pmu->from_env)
+		return -EINVAL;
 	return 0;
 }
 
@@ -657,11 +659,17 @@ static uint64_t drm_pmu__read_for_pid(struct drm_pmu *drm, struct evsel *evsel,
 
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
index 96aeb379e169..1526afa37e87 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
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
@@ -815,6 +821,10 @@ int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	ssize_t len;
 	struct perf_counts_values *count, *old_count = NULL;
 
+	/* PMUs reconstructed from a perf.data file can't be read. */
+	if (!evsel->pmu || evsel->pmu->from_env)
+		return -EINVAL;
+
 	if (evsel->prev_raw_counts)
 		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 
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
2.56.1.703.gf848ed807c-goog

