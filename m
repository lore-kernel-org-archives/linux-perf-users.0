Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B64DC4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629B1611EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhHUJWv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhHUJWM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4011C061149;
        Sat, 21 Aug 2021 02:20:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v2so17613120edq.10;
        Sat, 21 Aug 2021 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbY+VGy/3mkjno4xnYKOjNQeJxgBCMAOKpqcP2zu5lg=;
        b=Aj7n8fZwGkeeVrdSL1o7mSpy2nVXdCldhQbgSyhea8KSahPrk4kMiVIbb2vBYt9Uvp
         A3fngXvTzPe8CqqAVUIbnIAXYrFtMxDVKPBK79qYJfXqk1SQuG5IyWCKxJ4C7inX8EIp
         vak3mYz9w2LRBWZ5zQGEE/qj9KjiwoP6PLCobSEKtJIRIM6gtFGBBGpv8hJSO4p+keFi
         8/4vn4GeXr7ZWFXWqs5JQWThpr9/Mp3wh8jyBa6NVmZQc2aXmv2Gcl3LMS7XBDwwfo7v
         +/Bo+PYW42Bd0hng8UrBNLR+V79Xy4lT9yJrUhdVI6uWmlT0wweFcwSpoVEaA8UL5k3Q
         fcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbY+VGy/3mkjno4xnYKOjNQeJxgBCMAOKpqcP2zu5lg=;
        b=QrmK9aZ/FfpUNRjIbLwE2f66k2pNncVZpFe1F26rzXoNaDRSolnfYCLc9eaQrdwu95
         Hc2Q6DPZ0xX5CThSPr1I6TdDrWqZ5EmGx6uP9BUtqWrNd7I1gDB3ILQSRBafy2quW+mM
         fuWTBrnYoYkxzJ0c2He4EkitWxJO4IFyYuwfrYb2QvniRVuq8k6oOw2a/qDymtQTWCTX
         aCTDD8RyAaI3DrrDkvCcuRznASEuzAfBMhDnHD+7ZqHKRhIeO+SybJN/BJUZ/u6hz9P8
         kaUo9b9CJJ3xr+Sb+My/WR0MjPGrV3POIjdn9ZPbjQWT1Dv2sq+l9A65Zs8lRW2CjS13
         qVRg==
X-Gm-Message-State: AOAM532mVUFo8jmq7cUXMAaSThhBfom0zXIIxv0UoFVBwIo6xVhK80MF
        OEHYynkLmqAFOuVQQNAYCVCZVIsLbvIdVCPuzJI=
X-Google-Smtp-Source: ABdhPJwmQgO+RqW9PZ4FGpV5+fnG8bHO/agqcKbQdGZt8GIeBhCtCSWdd1PrW0r3n49AaAL62V1Ivw==
X-Received: by 2002:a05:6402:7ce:: with SMTP id u14mr26544088edy.61.1629537623567;
        Sat, 21 Aug 2021 02:20:23 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:23 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 28/37] perf evlist: add multithreading to evlist__open
Date:   Sat, 21 Aug 2021 11:19:34 +0200
Message-Id: <313458a08272272b00efa6b5581a1cdbaca0ef84.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch enables multithreading in evlist__open using the new
evsel__open_per_cpu_no_fallback function.

The multithreaded version tries to open everything in parallel. Once
workers are done, it checks their result and, in case of error, it
tries the fallback mechanisms present in evsel__open_cpu and restarts
the workers from were they've left.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.c | 189 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0a839107e8849bf..3472038d719ec7d4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -19,6 +19,8 @@
 #include "units.h"
 #include "bpf_counter.h"
 #include <internal/lib.h> // page_size
+#include <internal/cpumap.h>
+#include <internal/threadmap.h>
 #include "affinity.h"
 #include "../perf.h"
 #include "asm/bug.h"
@@ -1403,11 +1405,184 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 	return err;
 }
 
