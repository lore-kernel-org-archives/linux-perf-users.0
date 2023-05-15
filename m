Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40837C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbjEOQvx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbjEOQvd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 12:51:33 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4D55BC
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 09:51:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-645538f6101so46806891b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684169485; x=1686761485;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Zp9tRh+FO1zLUbEzGzOtScVTBYPqTpeZg2SlWORkVg=;
        b=fUe8uIYoq6QXxQg5ptSRPuQW8LfC3SYChEv+rjCssHCMF4bjAoiYHSvo8Ukijxpt/j
         RIs/zPmmbqVPinsh38wWKAXfG85D/dW/HUER8QIH9IHk/vMcMwOXB45y6r3pNaCgAXPA
         jmDzq26FxdpZ8aVT2YX40wcTgiBB36wGz2MkbOSHpMnwsgQVlHjkhM6Eczi4o/EQgSVq
         vwjzC3p7Z2bWwV09S8OAtHwrPpiIZouWtl3xbcrtnT875cqFbDl1+NSWu+7iGnroj0la
         agV4lHtAZi21D+iaDF1PrLXifCcIVFVUUH43Cx+1VUbqwzghglYTckKI8huWfjsDc231
         IqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169485; x=1686761485;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Zp9tRh+FO1zLUbEzGzOtScVTBYPqTpeZg2SlWORkVg=;
        b=gsv19Yn1YwUM4v85K4oUhupYCx0njcY6RiaUyCTWA4PPdh9sEGUDnlgYyKIOhs7fhe
         oZcGXpUjfnmjyfvBMPTK7OIpByc9edu8P5rlyZZ9jfc4IB4Oc/6ZXD0HU2/NOqJitMz9
         aAmAQo3ytSyD21gG7AsMb5DZjaWreYwFLKNL6SKScFsn2i/Ln+3oQKNWmPWc5FWKRAAf
         GTdV2Gge5mbbvhONQuZHqLKrHW2Whg8VXnb1GSCFEdyIWFPi0WfrQyKlvrsgxF182lKQ
         ycW8dwOgbJmAIt8T4XsSzqoDhnHj3hv/8UrTNaE9e0AitQ36llbIxuTHb7BEgGs7YQvG
         1eWg==
X-Gm-Message-State: AC+VfDyVAQBc0UOrlQ8rfTY2bTAq8DLprotqNf6p4YuO/Qmd1Hs/Tcb/
        x7gTttZm2P5Xv5M2UEFsaAAWgaNJHdiQ
X-Google-Smtp-Source: ACHHUZ6bdv2ATRwMm73jY39auKUdui6mQ8hUAXxgBhGFpkDDF32OO7DEtBhPDyO5O60jrvxsshXXx4SLysWm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a38b:39c5:e0c6:e9f])
 (user=irogers job=sendgmr) by 2002:a63:2ccf:0:b0:52c:4e3e:24ef with SMTP id
 s198-20020a632ccf000000b0052c4e3e24efmr9462225pgs.2.1684169485265; Mon, 15
 May 2023 09:51:25 -0700 (PDT)
Date:   Mon, 15 May 2023 09:50:39 -0700
Message-Id: <20230515165039.544045-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2] perf arm: Fix include path
From:   Ian Rogers <irogers@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Change "../cs-etm.h" to just "../../../util/cs-etm.h" as ../cs-etm.h
doesn't exist.

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 860a8b42b4b5..a9623b128ece 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -12,7 +12,7 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "../../../util/pmu.h"
-#include "../cs-etm.h"
+#include "../../../util/cs-etm.h"
 
 struct perf_event_attr
 *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
-- 
2.40.1.606.ga4b1b128d6-goog

