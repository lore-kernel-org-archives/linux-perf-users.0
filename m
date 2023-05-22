Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A4C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjEVGrN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjEVGqI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:46:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C41737
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8bab3b392so6666443276.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737870; x=1687329870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AR9zIJFSwa/PWauN3jIDvjQbr00g5VzBP70Tf1LOL1E=;
        b=rQdTaU9Co7hmCz7sZhlTtMZNm3PLADpPrQkIYy4P6ZRDmrhzsp6Xf0YAjRm0wBZdn+
         6xDYWZ++iJgI6JA/TGL8WcomWza08xozk8lfhLPjUgoHYFyir2BnZuybBvqke06qMHiL
         Ks4GWm+M4VtI/9tZt17Lc5EgktlOwb2PxgJuYJvEljGKwIkIAmtJkdUurOIUjmzFgkyi
         u9cG90qy2vNY6gDgClRU/aMiY994YcRs9Y/JPbQTmuzIwlqn75sDUp+W1KRj6BpWpW+t
         FVrnRzdTvlOE7agFuNOID8UTjbXD2bmq8YnConWaa1Uwsej2BW3iD0MJjU0dy9mKbCxo
         K1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737870; x=1687329870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AR9zIJFSwa/PWauN3jIDvjQbr00g5VzBP70Tf1LOL1E=;
        b=M6+Ea1LpIugqlAb/kKqe1mt8w3wmLQlTvgX3xyjx1dgN5yNMP6yNFBasAnz1Y5oMhJ
         JTZd0xUTkrg3AtGrUYFvw99oSkz4R4Gz4X7vHtUvtePZd+ox3H29OXGxSD7F0xlsbGVO
         I9ysfkmWrZ+XGbBz/ixTyEYLc4hoGGxrbpEz+k8iZ7HOh986YxGveix/41SNSaLb8A7Z
         12gqJrmgBXzzTBjUbMAA5R4RD5dz7YGlwaWor+TljFBW585V8ZSGSMXr45DFG7cfRYBM
         xw8f5kcB7EbydXhWN20HZZ4EBsskJrN90oApYA0RBDhKp4ZP0yXId7CP8Ntg/8zf41sG
         so0w==
X-Gm-Message-State: AC+VfDyi4a4erKSsYQwcs8eI//isQ1AML6WWPo2caFmW2NCWjREYMmKb
        3IHDHwZGRi5lgwI3eM2lnp7hlpP35V70
X-Google-Smtp-Source: ACHHUZ4LNBZ9sStTvrt17WoyzQgUctNLJyZ9xJ+MBkHUvinjj2Hmn4Vu3vh1z5UIvrHcyXCUstYSzvEiMpg6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a05:6902:1343:b0:ba8:4d1c:dd04 with SMTP
 id g3-20020a056902134300b00ba84d1cdd04mr6161248ybu.1.1684737870515; Sun, 21
 May 2023 23:44:30 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:30 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-24-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 23/23] perf pmus: Ensure all PMUs are read for find_by_type
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

perf_pmus__find_by_type may be called for something like a raw event,
in which case the PMU isn't guaranteed to have been looked up. Add a
second check to make sure all PMUs are loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 22e9e46ab765..ce75c7adca84 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -142,7 +142,7 @@ static void pmu_read_sysfs(bool core_only)
 	}
 }
 
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
@@ -150,6 +150,7 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 		if (pmu->type == type)
 			return pmu;
 	}
+
 	list_for_each_entry(pmu, &other_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
@@ -157,6 +158,18 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
+
+	if (pmu || read_sysfs_all_pmus)
+		return pmu;
+
+	pmu_read_sysfs(/*core_only=*/false);
+	pmu = __perf_pmus__find_by_type(type);
+	return pmu;
+}
+
 /*
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
  * next pmu. Returns NULL on end.
-- 
2.40.1.698.g37aff9b760-goog

