Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D6C7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbjEZV5x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbjEZV50 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:57:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4519C
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:56:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56536dd5f79so30388427b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138132; x=1687730132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I37rqh5cG8jyPI8CnkZDKw7uLKTCQzZXDibgw5Pks+s=;
        b=7vbUEjTg++uSRlxt9/L8w7EUfHc0cEng9J5xXYzkNK4RtEub32q+k1MjWS4ZoqgJVp
         bPakSgV6smTXGiuXxRwa+gbjMAHBndhZ0m4m7hRjgRVz+pMZzBDU+8jPInIiyMCbcDFO
         zhK0BCKwSsIXCqjGxY8icTH2xYVL8LcmhKtERl7jtq5kBg03lb5Z8+c5XjLm5udvEf+w
         qaU1g/frJAEfQgaE+aXUU1tmJcdcdkPHa3fqhn0uMJwn2rLJicoPv8aiFc4gkXi+Pacw
         g7/MqOE388AMWjIY+OcZdDllz8WfOf9h9CoQZCpSqa4kUAuh8KytEZ9C0cTpfsm172eC
         Arsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138132; x=1687730132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I37rqh5cG8jyPI8CnkZDKw7uLKTCQzZXDibgw5Pks+s=;
        b=D8ZMOeGaSV1lHgzXK4Lw6DMYzYlu9dPl1pY5HtpgqOT3NLuvS1ENVk04xn6hzByuZ6
         12ENQkzaI3cXFPjt5/90njulXqYvw/oLTuDCpfHPoFxWJPamhPea+0Xw1CgRH/V9hFAE
         QS7VPiXQyeyMAEiIVD9c9N3pY0zssP8Zqt/Lmdq4WBQ/yyt3yI/3bXz1pEJktkl8znhx
         xGZt9Fla4KqdfAysD87AaEh/yCgguhETw9fMsy+FO5zYthpfJKGtRwFWtfUygRQIi/5f
         qAKLbWDFQaOyv3jXH4HwB09HNv+AnNyWT/h1+t8I4yMZaR0z74U7PFDQDbVkM4vYFf+s
         v5cQ==
X-Gm-Message-State: AC+VfDwZBl807+btXXQ5YDqq8z++pJFP6SHM+TExM+iO7R3+YMgP5tCE
        DcRntTMmc0Q+JzHcd5+NahVq1OVprmNb
X-Google-Smtp-Source: ACHHUZ48ljorUNxuemfq25gYwZO+QkJCDIdXd2cai4k6TFvPbsNPR0m3OMWBkqmC6SCuVN9fnpWdn+ntMCja
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:d84a:0:b0:562:837:122f with SMTP id
 n10-20020a81d84a000000b005620837122fmr1901844ywl.9.1685138132485; Fri, 26 May
 2023 14:55:32 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:10 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-36-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 35/35] perf pmu: Remove is_pmu_hybrid
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

Users have been removed or switched to using pmu->is_core with
perf_pmus__num_core_pmus() > 1.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 7 +------
 tools/perf/util/pmu.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7102084dd3aa..0520aa9fe991 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1417,11 +1417,6 @@ bool is_pmu_core(const char *name)
 	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
 }
 
-bool is_pmu_hybrid(const char *name)
-{
-	return !strcmp(name, "cpu_atom") || !strcmp(name, "cpu_core");
-}
-
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
 	return pmu->is_core;
@@ -1429,7 +1424,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return !is_pmu_hybrid(pmu->name);
+	return pmu->is_core && perf_pmus__num_core_pmus() > 1;
 }
 
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 02fec0a7d4c8..287f593b15c7 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -221,7 +221,6 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head);
 void perf_pmu__del_formats(struct list_head *formats);
 
 bool is_pmu_core(const char *name);
-bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
-- 
2.41.0.rc0.172.g3f132b7071-goog

