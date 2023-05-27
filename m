Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D33C77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjE0HXT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjE0HXE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:23:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C60C135
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:22:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so3218358276.2
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172172; x=1687764172;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VCKvRGvQOyrxybTaQrpXvOpYk1EydxEOVUgh/PqmgI=;
        b=yV1YZNOsvfeF4Ft293I2i0bt5grnyJq5eVrNGq/gtSC3F/RgJNaIZhMktW37517hxO
         rof3nnNYGR/xHOPf25XZqdFVhDeQXyElDr5mQE/HnNITL60AcuZ0Q4xLCR8Po5aWKycf
         cg26fe0UkDqsuMJP2PbvP4i2YEZKPeV/TC6PHtTivv7tQzoVb06r3uWpM1G1qSi/dhIN
         dTl2NIeqYJjyTILMSjOxLZiiOhs8MfVJNJpuvSEGaHjlDrvPPyFBDG2Uy1O/6YwW6y1D
         Z/KMbDXZpkXpfOJosj4KbCDjkf6SnPGvaTheTL0xAm83+xHi4G8/Z3wtNq/ExN3NiZ9V
         LA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172172; x=1687764172;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VCKvRGvQOyrxybTaQrpXvOpYk1EydxEOVUgh/PqmgI=;
        b=Px2X5el8ZYup/xl5cyxbOZcdp/RYkws4vAmOzOyyhUaa3Xsxm2Uvk/fQYptU/K+kft
         8Kt0uUTdMXR8wT4f6eiblGrsDuFxy78JhXia3I/a72zJaJiY7WBySFPdG8RjcEGZaP7O
         ip8ImtDbAKbW451hOrzCrvAFNdv0PXYdw+WGiHK4faj+Cy0sUfSZ+j+30OfLjgGxOQ0d
         WJ4najX51lMx0oJemZZr366XWI1B040qlcDY2b9bYowHdcqJiQEDyRvSy5okiFEDuDWi
         dAxB/HrjfZ1pWE6TuIicdMkqnTA/qbklqfetYuwZ/e3SDsD+NIvXZ+zYxZw3lLBnajmC
         kGlg==
X-Gm-Message-State: AC+VfDxstFe9IEIUA15C5RXXnDQm4ZW0ITLLTwvJWPmkb6fnTwdwPeDv
        cj3fsbRqvLwPYvQF27fo9JSohKpa7wzS
X-Google-Smtp-Source: ACHHUZ5JeQ9nyVEs3oW+zOQKSK/IHbI+WzsmAygnPimX7a4dLNlsSwWaFNTetcMS7UG08rHYiIQSghAtW2ax
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8211:0:b0:ba7:5bec:7772 with SMTP id
 q17-20020a258211000000b00ba75bec7772mr1632189ybk.5.1685172171783; Sat, 27 May
 2023 00:22:51 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:44 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-9-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 08/34] perf evlist: Propagate user CPU maps intersecting
 core PMU maps
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The CPU map for a non-core PMU gives a default CPU value for
perf_event_open. For core PMUs the CPU map lists all CPUs the evsel
may be opened on. If there are >1 core PMU, the CPU maps will list the
CPUs for that core PMU, but the user_requested_cpus may contain CPUs
that are invalid for the PMU and cause perf_event_open to fail. To
avoid this, when propagating the CPU map for core PMUs intersect it
with the CPU map of the PMU (the evsel's "own_cpus").

Add comments to __perf_evlist__propagate_maps to explain its somewhat
complex behavior. Fix the related comments for system_wide in struct
perf_evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/evlist.c                 | 25 ++++++++++++++++++++-----
 tools/lib/perf/include/internal/evsel.h |  6 +++---
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 81e8b5fcd8ba..b8b066d0dc5e 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -36,18 +36,33 @@ void perf_evlist__init(struct perf_evlist *evlist)
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 					  struct perf_evsel *evsel)
 {
-	/*
-	 * We already have cpus for evsel (via PMU sysfs) so
-	 * keep it, if there's no target cpu list defined.
-	 */
 	if (evsel->system_wide) {
+		/* System wide: set the cpu map of the evsel to all online CPUs. */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__new(NULL);
+	} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
+		/*
+		 * User requested CPUs on a core PMU, ensure the requested CPUs
+		 * are valid by intersecting with those of the PMU.
+		 */
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
 	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
-		   (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
+		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
+		/*
+		 * The PMU didn't specify a default cpu map, this isn't a core
+		 * event and the user requested CPUs or the evlist user
+		 * requested CPUs have the "any CPU" (aka dummy) CPU value. In
+		 * which case use the user requested CPUs rather than the PMU
+		 * ones.
+		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
+		/*
+		 * No user requested cpu map but the PMU cpu map doesn't match
+		 * the evsel's. Reset it back to the PMU cpu map.
+		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 4d6f2a032f45..5cd220a61962 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -62,9 +62,9 @@ struct perf_evsel {
 	int			 nr_members;
 	/*
 	 * system_wide is for events that need to be on every CPU, irrespective
-	 * of user requested CPUs or threads. Map propagation will set cpus to
-	 * this event's own_cpus, whereby they will contribute to evlist
-	 * all_cpus.
+	 * of user requested CPUs or threads. Tha main example of this is the
+	 * dummy event. Map propagation will set cpus for this event to all CPUs
+	 * as software PMU events like dummy, have a CPU map that is empty.
 	 */
 	bool			 system_wide;
 	/*
-- 
2.41.0.rc0.172.g3f132b7071-goog

