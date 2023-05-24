Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD0C77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbjEXWW5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbjEXWWW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:22:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF1E7F
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:21:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso3101389276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966797; x=1687558797;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJl2Qmk86RzYSzEwmiy6LV4523vj02eAYK9mH/h/bGY=;
        b=N9u3K41yQWo85u+L9dLmhBr//frjJo96Jzl9Y0GBUqtMnU1V7vx1lO+YDlrL7mTkqw
         IBDLmNBumnqLVxne9LyiaZ/rQeDda1UBh4f/k8U/x9L2OY9XJD6VmRBC2FL7/To1iTaO
         dSotwoIvo9cFbenpuXX0PEMSt8fMnnnNABcoLYocgLScC3EMWfVTu0Bxv87qIkbptHpM
         uclZYvVyE7hIA7RPYZv63I7OscBQvh9tTI7DSAk7/IoK2U9Am+OCCTdBV01WrDvrBltX
         KwuKdlkI5scTLqMVy82UXs8oDbFYlEic8znEALv1OJu9j+nHjKFk/uQsobl5TFhj8W+R
         YpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966797; x=1687558797;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJl2Qmk86RzYSzEwmiy6LV4523vj02eAYK9mH/h/bGY=;
        b=dCBf6HV5bXl2S7lH9dubuZH+7DEmr39N1kJqb2Re7t1xMqMNIC6XeorP6m/hMfhlZR
         rhRTi/JaawlozHNFGzQZgkmWwWDpa3UhNLiZLK2pSrldr3k+YqFrdlGU0S9/qIEm0KB/
         RIhPLItm22oIL66ar/oWOKN8/Uz2Ude+tlY9wxPavu0EELEES6fSDiEeUbPfqZ0djhez
         V0o8UXYyq6r+wnD+fB6QqCip46UB/3C9XmShJdtZLnxfbWMduiG+KJrIzACQy3/V97rq
         JFovlKSgbhR7HKvVouHw69LFGh/RXpkIjp/lyZKtWIOh0OT1947JXIQUMeUhnpE4T1NM
         cD1Q==
X-Gm-Message-State: AC+VfDzHpCj4fpY38P//aH9wIV51z5mXkGqv9NmWU8oohQ1zs5w5CAXc
        fw70XoQGApTygtjtaT9rDIEEhdX9aKUf
X-Google-Smtp-Source: ACHHUZ5BhCMW/yG0L5tcLlBXdiJdisihTKXeBoYDi9ikOrotsFs2GV8qeZqUWqRaMkKtmgsWoBq6EQT++fSa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:aacc:0:b0:ba8:757c:2523 with SMTP id
 t70-20020a25aacc000000b00ba8757c2523mr798851ybi.9.1684966797045; Wed, 24 May
 2023 15:19:57 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:31 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-36-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 35/35] perf pmu: Remove is_pmu_hybrid
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
---
 tools/perf/util/pmu.c | 7 +------
 tools/perf/util/pmu.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4dd40a38f6bf..a548d38f2a07 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1430,11 +1430,6 @@ bool is_pmu_core(const char *name)
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
@@ -1442,7 +1437,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 
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
2.40.1.698.g37aff9b760-goog

