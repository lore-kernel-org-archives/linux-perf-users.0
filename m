Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF7C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbjEXWUc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjEXWTu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972619D
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564f529a663so17145317b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966761; x=1687558761;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xd01CL3jOJbGF1MdyCfHBtynZgthLa7uNIoTlZJdaI=;
        b=sfZwY4oHNiERT5Ej4VI2afyCtp6uICFBvoLiXGVvFrtLNuHnwLhezYlJn0HqZcp3zl
         TlU9iGhSmDyrtPStvmTlhj0KGIknmCK0GNmJeF7HQ7T59DIoQKUNx1L3xSizNhbJi6z1
         O98VBZmY9BzuHjvQFQH8fBvB6merTovoP0+WNsaTQg2go7RVmFLHCsyR7uWAAeiX2qRd
         ivAHYJB6+sz3QnKQIJKskdj2lL8PZt1xgh5Jbh3L1MHi79jXMgtiag4hKUS3TN6pZxNe
         plmtCeuXG8x9hkON0EqRlH6fVi+JAFPWj2OQMiwW4B3araTSpJgGGFEydXRaIrR/WN4T
         zFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966761; x=1687558761;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xd01CL3jOJbGF1MdyCfHBtynZgthLa7uNIoTlZJdaI=;
        b=Y5PjVJ21dIhZIu9VbdCfjxKmK6cCWPxBVr4jhlZ54hWAlxFvQTqf7jLl+fuaRr9wRP
         cNXHi2UqfwbF8wd7YTbwvQh3WMZkAyf2hh5I2M7REWQgZe5hfC93Rva1xD6yuXcH5E07
         bIsZN9BDRfKMNymARFtcX4W1hva6R3fs/bt0KtMUQTsn2IoE7ZTZa3gdQZVSjfnKkUVI
         c2q088vgL6ZRHKq07+4HCm+IKdFJQUpnoNxQDvH2eA62xnTFuALmm3siBxa8fr4lkiBZ
         G9Tw7sfbPAo8RN1yphIjfXA+uWYfEd/0EtAXxNosdgrSHwlJEif1psCD38Om5kHswsrH
         TFfg==
X-Gm-Message-State: AC+VfDwGz6NT53xkLy286AKX6CD/BofqtqS/wcMXfyBKDMavO0XqcCjl
        90lfKvq/pzpPFiUmOxv8LUUD3hri0w2v
X-Google-Smtp-Source: ACHHUZ6bVQEXtGkTgDxBcWnN++oUxBK/vjzxL4GN/XJx3EK1ZxC+pTtG2hZQ11b/lDM9hIloqisUyeXjFTXR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:4523:0:b0:54f:646d:19c8 with SMTP id
 s35-20020a814523000000b0054f646d19c8mr12119291ywa.3.1684966761430; Wed, 24
 May 2023 15:19:21 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:16 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-21-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 20/35] perf evsel: Compute is_hybrid from PMU being core
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

Short-cut when has_hybrid is false, otherwise return if the evsel's
PMU is core. Add a comment for the some what surprising no PMU cases
of hardware and legacy cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1df8f967d2eb..1c6e22e3f345 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,8 +46,8 @@
 #include "memswap.h"
 #include "util.h"
 #include "util/hashmap.h"
-#include "pmu-hybrid.h"
 #include "off_cpu.h"
+#include "pmu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include "util/bpf-filter.h"
@@ -3132,9 +3132,17 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 	}
 }
 
+/**
+ * evsel__is_hybrid - does the evsel have a known PMU that is hybrid. Note, this
+ *                    will be false on hybrid systems for hardware and legacy
+ *                    cache events.
+ */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+	if (!perf_pmu__has_hybrid())
+		return false;
+
+	return evsel->core.is_pmu_core;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
-- 
2.40.1.698.g37aff9b760-goog

