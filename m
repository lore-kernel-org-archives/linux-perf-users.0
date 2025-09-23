Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB53148C6
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666824; cv=none; b=LmSFhPNEhGLcWILGq+PvndiynMsWD/SPerb4GfhvElnL7odJMR42Jbovrn6OUEYOGV59nItf9+wgUQWxpcdE344Ti0FMaCxe08PKZprDy/270og/qed8lFQ6ymh8idFHPtrB2FrCJ/c+TGh44fp4g6pKA1KROqtTQXnZcMVP1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666824; c=relaxed/simple;
	bh=fhZD2x+QrbMHd5jK5/8z7VUbaCBpxouok13Arc5QqCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZAaOrIvKxYHuoR9LQsSQ/uEvcjh/W2BCdOad7eCJVUxWnK6RVAWAKLZUQBs3gSxMm31sqNbIKZSvGmTHS6xB/3iv0KWUG5ntkmNau5yreM/NNAEFTconjwrtEegdu414DBPDSgTmZm8CIskTy4JzMx+xOV6CpLd8fLhCnCq82W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyPvfrUf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyPvfrUf"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so9666167a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666821; x=1759271621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEk7FNa9nXQCoNVr0+NbUtahRyTYRTOvJePFmmjLMWQ=;
        b=wyPvfrUfdBvIdZtzlm5mqvOB42xhdCTOdZMfKDLPCRQ8Ewq62sxSp6uSkbFJyAOsJV
         jvjkKXHCyvAyYVdPekkgvFlZFt9ihYvi+wsUDyamnTCygNmOx1xerAyW7uium+1u2ysu
         8IP9AwSnt0MRu3RBVA5QyxMVucIk1LZjH3doMzybhVORopGQQ8iamQUbDefJZUpO3k8C
         jInoclljRJXISxtw9lnXd4qCxah/MXjux5Z+PVRCN6At+NJxD8G1fadJ0NBVp37Fnwxz
         d9xEEHiZAz9WAFvcqJquGd74wqhoFsEDeYaTN4MvB1Yd2B+mIlBchKhC9e/dnMx0T4ML
         3dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666821; x=1759271621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEk7FNa9nXQCoNVr0+NbUtahRyTYRTOvJePFmmjLMWQ=;
        b=T6Cuey+axNVvHOmeskXRI2UBifL2RTSIjLHBpP1qi+JkLhXAKlI01nvhgMHaAh5CHn
         WU1jbjyD+/VUyBAoI446gnkJDrFqBwLu1VvlOjCTY7HLGV9ESRoum2tbwmY1nouZqKWL
         eMT/cYHGWkqTAVlnfPt+T2SqUPy+DaI/yskzRR0aMokXyBNShOOpNHNpLKGB/ZNsHPXn
         j5VUEqZj4P8E7R7Sxk10D/P3Avew3i1iDOdbtUOWX5CGYf8SMLNWjlepSwhM/gk9KURW
         XCoC1pjxJ74+fmNe3OKf4nvO59LO5Zj5HTOnKHnDn2iIbIByNZjuyz40Do5lHs5GCi3O
         bIew==
X-Forwarded-Encrypted: i=1; AJvYcCUAy8e3MHIfAaZvXMr0oXvtJVHk5hq8z5EqatdN/yVIHU/B35vjF6NnUoCwjaFhve06wvxdR89ISztH9YCY7N/O@vger.kernel.org
X-Gm-Message-State: AOJu0YzokTWYs1/X06NzeBWARibyTdT5pDU0IAB1Z9mvv/ZlPNRC7z8w
	9lrRnEfYtYAliFNq+8QMlK2Sm5J9lobsfHcC478IvG3/d9bhRgS68mHBXsmufQW/6zrBevLoSmI
	MlMWgoBG2PQ==
X-Google-Smtp-Source: AGHT+IHkQLN+T8eqo8rXeicrWMoIsPdqOHJSVmWxs0UInkrIHLxtCpJrk6o0Ok4AEJLA+6a/nnV8iokbPKkb
X-Received: from pjll15.prod.google.com ([2002:a17:90a:70f:b0:332:4129:51b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d8f:b0:330:793a:4240
 with SMTP id 98e67ed59e1d1-332a97064ebmr4429130a91.31.1758666821454; Tue, 23
 Sep 2025 15:33:41 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:56 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-13-irogers@google.com>
Subject: [PATCH v6 12/28] perf jevents: Add legacy json terms and default_core
 event table helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add json LegacyConfigCode and LegacyCacheCode values that translate to
legacy-hardware-config and legacy-cache-config event terms
respectively.

Add perf_pmu__default_core_events_table as a means to find a
default_core event table that will later contain legacy events.

In situations like hypervisors it is more likely that tables will be
NULL. Rather than testing in the calling PMU code, early exit in the
pmu-event.c routines.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 26 +++++++++++++++++++
 tools/perf/pmu-events/jevents.py         | 32 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  1 +
 3 files changed, 59 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 041c598b16d8..2393b3a7a4c9 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -461,6 +461,8 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -482,6 +484,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -502,6 +506,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 {
         size_t count = 0;
 
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -580,6 +586,8 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 int ret = pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i],
                                                                  fn, data);
@@ -596,6 +604,8 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
                                  pmu_metric_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -707,6 +717,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
+const struct pmu_events_table *perf_pmu__default_core_events_table(void)
+{
+        int i = 0;
+
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->event_table;
+        }
+        return NULL;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
         struct perf_cpu cpu = {-1};
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 168c044dd7cc..1f3917cbff87 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -325,6 +325,8 @@ class JsonEvent:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     eventidcode = int(jd['EventidCode'], 0) if 'EventidCode' in jd else None
+    legacy_hw_config = int(jd['LegacyConfigCode'], 0) if 'LegacyConfigCode' in jd else None
+    legacy_cache_config = int(jd['LegacyCacheCode'], 0) if 'LegacyCacheCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
     self.topic = ''
     self.compat = jd.get('Compat')
@@ -370,6 +372,10 @@ class JsonEvent:
       event = f'config={llx(configcode)}'
     elif eventidcode is not None:
       event = f'eventid={llx(eventidcode)}'
+    elif legacy_hw_config is not None:
+      event = f'legacy-hardware-config={llx(legacy_hw_config)}'
+    elif legacy_cache_config is not None:
+      event = f'legacy-cache-config={llx(legacy_cache_config)}'
     else:
       event = f'event={llx(eventcode)}'
     event_fields = [
@@ -951,6 +957,8 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -972,6 +980,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -992,6 +1002,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 {
         size_t count = 0;
 
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1070,6 +1082,8 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 int ret = pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i],
                                                                  fn, data);
@@ -1086,6 +1100,8 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
                                  pmu_metric_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1197,6 +1213,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
+const struct pmu_events_table *perf_pmu__default_core_events_table(void)
+{
+        int i = 0;
+
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->event_table;
+        }
+        return NULL;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
         struct perf_cpu cpu = {-1};
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index ea022ea55087..e0535380c0b2 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -125,6 +125,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 				   void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
+const struct pmu_events_table *perf_pmu__default_core_events_table(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
-- 
2.51.0.534.gc79095c0ca-goog

