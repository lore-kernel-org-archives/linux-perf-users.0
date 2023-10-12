Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0637147
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01OirAI7"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F5100
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:57:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3954f6dcso1578981276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133423; x=1697738223; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWpjgvY6Y26Eimtg00txsKN0n/IUHl2rx+ZiyTR9QgU=;
        b=01OirAI7Kqwl3hkIaX6EXZO1fYLqbzvm3N6WQtONnav9Hq/SAmtx3GZMMEtTONsrbB
         XSp96vuEmw3s0kGuQ4mjztC5JI9pxAClDPUNc7bIFf2TJkV0SMTqOxDZKyhm+lWgZ9l9
         BDOUrlzJaa7BSHGW8wSYfvAvrDnUFBnfWR8Z1qbvfEA5yiPARwdzjCzVaiuJBRFfWPDD
         JH+Qwv1UaO1/PFKto+YWN2OnnFOaQXjyJXKPXqHlnqzI36GjlSewl7rOIlyS96n8zIgN
         ipczdb9InLowA1jKpZA+Btm0zn25otbTCRkBE4WwGBa8+Ikb9qu2Z6eEgn7M2BSqbscI
         C4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133423; x=1697738223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWpjgvY6Y26Eimtg00txsKN0n/IUHl2rx+ZiyTR9QgU=;
        b=RFAUyP7h48h5sHT5hOJ3BI5fdfg11OlyTR2xtX6oLE+PPhbgL0v+qLvDo0WYvykWVj
         e73JcVZyZcvP7VnUf7gL52DXHTl7PSyeK7nkpaTtMdoeZKfgvyZC8Pzv6N9pLwHlsQiB
         09K/F7dVZjH/UsfQZ2ZSrZC6xLbkDc6627pWYPo2/9A6G8rrr9dsQdQraMyQwTxFQ+6W
         J+jTQI1aCSjj5AtAkq9Pe5KAd5tnozP+UFWjBT8upm2P7LJ/NfVrGH8oaeZX7GM2oIY3
         c6VjUPNrQhh3sM9+goA6UjFKnZRWDRqnJjDLAPTGym3b5wuYSeN0Dz2rVUS2gWu3Hcod
         fatg==
X-Gm-Message-State: AOJu0YzMZQQCEFAhdKvy70CP/GjDBS3uJrzfA1r6SU7koZ0d9zu9ue8Q
	XO0KcH1RLKc2AT0k+4AJJkONdBnRKFR1
X-Google-Smtp-Source: AGHT+IE/sEVcjGwGGmZkF6IqM1j7PAPF1hcyhh38d5+Sy/MY8H4WVKC1/tU3vnJPIhx8VDYD3KM+PPxqwX1V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a25:e794:0:b0:d9a:40ed:8d26 with SMTP id
 e142-20020a25e794000000b00d9a40ed8d26mr200498ybh.0.1697133423623; Thu, 12 Oct
 2023 10:57:03 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:56:44 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 6/7] perf pmu-events: Remember the perf_events_map for a PMU
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strcmp_cpuid_str performs regular expression comparisons and so per
CPUID linear searches over the perf_events_map are expensive. Add a
helper function called map_for_pmu that does the search but also
caches the map specific to a PMU. As the PMU may differ, also cache
the CPUID string so that PMUs with the same CPUID string don't require
the linear search and regular expression comparisons. This speeds
loading PMUs as the search is done once per PMU to find the
appropriate tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 109 ++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 39 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 96dc74c90b20..3c091ab75305 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -976,68 +976,99 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
-const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
-        const struct pmu_events_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
+        static struct {
+                const struct pmu_events_map *map;
+                struct perf_pmu *pmu;
+        } last_result;
+        static struct {
+                const struct pmu_events_map *map;
+                char *cpuid;
+        } last_map_search;
+        static bool has_last_result, has_last_map_search;
+        const struct pmu_events_map *map = NULL;
+        char *cpuid = NULL;
         size_t i;
 
-        /* on some platforms which uses cpus map, cpuid can be NULL for
+        if (has_last_result && last_result.pmu == pmu)
+                return last_result.map;
+
+        cpuid = perf_pmu__getcpuid(pmu);
+
+        /*
+         * On some platforms which uses cpus map, cpuid can be NULL for
          * PMUs other than CORE PMUs.
          */
         if (!cpuid)
-                return NULL;
+                goto out_update_last_result;
+
+        if (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) {
+                map = last_map_search.map;
+                free(cpuid);
+        } else {
+                i = 0;
+                for (;;) {
+                        map = &pmu_events_map[i++];
+
+                        if (!map->arch) {
+                                map = NULL;
+                                break;
+                        }
+
+                        if (!strcmp_cpuid_str(map->cpuid, cpuid))
+                                break;
+               }
+               free(last_map_search.cpuid);
+               last_map_search.cpuid = cpuid;
+               last_map_search.map = map;
+               has_last_map_search = true;
+        }
+out_update_last_result:
+        last_result.pmu = pmu;
+        last_result.map = map;
+        has_last_result = true;
+        return map;
+}
 
-        i = 0;
-        for (;;) {
-                const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
+const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
+{
+        const struct pmu_events_map *map = map_for_pmu(pmu);
 
-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = &map->event_table;
-                        break;
-                }
-        }
-        free(cpuid);
-        if (!pmu || !table)
-                return table;
+        if (!map)
+                return NULL;
 
-        for (i = 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+        if (!pmu)
+                return &map->event_table;
+
+        for (size_t i = 0; i < map->event_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &map->event_table.pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
 
                 if (pmu__name_match(pmu, pmu_name))
-                        return table;
+                         return &map->event_table;
         }
         return NULL;
 }
 
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
 {
-        const struct pmu_metrics_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
-        int i;
+        const struct pmu_events_map *map = map_for_pmu(pmu);
 
-        /* on some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
+        if (!map)
                 return NULL;
 
-        i = 0;
-        for (;;) {
-                const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
+        if (!pmu)
+                return &map->metric_table;
 
-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = &map->metric_table;
-                        break;
-                }
+        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                           return &map->metric_table;
         }
-        free(cpuid);
-        return table;
+        return NULL;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
-- 
2.42.0.655.g421f12c284-goog

