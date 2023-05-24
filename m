Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6685C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjEXWWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjEXWWH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:22:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291FE6E
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:21:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25376f7737aso756772a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966792; x=1687558792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtfIK0Ng/M2Pg4C34SglSHaqm2V1d201IwuIsvGzJ2Y=;
        b=jZqOUs4khalhefWZA9ZH5Cd3Ak1pZuDgONShr5OBFfs90o9+6fZ+v/uPtshEsqbn5D
         cSeOiEQMwnIcIpdU4Q9uR4gXcwb67sUxfNNC6qgG8f+UFz+3ChzROoXCnoGdMTgpHS5j
         fKudJ7McBlaqp4uNamm9fScATnN3d//SXLTOCFVT2WAAIzGn+4ffUzdWYkIw+VZB5O55
         aAq3mAUfDSxUhzH00Y5i8001CewqddXbVpPRVEXJrQaq9Ij2DKPsdrDvX992n2uziLlo
         qW/TBZCbnVYFlkw+ZvwdbbEFnTlA+wBYepun9M9kdevhU8ALCHQ19BTnnoJBQ4rWdozH
         CXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966792; x=1687558792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtfIK0Ng/M2Pg4C34SglSHaqm2V1d201IwuIsvGzJ2Y=;
        b=ikTlIEGGJMBaWLKYirTjHbJyqBJCDmEVPjUjM8/ZRSYrb4X4xAt5VCQmSo0mtnK1Cc
         9bMG9uUGvqdAgpT/kmN+UwHmhLpPXBnfFZEDRN/YrcWPr9+lZYRfbb4+ws1Nth2znBWA
         hZgmBw8i5pVQW9Mg8bEE3Mj6TFojbrbXq7990ZmVtS5jIYdXZD0/bmB1jslB8l5jq7Q2
         oqopsyVybwnbCq4s91RfEHrpvhfe3GnoCu3xY4iUZCB8hLxHuC1wPK0LuxJW35xQRNH4
         S0l1Ls36QVoE7LWFsH4iTsJEDvZ1Q9lh+3fQMe9NI8+TMvp6UZtwTEvR5CschMluVont
         Y+7g==
X-Gm-Message-State: AC+VfDwfwYTLcvh7zPQMbqXAcgv/hhhXpBAE4KxtA0fK0WYvLks+dd+V
        Wjg7eu7PD0n5ODGgjXTe+om0VvVgwqHK
X-Google-Smtp-Source: ACHHUZ4Gz3sOCvjHJxUs0XNMvaqhY/GCtlI3yryh2ai00McLuG0za9EWtTnr4ygxbEv+fbo273yNoWXm8EPG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a17:90a:2e12:b0:253:2388:9d44 with SMTP id
 q18-20020a17090a2e1200b0025323889d44mr4425400pjd.9.1684966791898; Wed, 24 May
 2023 15:19:51 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:29 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-34-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 33/35] perf pmus: Add function to return count of core PMUs
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

Add perf_pmus__num_core_pmus that will count core PMUs holding the
result in a static. Reuse for perf_pmus__num_mem_pmus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 21 ++++++++++++++-------
 tools/perf/util/pmus.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 6ecccb5ad03e..bf927aed162e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -229,14 +229,8 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 
 int perf_pmus__num_mem_pmus(void)
 {
-	struct perf_pmu *pmu = NULL;
-	int count = 0;
-
 	/* All core PMUs are for mem events. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
-		count++;
-
-	return count;
+	return perf_pmus__num_core_pmus();
 }
 
 /** Struct for ordering events as output in perf list. */
@@ -488,6 +482,19 @@ bool perf_pmus__has_hybrid(void)
 	return has_hybrid;
 }
 
+int perf_pmus__num_core_pmus(void)
+{
+	static int count;
+
+	if (!count) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
+			count++;
+	}
+	return count;
+}
+
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 9de0222ed52b..27400a027d41 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -19,5 +19,6 @@ int perf_pmus__num_mem_pmus(void);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
 bool perf_pmus__has_hybrid(void);
+int perf_pmus__num_core_pmus(void);
 
 #endif /* __PMUS_H */
-- 
2.40.1.698.g37aff9b760-goog

