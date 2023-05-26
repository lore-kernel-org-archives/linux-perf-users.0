Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B24C7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbjEZVyy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbjEZVyf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:54:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68EC119
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso3086066276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138070; x=1687730070;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTjkcSrIthqBGUF6JyF++nlWwrpLfc1jVqkJtlkt6PQ=;
        b=w25K3uEgKsF2ESRt4NqswniKM+kqGVpYNbZAC3VV1XivKvawMUAL6LVTMMcJxXQBFb
         FRg3ZkENeETKjEOtpf9Oxs3HEnHv9vC702x+tfxnLj0KCOpviMP/uuvf3eHH4eVmCXX2
         QlWwQxHFuKt0+sC/rwn7FmT/72Cb28MCup5wqZ6c+ghLtyHyrLcxED5iu7/4pUMw2f/H
         KP5tGz126hCsKh7w5htUiXSvgg5MhWi9cSbRfyC5lmpNzLrI3tHRUvnao8H/Zx7qap4I
         o5VgvKPBtaw4iY+aMhbxnS+e4o240Y8rT5A92F2E7tu5l9Ys1HwNRKOdkI9yOfCgPgI/
         P1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138070; x=1687730070;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTjkcSrIthqBGUF6JyF++nlWwrpLfc1jVqkJtlkt6PQ=;
        b=BMAU1v2QgEnnplxR7DdAPZ2OFtZ2xHQGlaiL+Ih+plV22jdwHerW505lQMDIzAdoRT
         hbOfjbIVjpVhQ2hrkZOUtpU5Uf9xCErHj1ikdtxlFi1Bosdz6KX8fv1UDn1Ku+39qsWE
         N2Btu9aWggTaEWwlSo7Fl7PWMJqJPJ1ICsB3kAX/f48Gt3YWpeirpWB2rZbbIVLlWZAe
         DyNsWR6QOcdHeuEF1+RMPCU76Sti+d9Sj2fhkZVbohFLV2v4bxceUyxkJAyJlO89/4CS
         35sHIJ4v7zBe+SNkxp89z7wZK0GZIjdfFdD4+wgDcL+p6+BSmHxF+3Golv/FcAouuSZg
         mTaA==
X-Gm-Message-State: AC+VfDytqgOXqxrC+1OzRf2ca+Gdu6v2pIoIL0iMDDWTi0PAEio7YqEJ
        2TWLh+/BrMw8NEDCSl4AvN47Qvg6xA0Y
X-Google-Smtp-Source: ACHHUZ5Y5u5GfQO+v2V+aKXbBLuLyabzsHyJ7UAvFYKMG8567omcANkCFynE5ebfsRhLLEDD5CY9TnAS+MCL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:e08b:0:b0:bad:939:77b9 with SMTP id
 x133-20020a25e08b000000b00bad093977b9mr1193175ybg.3.1685138070105; Fri, 26
 May 2023 14:54:30 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:42 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-8-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 07/35] perf evsel: Add is_pmu_core inorder to interpret own_cpus
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

The behaviour of handling cpu maps varies for core and other PMUs. For
core PMUs the cpu map lists all valid CPUs, whereas for other PMUs the
map is the default CPU. Add a flag in the evsel to indicate if a PMU
is core to help with later interpreting of the cpu maps and populate
it when the evsel is created during parsing. When propagating cpu
maps, core PMUs should intersect the cpu map of the PMU with the user
requested one.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 tools/perf/util/evsel.c                 | 1 +
 tools/perf/util/parse-events.c          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index a99a75d9e78f..4d6f2a032f45 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -41,7 +41,14 @@ struct perf_sample_id {
 struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
+	/** The commonly used cpu map of CPUs the event should be opened upon, etc. */
 	struct perf_cpu_map	*cpus;
+	/**
+	 * The cpu map read from the PMU. For core PMUs this is the list of all
+	 * CPUs the event can be opened upon. For other PMUs this is the default
+	 * cpu map for opening the event on, for example, the first CPU on a
+	 * socket for an uncore event.
+	 */
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
@@ -65,6 +72,8 @@ struct perf_evsel {
 	 * i.e. it cannot be the 'any CPU' value of -1.
 	 */
 	bool			 requires_cpu;
+	/** Is the PMU for the event a core one? Effects the handling of own_cpus. */
+	bool			 is_pmu_core;
 	int			 idx;
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2f5910b31fa9..8c8f371ea2b5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -415,6 +415,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
 	evsel->core.requires_cpu = orig->core.requires_cpu;
+	evsel->core.is_pmu_core = orig->core.is_pmu_core;
 
 	if (orig->name) {
 		evsel->name = strdup(orig->name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b93264f8a37c..1a0be395c887 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -260,6 +260,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
+	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
-- 
2.41.0.rc0.172.g3f132b7071-goog

