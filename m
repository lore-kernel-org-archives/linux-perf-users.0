Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA38C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhLWHtB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347088AbhLWHsP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F9C06175E
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso8638011ybs.14
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J+XZcWIvTsMTXk/jF0b/YxErH+RdVpP417KXG5BKDgQ=;
        b=qINuLaApMXPezDR3O3jtt/WAs+gUahEe62wROOyyU64FhMjIQDuk6iFrPd9nND5dhZ
         BHyaPjAI6A84A1YLGA/bZ8OzeV7TALDFXuODvwMf+XrzUK0PZnwNY2OBkrnHqIT4b5ZB
         xzqy1FWR9uBUiimKdM1M5tXnYThntnMHuLPqAcn6kQ1dqwRJqMsznMMcpkqu+C+F0OTT
         aTVJ8HNQUN2Sj9wGpuYM3fayqBO7cpJGvAahG3jDfc2FS5xjx6kpilevRyUmp+EdWtSX
         uQQD3TT0oTYF7xNxxdTY5DdwmtCj334dnul3ra3QpR+8bKDHTLVmmhNmYFiUPtK9cPWg
         1GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J+XZcWIvTsMTXk/jF0b/YxErH+RdVpP417KXG5BKDgQ=;
        b=i6dopPeDxzz+hjRoyFEq9425T85N6tF6R7eTZGSWGFa3YPjYm7uKQ9I0x/QptWbalV
         XTR2we4ZS5hYf/W/usKpvvFZlyZ55JVFYOrNicNDFtTy2pdnpwkvgoU1h6uWE+g0tHT4
         leOBDkw+puZJMhm1KGuKy80N4eok8u+V14ZVsfOYEJlJ3RcnIlTbhH694trqNsR7DV8m
         4Icz5VSVARE4m46Np35pjrjfQYymrPIXBZJsYYwwnTqu2xD6cZD2L07FONjg1KXhJL+k
         YaAjsi9SIc+UF7YWRaCrZDw/bQ8A2mlX7hd6tCcn2BLi00L2VjHLzETiDPlsWEn0PBWo
         Jpcg==
X-Gm-Message-State: AOAM532fHVvNfXT1Dp4Gt+hO0KGS32tpDLf3EeVFlpnoEyXcUMtL/rmW
        dGARFrcqUkRcSw+6US1HK7QTG6kJ/XDY
X-Google-Smtp-Source: ABdhPJzLRWoaIPKwhtvd7PAQUCqVSNKCsmBsw5xkU76uWfw/NKh8WqXoB837sdBX/gDC08lELhKKt7I/8ciz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:d013:: with SMTP id
 h19mr1759800ybg.428.1640245669757; Wed, 22 Dec 2021 23:47:49 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:33 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-41-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 40/48] perf test: Use perf_cpu_map__for_each_cpu
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Clean up variable naming to make cpu and index clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 544db0839b3b..ca0a50e92839 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -22,7 +22,7 @@
 static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
 						  int subtest __maybe_unused)
 {
-	int err = -1, fd, cpu;
+	int err = -1, fd, idx, cpu;
 	struct perf_cpu_map *cpus;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
@@ -58,23 +58,23 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		goto out_evsel_delete;
 	}
 
-	for (cpu = 0; cpu < cpus->nr; ++cpu) {
-		unsigned int ncalls = nr_openat_calls + cpu;
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		unsigned int ncalls = nr_openat_calls + idx;
 		/*
 		 * XXX eventually lift this restriction in a way that
 		 * keeps perf building on older glibc installations
 		 * without CPU_ALLOC. 1024 cpus in 2010 still seems
 		 * a reasonable upper limit tho :-)
 		 */
-		if (cpus->map[cpu] >= CPU_SETSIZE) {
-			pr_debug("Ignoring CPU %d\n", cpus->map[cpu]);
+		if (cpu >= CPU_SETSIZE) {
+			pr_debug("Ignoring CPU %d\n", cpu);
 			continue;
 		}
 
-		CPU_SET(cpus->map[cpu], &cpu_set);
+		CPU_SET(cpu, &cpu_set);
 		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0) {
 			pr_debug("sched_setaffinity() failed on CPU %d: %s ",
-				 cpus->map[cpu],
+				 cpu,
 				 str_error_r(errno, sbuf, sizeof(sbuf)));
 			goto out_close_fd;
 		}
@@ -82,29 +82,29 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 			fd = openat(0, "/etc/passwd", O_RDONLY);
 			close(fd);
 		}
-		CPU_CLR(cpus->map[cpu], &cpu_set);
+		CPU_CLR(cpu, &cpu_set);
 	}
 
 	evsel->core.cpus = perf_cpu_map__get(cpus);
 
 	err = 0;
 
-	for (cpu = 0; cpu < cpus->nr; ++cpu) {
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		unsigned int expected;
 
-		if (cpus->map[cpu] >= CPU_SETSIZE)
+		if (cpu >= CPU_SETSIZE)
 			continue;
 
-		if (evsel__read_on_cpu(evsel, cpu, 0) < 0) {
+		if (evsel__read_on_cpu(evsel, idx, 0) < 0) {
 			pr_debug("evsel__read_on_cpu\n");
 			err = -1;
 			break;
 		}
 
-		expected = nr_openat_calls + cpu;
-		if (perf_counts(evsel->counts, cpu, 0)->val != expected) {
+		expected = nr_openat_calls + idx;
+		if (perf_counts(evsel->counts, idx, 0)->val != expected) {
 			pr_debug("evsel__read_on_cpu: expected to intercept %d calls on cpu %d, got %" PRIu64 "\n",
-				 expected, cpus->map[cpu], perf_counts(evsel->counts, cpu, 0)->val);
+				 expected, cpu, perf_counts(evsel->counts, idx, 0)->val);
 			err = -1;
 		}
 	}
-- 
2.34.1.307.g9b7440fafd-goog