-int evlist__open(struct evlist *evlist)
+static int evlist__open_singlethreaded(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	int err;
 
+	evlist__for_each_entry(evlist, evsel) {
+		err = evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+struct evlist_open_work {
+	struct work_struct work;
+	struct evlist *evlist;
+	int cpu;
+	union {
+		int cpu_resume;
+		int cpu_err;
+	};
+	union {
+		struct evsel *evsel_resume;
+		struct evsel *evsel_err;
+	};
+	struct evsel_open_result res;	// this is also used to resume work
+	bool progress;			// did the worker do any progress?
+};
+
+static void evlist__open_multithreaded_func(struct work_struct *_work)
+{
+	struct evlist_open_work *work = container_of(_work, struct evlist_open_work, work);
+	struct evsel *evsel = work->evsel_resume;
+	int cpu_idx, thread_resume = work->res.thread;
+
+	work->res.peo_res.err = PEO_SUCCESS;
+	work->progress = false;
+
+	if (!evsel)	// nothing to do
+		return;
+
+	work->evsel_err = NULL;
+
+	evlist__for_each_entry_from(work->evlist, evsel) {
+		cpu_idx = evsel__find_cpu(evsel, work->cpu);
+		if (cpu_idx < work->cpu_resume)
+			continue;
+
+		work->res = evsel__open_per_cpu_no_fallback(evsel,
+					evsel->core.cpus,
+					evsel->core.threads,
+					cpu_idx, thread_resume);
+		work->progress |= work->res.thread != thread_resume;
+		if (work->res.peo_res.err != PEO_SUCCESS) {
+			work->evsel_err = evsel;
+			work->cpu_err = cpu_idx;
+			break;
+		}
+
+		thread_resume = 0;
+	}
+}
+
+static int evlist__open_multithreaded(struct evlist *evlist)
+{
+	int cpu, cpuid, cpuidx, thread, err;
+	struct evlist_open_work *works;
+	char errbuf[WORKQUEUE_STRERR_BUFSIZE];
+	struct perf_event_open_result peo_res;
+	struct evsel *evsel;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
+	enum rlimit_action set_rlimit = NO_CHANGE;
+	bool progress;
+
+	works = calloc(perf_cpu_map__nr(evlist->core.all_cpus), sizeof(*works));
+	if (!works)
+		return -ENOMEM;
+
+	perf_cpu_map__for_each_cpu(cpuid, cpuidx, evlist->core.all_cpus) {
+		init_work(&works[cpuidx].work);
+		works[cpuidx].work.func = evlist__open_multithreaded_func;
+		works[cpuidx].evlist = evlist;
+		works[cpuidx].cpu = cpuid;
+		works[cpuidx].evsel_resume = evlist__first(evlist);
+	}
+
+reprepare:
+	evlist__for_each_entry(evlist, evsel) {
+		err = evsel__prepare_open(evsel, evsel->core.cpus,
+				evsel->core.threads);
+		if (err)
+			goto out;
+	}
+retry:
+	perf_cpu_map__for_each_cpu(cpuid, cpuidx, evlist->core.all_cpus) {
+		err = schedule_work_on(cpuid, &works[cpuidx].work);
+		if (err) {
+			workqueue_strerror(global_wq, err, errbuf, sizeof(errbuf));
+			pr_debug("schedule_work: %s\n", errbuf);
+			goto out;
+		}
+	}
+
+	err = flush_scheduled_work();
+	if (err) {
+		workqueue_strerror(global_wq, err, errbuf, sizeof(errbuf));
+		pr_debug("flush_scheduled_work: %s\n", errbuf);
+		goto out;
+	}
+
+	// check if any event was opened (progress = true)
+	progress = false;
+	perf_cpu_map__for_each_cpu(cpuid, cpuidx, evlist->core.all_cpus) {
+		if (works[cpuidx].progress) {
+			progress = true;
+			break;
+		}
+	}
+
+	perf_cpu_map__for_each_cpu(cpuid, cpuidx, evlist->core.all_cpus) {
+		peo_res = works[cpuidx].res.peo_res;
+
+		switch (peo_res.err) {
+		case PEO_SUCCESS:
+			continue;
+		case PEO_FALLBACK:
+			err = peo_res.rc;
+			break;
+		default:
+		case PEO_ERROR:
+			err = peo_res.rc;
+			goto out;
+		}
+
+		// fallback
+		evsel = works[cpuidx].evsel_err;
+		cpus = evsel->core.cpus;
+		cpu = works[cpuidx].cpu_err;
+		threads = evsel->core.threads;
+		thread = works[cpuidx].res.thread;
+
+		if (evsel__precise_ip_fallback(evsel))
+			goto retry;
+
+		if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu,
+						threads, thread, err))
+			goto retry;
+
+		// increase rlimit only if no progress was made
+		if (progress)
+			set_rlimit = NO_CHANGE;
+		if (err == -EMFILE && evsel__increase_rlimit(&set_rlimit))
+			goto retry;
+
+		if (err != -EINVAL || cpu > 0 || thread > 0)
+			goto out;
+
+		if (evsel__detect_missing_features(evsel))
+			goto reprepare;
+
+		// no fallback worked, return the error
+		goto out;
+	}
+
+	err = 0;
+
+out:
+	free(works);
+
+	return err;
+}
+
+int evlist__open(struct evlist *evlist)
+{
+	int err;
+
 	/*
 	 * Default: one fd per CPU, all threads, aka systemwide
 	 * as sys_perf_event_open(cpu = -1, thread = -1) is EINVAL
@@ -1420,11 +1595,13 @@ int evlist__open(struct evlist *evlist)
 
 	evlist__update_id_pos(evlist);
 
-	evlist__for_each_entry(evlist, evsel) {
-		err = evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
-		if (err < 0)
-			goto out_err;
-	}
+	if (perf_singlethreaded)
+		err = evlist__open_singlethreaded(evlist);
+	else
+		err = evlist__open_multithreaded(evlist);
+
+	if (err)
+		goto out_err;
 
 	return 0;
 out_err:
-- 
2.31.1

