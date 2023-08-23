Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7BFEE49AE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjHWIOg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjHWILe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:11:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3FE73
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:09:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d72b76f202bso6389393276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778167; x=1693382967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLOHuaoioxUIPfraGI/RscnO6tlIZddOURBBsgyssoE=;
        b=Qz42NKTTx6zTspcQcJfd5SPnOrPnd5c00ZQ5+EY52NaVZ0hc3YTjcUVBHf0sfbvLMB
         ddz3sWDQdyNJneq6OddnEy5ajtknBPl/4FAIK8+S7mEKv1VLLEnxZhCLtDeoLwX7bntT
         tEP6+qxwhJSe6D08LX5LRtMwUth0drK1B8ITajpkP8ULjjvSiHlW7B+sVsju6oocKIt2
         zo6mHAfG/5qPIzXHGBWEwh4b78lxuExssZN+rwTcOUMwZasaDuchoRPODZe8Vy+nbSrN
         cpBJ1/4809OB7f6y74q/YD3soph+v61YnjKubT/oyhZo2nD2tPJnF2i79mmMLLzhl0tH
         lkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778167; x=1693382967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLOHuaoioxUIPfraGI/RscnO6tlIZddOURBBsgyssoE=;
        b=KPgEn40hvm4ungzl9tH9QoLg5oipHp/bFlm5ReGzZycWMOV2ef9qZVAWnJtiLzFEW3
         NEi4oP/luTC+FmsDAOoW7/ogsP1HKgZJoNeJvjeZpkQcmw4J6vZVGIYNWIc9VNiiVSus
         XljGVMB1HHOkYR48Yhn7q6CRQ+rg8e+WIaulZMZi/VfG32XeYgYz/KVElnCTFmaOFqLZ
         +D136u8VIOdyyMoqAWoKh9BZE9RlldUmgg4bdBemh/IIpKScg259cIqbEfCDjhbs5aUk
         OzWqQDRJcD9pKJvSiZ5/xaydG90jVbUc5UYrLVmBanpZDC+kSjgcjH202OWuI9+3D+Aj
         O3CQ==
X-Gm-Message-State: AOJu0YyKdiwpjpJryvSnC64Fz6GzpsgGzEiurWYIghborFOF7EH4QzK8
        bnNhSvUWUyuydi5eKEBH4N+1SufK4Q6w
X-Google-Smtp-Source: AGHT+IEe9e7MnCLgVp65s/JZqoRZX2GWP1p1t6uwoZhQMx0RQHxlMSCM5JVnoCRQRuIKliPIlA+3zuOPa1UA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:d2c4:0:b0:d47:5cc3:9917 with SMTP id
 j187-20020a25d2c4000000b00d475cc39917mr149953ybg.9.1692778167623; Wed, 23 Aug
 2023 01:09:27 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:25 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-23-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 22/25] perf pmu: Scan type early to fail an invalid PMU quickly
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Scan sysfs PMU's type early so that format and aliases aren't
attempted to be loaded if the PMU name is invalid. This is the case
for event_pmu tokens in parse-events.y where a wildcard name is first
assumed to be a PMU name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 81a40fe02d65..b4ba4f7f5e18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -953,12 +953,21 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (!pmu)
 		return NULL;
 
-	INIT_LIST_HEAD(&pmu->format);
-	INIT_LIST_HEAD(&pmu->aliases);
-	INIT_LIST_HEAD(&pmu->caps);
 	pmu->name = strdup(name);
 	if (!pmu->name)
 		goto err;
+
+	/*
+	 * Read type early to fail fast if a lookup name isn't a PMU. Ensure
+	 * that type value is successfully assigned (return 1).
+	 */
+	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
+		goto err;
+
+	INIT_LIST_HEAD(&pmu->format);
+	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
+
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -978,10 +987,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-	/* Read type, and ensure that type value is successfully assigned (return 1) */
-	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
-		goto err;
-
 	alias_name = pmu_find_alias_name(name);
 	if (alias_name) {
 		pmu->alias_name = strdup(alias_name);
@@ -1007,7 +1012,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	return NULL;
 }
 
-
 /* Creates the PMU when sysfs scanning fails. */
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
 {
-- 
2.42.0.rc1.204.g551eb34607-goog

