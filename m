Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA669C77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjE0H1m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjE0H1D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:27:03 -0400
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A70173B
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:26:15 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-556011695d1so30782847b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172232; x=1687764232;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I37rqh5cG8jyPI8CnkZDKw7uLKTCQzZXDibgw5Pks+s=;
        b=JbaNTb+YoFBnILHze5B/sosyUm2MQP4Y0jSpgE6FaHOPiwbbxJRmEIw9vuZN0VhkXs
         rboTkzWd7Sw+pkmZvebpDXVN90UnkVKIj82VLkm8mTqJHEEJxsJxr2Z1tXHLAOGL4H3E
         kMV+E4kmR+rr29EnsOQs3QbH1dAVsrcOcuHnmeG/Z+/FyXu9CSX/3ijEYMczyoRo/d3B
         qHygUAFcT4AlyEJmP0HGJnsBzoc7gqzozDrFRvJaWYQ4m09f8/X53tcaTtiT53LXYCyi
         gmvSR0h6sT2Pz0YuhnE8Yt6w045BVknASZuz8iBog8fae1znZJyK9PhmRPH1GN3aHyTm
         T/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172232; x=1687764232;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I37rqh5cG8jyPI8CnkZDKw7uLKTCQzZXDibgw5Pks+s=;
        b=Lkx981RVddESJ55tYFSfET5SfamKqByJ6i5JXpM7b/rtWlm3URc+DyHg9RmAKZqPmz
         u2c/3h0wR0NmHfxw/IJcPsFzyhk3zcZpjpKPp4vG1JoPa5B9IbH/IqfLTio4oTnUF0Ge
         vCahOlkLMB+kx25HsVNphYf2DiPUWHMrXJVuBGnnSj8vmHpNdtKYoNAiX3/ut5KILekO
         SKJ9n0ihoJJQg0xdP3ruvsGli5kC+wESZmW8sspDIHDUqCeHAgt7yEEdjaf8nd9MHaGy
         lg4EAY/iKdQDK7fJFxnJNYmWuIHF6LWjNh90rw7ZbPbo97SZbz7XSCxR5S+/k5mBSQiG
         9Pdg==
X-Gm-Message-State: AC+VfDwH5iwYXrkSjN0KQ3EF1wyMdID33AkLe821h9sx2hkA7fTjjKsY
        qDm9DvwZdyxGW5jQn0fAXKUn/5CK57fs
X-Google-Smtp-Source: ACHHUZ78KBA1JUa2cvAkqw//UTMkAV6kfTQbeH4HIqu8smct7E2eumOweassg456g7kOaLPz3uV8vDzZ5jU9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:84c8:0:b0:ba8:90c9:f7bd with SMTP id
 x8-20020a2584c8000000b00ba890c9f7bdmr1556932ybm.6.1685172232617; Sat, 27 May
 2023 00:23:52 -0700 (PDT)
Date:   Sat, 27 May 2023 00:22:10 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-35-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 34/34] perf pmu: Remove is_pmu_hybrid
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

