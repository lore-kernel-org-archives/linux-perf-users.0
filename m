Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA534A3BF
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263295; cv=none; b=Xyesw15KUKSG0cVmTcDbwXeqxmwkTnd7EeIKbTXpdTBAFs/a2s6b9/14LxXNKliRm1MLJb5LFwV1HmFlzOMZ6OIcCFJAK0u5Tfc/YxfqLXL2O4sZRhRHNxJXV6cPJ0TY4QIXtfTwkbDEP9FBrJB6V9zz8trvL64f8ebfQFcDsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263295; c=relaxed/simple;
	bh=FtxOYhwfegkAWcwsWBkisGyTmJZq3wZEhZfE6lZEqH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smrioDAkhbIfhiMqKS0zV48J4iDldSrZPC52tVdWOxcXr2R/PdERYePmdtGquFOolKR76I3trarlly6zlJpHWbYliftrC6O9HLD8un9AkdhM4uSG8YGT9ZGrp67yopITvbrtk93GDgHKRU5OsLRCwQCWnTy1JleHXMBXtx6H5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7Bykkm2; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7Bykkm2"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so534541eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263294; x=1792868094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+8mpyEx8Bj4gf3c0mTRwsejfaqbHbW/M22Bk0FXWaQ=;
        b=e7Bykkm297ApT9hpqeq1fNimZjl9gxUM/ZtLMgb/SjaOCwT+udGR/GdxN8R3q5qNeo
         2kg75lYGONgJwsTjefuXGQ89UBI0oFzH3b/lsHvZFrnSJ8DKP1+y6Qd4Kanvo6iTeQh2
         /K5xoOtFEZFgjEOXFtjq2iRlBbBd2bW6Ow9FU1oUFoWDr4rNUlChzYyy5m7PJfP3OJYH
         DlxaWp58aKGQNOrvc5FKO92m9H+RiISHLgB0HdS5NhhQzAP8xj0kXbWBXIsp/RnvSrpv
         COaYzsJrlz7FLgfi6zhcSLmErp7/Cq4U/msPEkJHnShS/LgOIL0FcfNuDY6kwH42ZY55
         yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263294; x=1792868094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+8mpyEx8Bj4gf3c0mTRwsejfaqbHbW/M22Bk0FXWaQ=;
        b=MFpHwLgG9mPwnSbuePo941qIbvKHJZScq+wasZD8n2hIBLjW4tQH6SU7Ho5nJ1FtZf
         IS1y/KN4RfNkhcoijRldA11n/e1XiFAQ2OnaGYtey9BN2Tc5nd+1uu4nwvA8IXKUA1QC
         FIKIaHsGFTIJJKOp+ZsaWbObXJcd/FJBveH11aA/tTXrIn8shQYPhacFANMRcuk/gcaZ
         NPE0HWOai/sSd+n3RI8NzxQiVf2kGJ+LHeH+Sz1tB2riosZM4xFQo4vU9iNE1Nw6v5Pt
         898L2J/q/RzLjItyDDcDIIUxbFbMX+Q3e1p7FJSruqNpWROkPW0pEpINVgL8LAU6ynyA
         08zw==
X-Forwarded-Encrypted: i=1; AKwUvBxDnMePxpFhDDz+7fom3oRzZNoKGZhWjJmZbBCbh3VM0902q2iUIUPAaOZngLQmJw3CzNWk1PyUQ90b9BoEdYnC@vger.kernel.org
X-Gm-Message-State: AFq9FYKwJQtvzKwzdE5G1FHhmdEpKbeJAg4maMEli5tx1erY6jdVSYcz
	fx7W5EDu9EaoGdpGsgKA0qBBnw8DxWTmTewfN0Y3O9tUr5hKsfmvHaPc/8aG1a2y95Sx3WRIXM7
	/GVTIqn9KOQ==
X-Received: from dlep5-n2.prod.google.com ([2002:a05:701b:4585:20b0:182:f49e:1d74])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4354:b0:16c:4eef:a526
 with SMTP id a92af1059eb24-1851238bde2mr4856695c88.15.1792263293221; Sat, 17
 Oct 2026 11:54:53 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:34 -0700
In-Reply-To: <20261017185442.2137623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com> <20261017185442.2137623-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-2-irogers@google.com>
Subject: [RFC PATCH v2 1/9] perf pmu: Add from_env parameter to perf_pmu__init()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
 tools/perf/util/drm_pmu.c     |  2 +-
 tools/perf/util/hwmon_pmu.c   |  2 +-
 tools/perf/util/pmu.c         | 33 ++++++++++++++++++---------------
 tools/perf/util/pmu.h         |  4 +++-
 tools/perf/util/tool_pmu.c    |  2 +-
 6 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f507ce39439a..cbcc01227a76 100644
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
index b8badae7015c..03764efb3342 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -116,7 +116,7 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 	if (!drm)
 		return NULL;
 
-	if (perf_pmu__init(&drm->pmu, type, name) != 0) {
+	if (perf_pmu__init(&drm->pmu, type, name, /*from_env=*/false) != 0) {
 		perf_pmu__delete(&drm->pmu);
 		return NULL;
 	}
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 96aeb379e169..d9e41eb88b6d 100644
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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..bb2e79802def 100644
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
index 2c8916ad073e..44212f6361c7 100644
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
@@ -345,7 +347,7 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 
-int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name);
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
2.56.0.212.g129ede20d9-goog

