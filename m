Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA6C001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 04:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFWEiv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 00:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFWEiu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 00:38:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B132126
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:38:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso364154276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687495129; x=1690087129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSgIO0IVog8h08+2nGqjj2Vojr4jZTwgL22RxcdKB8c=;
        b=pF+CFh8/5u2Z5RBQgr2MWTPNCEUjVpUBMCnSdMzJB/KZWA0IKVKiQ+Wqmlb2mW9RbD
         hVGDqfIWzHjL3ZaXxOw4o9s1mjcwA90CLFIeRTW5g09K98ggbYg5E2c9Q3kcYLd1PFrw
         nFOZnHTQO3pSAxDSyFtmmL5XVCahAcx5K7St5Snxnh575V6f8ErFJBghxg2ida46LmKk
         cml6B1PxYE+CVwP+bmDr188ma2IZmy/ImSLmwU3JZ+nWUCYYoRJqgM38V3P9A0O0RRIs
         Zb43CsELEz5HJUXOaNsLQg9Ya+Ck+HUMWieQePr2zniwLHXD4tMsGv5lmPAE7fEiZNFD
         agDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687495129; x=1690087129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSgIO0IVog8h08+2nGqjj2Vojr4jZTwgL22RxcdKB8c=;
        b=kZmwZZoznMSF7ImmfRF0a5L+cDE0QUiSx6siTq/IwPy4kkeKXrUsBD785yWM63rJko
         1wowWAPVktI4YF54tMIs36dC3U2PIYdTaaa6dhbu+LhL0m85iVN1AYNbrHKVsmQFF85+
         2whidnYQO/2b6LsHE0o5X5S2msIBjIe3W2O/qDpa0pLYMCr+AVCnwagFnJEfIa1l4XTV
         LRmrzpir4xOburD8nHKjkXTPFR7AqN3YKOR+gTY4c8K++nNN9Z8oW2BnFQnxluP5e+yB
         Bh1I/aToeJRai8fYkZtXo7VBzY/+eAExTBb9G4p4HMriXHxjxDZCRQrxCJPsKa5YzfxP
         +G1Q==
X-Gm-Message-State: AC+VfDyAaBM+t/XpMtrqFUZkaHW+lXn4RyZOm6sJjp8cauN9otvx20mI
        veQU6SRWvd2W6QEz7PT02te+znYyLBwm
X-Google-Smtp-Source: ACHHUZ4D3YHzemZB860M9VC9gPhZL3DKE+p9XnnIPbZKTGwS8Qsz5zuNTyNmErEBA6TM/yBk4wyKOuJ0gtvS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:d387:0:b0:bd6:9fb7:69bb with SMTP id
 e129-20020a25d387000000b00bd69fb769bbmr8881880ybf.13.1687495129061; Thu, 22
 Jun 2023 21:38:49 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:38:43 -0700
In-Reply-To: <20230623043843.4080180-1-irogers@google.com>
Message-Id: <20230623043843.4080180-2-irogers@google.com>
Mime-Version: 1.0
References: <20230623043843.4080180-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 2/2] perf pmu: Remove a hard coded cpu PMU assumption
From:   Ian Rogers <irogers@google.com>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The property of "cpu" when it has no cpu map is true on S390 with the
PMU cpum_cf. Rather than maintain a list of such PMUs, reuse the
is_core test result from the caller.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 963c12f910c5..64fa568a5426 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -551,7 +551,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
-static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
+static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name, bool is_core)
 {
 	struct perf_cpu_map *cpus;
 	const char *templates[] = {
@@ -575,7 +575,8 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
 			return cpus;
 	}
 
-	return !strcmp(name, "cpu") ? perf_cpu_map__get(cpu_map__online()) : NULL;
+	/* Nothing found, for core PMUs assume this means all CPUs. */
+	return is_core ? perf_cpu_map__get(cpu_map__online()) : NULL;
 }
 
 static bool pmu_is_uncore(int dirfd, const char *name)
@@ -886,7 +887,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (!pmu)
 		return NULL;
 
-	pmu->cpus = pmu_cpumask(dirfd, name);
+	pmu->is_core = is_pmu_core(name);
+	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 	pmu->name = strdup(name);
 	if (!pmu->name)
 		goto err;
@@ -903,7 +905,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	}
 
 	pmu->type = type;
-	pmu->is_core = is_pmu_core(name);
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
-- 
2.41.0.162.gfafddb0af9-goog

