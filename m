Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3329B78F
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363374; cv=none; b=DGZsNbGAp58YT1Rs1HaIFHoqVhyAzY0Lel30scolKxLEo1o7/ZFYTb2RU2sSipq/CzVko1Ir3K3P4E5BnQ7I818PUFO2d2whQRM4jBar530Ftx5knVH6yM1eJghxKzX6jMfGQ3JAA5MdJZnc9bmm11P/M/DQs2KugROqsK3nvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363374; c=relaxed/simple;
	bh=5RNlpH94YmxwMoQ115+maASfaBgFk2Uk2E0i84yLtHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jO/vqEXoawcZZtZW1LVggywzreLJwbQOnTBkaoNCalO0my9Kg6k+AY8qdMO9KW2PIRTIbzaJowGI9frIYGFYoWhdT4q/TKOXssR2wQI/EITlkDXSLyWb+XUBqqD0k+jV4vbvGVjbImMVNWwmhC7mX504HaR9RqDcw/+QWeSJ7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcP/ZGtG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcP/ZGtG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244582bc5e4so7916945ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363372; x=1756968172; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jncfgT/0bBfpzuhBE3b818JduGXNs7mcO/c+kLSIAAY=;
        b=dcP/ZGtG04uB7371QUtS7aj6sDQCtG0qXEZqOCdVm8UEIu6ImN2sKBiPfcVr5dHXAo
         UqL+7alKZc+kRZWEPh8l1sMu+Zy6eGoJtPtlkch37wr2de1kcYhFjKrpHZuMY7xwh2yz
         6IwQFVlD6YU1Hv5LRgwUKL+YDms2GJiADKYxnO6VsgXT0VCLeBE6VeG8DdITbRe1c2eV
         Z3f7mGO5BETzmqivkiozQdp9X+Jhspfh5qVqOQ2/M2KnUFs9Lri4XmhVpGVEeIox4Txg
         Fc7+K9V9s8pueuL8c3KMJIh5jG0Se1K2uCP4SDIlqRCBmg8hS2VSMKWUBMzKNgohw+bv
         oH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363372; x=1756968172;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jncfgT/0bBfpzuhBE3b818JduGXNs7mcO/c+kLSIAAY=;
        b=eAUa29BKp7x+UYmFtfcyLkhXf6/yujDpv3GJHcwLKPfu03NasGmSO8K92mTnti7Lz6
         mk4RCFByoKGaIjc2a3uYGe0E1fnCiJbhMD3r5wAQDyoFaucc/A3bW13KfDKk+/5eLon3
         RA09Mf+k8pfqJC75N6LdFiFzXA5sWPM+ojfC3NjLC2abtWdOGy0y1Tl7lewTjnMSxeP5
         2MES3xukf/qINbwvMoGkSbUvc21XSHu4stHjUVEEI/BQdqzD9P6rPrZp6kGjHTkw50Sy
         uoxaIrfxPPRWmhcOsT1ktMxw4sMA+Myd19i/QbdxEoD7XrenkYagWElnZuA4gQta+5H7
         rhHw==
X-Forwarded-Encrypted: i=1; AJvYcCW17gyFY1E/ZPxxf4SNJGjJe/syu/DH4Ic3jP20Obv0/J2mogP9e9Iy5bF2cSyo/2Xl83DEZKBvUCcmdvM7BmNN@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbeB+gB9mbDcTU/J5e57YayKBeDpA469SIC6mB7HaX70qGELI
	qS/rsKSICN5nJpbXggVV6HFpWn30leOR0wyI5pCz49HCzcFxGQmL18ZuJnEoRBBaFShyqYEo+6a
	ulvavkP43TQ==
X-Google-Smtp-Source: AGHT+IHJI/NN7gcvojhm6bF8524wJJ8DfgJq6mhLErGkLP9dpLpsSji2JGlhtHLKyvReHSgV5lGyshT5BPfK
X-Received: from plble6.prod.google.com ([2002:a17:902:fb06:b0:248:753f:cb3a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:245:fe27:fe80
 with SMTP id d9443c01a7336-2462eeb004cmr308789885ad.26.1756363372114; Wed, 27
 Aug 2025 23:42:52 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:26 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-9-irogers@google.com>
Subject: [PATCH v1 08/13] perf jevents: Add legacy json terms and default_core
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
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Add json LegacyConfigCode and LegacyCacheCode values that translate to
legacy-hardware-config and legacy-cache-config event terms
respectively.

Add perf_pmu__default_core_events_table as a means to find a
default_core event table that will later contain legacy events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 18 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py         | 24 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  1 +
 3 files changed, 43 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 041c598b16d8..cbfa49320fd5 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -482,6 +482,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -707,6 +709,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
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
index 168c044dd7cc..c896108ee4cf 100755
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
@@ -972,6 +978,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1197,6 +1205,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
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
2.51.0.268.g9569e192d0-goog

