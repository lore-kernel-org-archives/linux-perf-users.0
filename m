Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E45C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjEXWSu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjEXWSs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:18:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65EE191
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5654242df11so28546507b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966724; x=1687558724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9hyOxVMtag083U3DrBABQpzrKUd2k9oDsc9+XJnAEA=;
        b=LtpxsdvrVIHpyYlb3xLC8sqG58Bzm9j5cBtRTcbu3rsLbnqcZy2LpSxSNxzA50XG5w
         /AUONv2Gk38DiQ/sYYuLmGBrZ/dzL4pyU88PhOjIqusuhk7jVExQGDVPzetaywcYi+Un
         wlZ8DlLrDhrD5XMNTk6j7Y8NGCryNgqHWNZXjk3X79vkNmKHzrZ1avClFhIeEuor36PF
         wbHuvGb3DpL5LShCo/zH9iD455YuPM9wYpj4zAl6NMTsAZMedl+TUr0q6YbTi/3QCBUV
         5Bb5M5U55AZMpwbXdhswy+/+aqWe3ropFnOYFQj4k/s1Y7okZgYYUlSi/pGomDTdRQJB
         Q/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966724; x=1687558724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9hyOxVMtag083U3DrBABQpzrKUd2k9oDsc9+XJnAEA=;
        b=EZcsjeVuzDl3uRw8ik++E7mxPfL8hrO95QdajHkCjzxiTQDN5Ppd02GXvGiB7Gd8Mj
         pvckybf1EGU+QbVm7SQOqtUJIFFpEItdXkMTnOb0HhW2Zy8OgD2spHqNPstFabx4YtPx
         KH41cesWrpv2EgsQEHxcXP1yyIg5LQ1arbQMZqCTmPlmfS+5FCB93wGwnAR3momKboV8
         NFue1ShUW1RtedxKPk+Zg1jaFH3ER8XFDpYrqqOx0r9jVCErdh8TaTF/4yUtHVvnE7Rb
         Is8bzLrXZNKVbDRNX0jJptvdiHH14fQxEGA/PeEWvQzoN9iZDwJ5R3tXpiC3crgKxv2l
         9Sxw==
X-Gm-Message-State: AC+VfDy7PEaKLNmeLprFgktIuciQY0S4yECvg0wyn5thGCzmAZZPofSG
        X3YYR9LcPu0hpKMJXtox8lpQRilZ8vef
X-Google-Smtp-Source: ACHHUZ4A9xBsf2NqNhBKrjOga52LfeOavCka+IP0c2dGDJ+fOrU4kiCHN5RkZ7kCcC0QXT4WglaRezW0Dn7i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ad57:0:b0:561:be13:2fd3 with SMTP id
 l23-20020a81ad57000000b00561be132fd3mr11098955ywk.1.1684966723958; Wed, 24
 May 2023 15:18:43 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:00 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-5-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 04/35] libperf cpumap: Add "any CPU"/dummy test function
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

It is common in the code currently to test a map for "empty" when in
fact the "any CPU"/dummy value of -1 is being sought. Add a new
function to enable this and document the behavior of two other
functions. The term "any CPU" comes from perf_event_open, where the
value is consumed, but it is more typical in the code to see this
value/map referred to as the dummy value. This could be misleading due
to the dummy event and also dummy not being intention revealing, so it
is hoped to migrate the code to referring to this as "any CPU".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              |  5 +++++
 tools/lib/perf/include/perf/cpumap.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 48595a3ad69c..7c8237a9e902 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -342,6 +342,11 @@ bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_m
 	return true;
 }
 
+bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
+{
+	return map && perf_cpu_map__cpu(map, 0).cpu == -1;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index d0ae9552f8e2..3b7c965a17f2 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -13,6 +13,9 @@ struct perf_cpu {
 
 struct perf_cpu_map;
 
+/**
+ * perf_cpu_map__dummy_new - a map with a singular "any CPU"/dummy -1 value.
+ */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
@@ -25,11 +28,18 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *or
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+/**
+ * perf_cpu_map__empty - is map either empty or the "any CPU"/dummy value.
+ */
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
 				     const struct perf_cpu_map *rhs);
+/**
+ * perf_cpu_map__any_cpu - Does the map contain the "any CPU"/dummy -1 value?
+ */
+LIBPERF_API bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
-- 
2.40.1.698.g37aff9b760-goog

