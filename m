Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67384C77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjE0HZZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjE0HY0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:24:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006119D
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:24:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb7aaa605so3278749276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172205; x=1687764205;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV00wr0m01A6RSOkoZkdtOocxHuwovS7qVF3tDIwPhQ=;
        b=rK8JvQoJKZgwKm6DboQJ93FRgY5M8ICQejv0IU3Tq4c8na4T8hwI/bL6+HiKno3OsL
         hQgr7XewnMGnBGftqrpCAbjk0gGya0+7ukosSu7sOwYahsFpIROyTRMq+mKrMZISql+i
         PoNPv+nt5DqxN8UbwgHpIRkxS0y6+Xs7tQEAUDgRKTZZ+w4iqqyFFnGkBMMx78nFW5px
         Tl8GlelqGP/NY4D/06naW8NtPMSJ3paV0+LP3CL5HDZB47kpduX5zc309esfB7csngR+
         cHsqCI/4yCjM3ZyMO2dCpvB2+qr267BZVldojts+Tu82AJhBie8g/ml5rTfMcLMFwPZq
         DvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172205; x=1687764205;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xV00wr0m01A6RSOkoZkdtOocxHuwovS7qVF3tDIwPhQ=;
        b=Pilj/M7U1ACJkNoAkY0IkFko4dxEaw9Ci8+1QFZWNBIrQrxFw9+Z/PHjtGdjy1B+RA
         vDlwjLimg3xnTQJTBXtEWHR+t1tXXiMMOyHqnD5DMMIv9GszvnPvrW7Z8dm2eGZ3PsuZ
         Irf4tjpN+9zS+vdwweKVFRy9bPZqy29iLwhctSHD7amTHwWq5Yn0ze4Z4gNCeAHtbgMp
         QQmDxiZUqjtIZkqufWu7IObFtgwjosEx5DN//A9Rj94bbavGuYCMLVmrgRVl6Z+Tn1Bm
         zHRz7wTsA0ofANMwteUlm0n4QhAHOPsEZnjH0mFS0ScsdYnqoQYASOJxZgKrOCv8EKzW
         vNUQ==
X-Gm-Message-State: AC+VfDxew18CcX8usmD09G7p+na1gGwGJ3FOVvqcccq2D9lvhmDjOn9Q
        w7JlU4aXZw7sE7D3TQKMgHbxQSXC2BIe
X-Google-Smtp-Source: ACHHUZ62JID7B+OjoC1CY/SdoHqFqkzydfiQtXeNoSpuVp8hOQzs+9Pa475+hIDtyG5ZA3JP5bPrFQq50gxY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:9706:0:b0:ba8:1e83:af32 with SMTP id
 d6-20020a259706000000b00ba81e83af32mr2333617ybo.1.1685172205108; Sat, 27 May
 2023 00:23:25 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:58 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-23-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 22/34] perf stat: Avoid hybrid PMU list
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

perf_pmu__is_hybrid implicitly uses the hybrid PMU list. Instead
return false if hybrid isn't present, if it is then see if any evsel's
PMUs are core.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/stat-display.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4cce7d3c5e52..a3e184e0b5ba 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -19,7 +19,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include "iostat.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -695,11 +695,12 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
+	if (!perf_pmu__has_hybrid())
+		return false;
+
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->pmu_name &&
-		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+		if (evsel->core.is_pmu_core)
 			return true;
-		}
 	}
 
 	return false;
-- 
2.41.0.rc0.172.g3f132b7071-goog

