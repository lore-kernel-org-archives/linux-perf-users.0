Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F172187C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVt12koF"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243FD110
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 19:14:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a2318df875so42255097b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644841; x=1697249641; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nlT7Ayc6FK2ENh5HApqpyv4FDoAbHTS/CAmbKpgFgU=;
        b=KVt12koF9lOZAI4EXiciPQ4EuRna0sLnyltatR2YMMKhwQEeVEA18EGT2GtRpTDURy
         oM+iqas1pxCdAC6QRhFCe7zAxO/AXftg1pX2PczCTYOyeVO7Wbz7S3JNpXWPmVHefxfT
         j2YCWQSEMbKFkz0ai3b7qINURgbw+OrulMx7rHCwJMzge6/v30pOq2JYwo8SksJI5yiU
         kE391MoYlPVZxkjv7+45FB3F33bY5mvtyOZzeZg9tsB0FQN1+4iGjW2lv90ujPRBJPAd
         5rLq+7G8dG/IUtUkLeeeT5yvEsg1CQ9hOBN/usMjo8GR8OIjPB0FR7zwzH3GzCPDvxN3
         9dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644841; x=1697249641;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nlT7Ayc6FK2ENh5HApqpyv4FDoAbHTS/CAmbKpgFgU=;
        b=k0OuDJeFj6za43ABRqF11z2E28WbtCRDbsDQLykfkWf/S6CGvaTeFLKc6vp37jn1Sq
         E/VY5qBeRvLO1UDYMb9u5TI+XelenaIXzuSn+a6Fv75rI/AYYiCJnnthGtXFBVvDwogi
         PWul/8dG8o6vVQOpTgCYCECoqCTHEbcXu7P2vawtPgDJ/XW3R5QUxSCjJTH7q7hBLX+R
         BUCObwZxUFdB1cjN3TF08wJVgvTqjKRdvRqo02hzkEFLkHFofi9iZi9j2gInQPn7Dx+1
         ZxOR1tMIK6bVk7FAUkzvWBcjv7RHofZWDXlYxAC3W13rW/7jyWsYLM8Go819vlp+0NNf
         53OQ==
X-Gm-Message-State: AOJu0YyhLFDtlBdUyE6drfLlObKEXcsrmuhXDiazBU9BzEHM+X0WrFSt
	Ookox/chstHgrNUIDofkM2CsSIzD3ofY
X-Google-Smtp-Source: AGHT+IHKgnAs25/YJ43kvuHhiiWC2cjxg2u8JYxG3dDXPATXMZW8zvYw7dr0dQFaibX0XwBeXqVh6XfAHREW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a05:6902:180e:b0:d77:984e:c770 with SMTP
 id cf14-20020a056902180e00b00d77984ec770mr169264ybb.5.1696644841134; Fri, 06
 Oct 2023 19:14:01 -0700 (PDT)
Date: Fri,  6 Oct 2023 19:13:25 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 6/7] perf pmu-events: Remember the events and metrics table
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

strcmp_cpuid_str performs regular expression comparisons. Avoid
repeated computation of the table by remembering the table in a
static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fd009752b427..8d8d5088c53c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -978,28 +978,32 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
-        const struct pmu_events_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
+        static const struct pmu_events_table *table;
         size_t i;
 
-        /* on some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
-                return NULL;
-
-        i = 0;
-        for (;;) {
-                const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
-
-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = &map->event_table;
-                        break;
+        if (!table) {
+                char *cpuid = perf_pmu__getcpuid(pmu);
+
+                /*
+                 * On some platforms which uses cpus map, cpuid can be NULL for
+                 * PMUs other than CORE PMUs.
+                 */
+                if (!cpuid)
+                        return NULL;
+
+                i = 0;
+                for (;;) {
+                        const struct pmu_events_map *map = &pmu_events_map[i++];
+                        if (!map->arch)
+                                break;
+
+                        if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+                                table = &map->event_table;
+                                break;
+                        }
                 }
+                free(cpuid);
         }
-        free(cpuid);
         if (!pmu)
                 return table;
 
@@ -1015,13 +1019,17 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
 {
-        const struct pmu_metrics_table *table = NULL;
-        char *cpuid = perf_pmu__getcpuid(pmu);
+        static const struct pmu_metrics_table *table;
+        char *cpuid;
         int i;
 
+        if (table)
+                return table;
+
         /* on some platforms which uses cpus map, cpuid can be NULL for
          * PMUs other than CORE PMUs.
          */
+        cpuid = perf_pmu__getcpuid(pmu);
         if (!cpuid)
                 return NULL;
 
-- 
2.42.0.609.gbb76f46606-goog

