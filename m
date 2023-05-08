Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC53C77B75
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 May 2023 21:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjEHVbu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 May 2023 17:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjEHVbp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 May 2023 17:31:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BE983F5
        for <linux-perf-users@vger.kernel.org>; Mon,  8 May 2023 14:31:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso37023995276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 May 2023 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683581493; x=1686173493;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbgAGNI+jtBJ6/C5+rY59MHLdq0bPiPylAp1nQ6EvFY=;
        b=1rR6+YSoVSx99at6wdoEphzxoMCPRs1p1vKXaAj3dOvy/esrEuCHCWNAQyN34rrpEe
         ztL6dd7bkVl40gfKoU3Ryx/CyfGQYYJysHx5bZpTX+DMzBbG7YMLeuLbgbp+3a8a0KZH
         2UG7bvIMYa/3sfu4AuPUWzo71BA733QFqvqmtdf5CBNrOaXzSpY5zGGCcZ2pmXnanHou
         3pSIBvQ33YJYyBWeynsooEzQVM3gPU6nMzvYw3/Smjn8sQHXfzZf5KwhvURrx+c/B5sU
         iyoQtJ4z0iKNSdCQUbn6HGZI390BFipfac59wfNGPSTsu4ndRxaX8AvTaubq+8RctLsg
         C9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581493; x=1686173493;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbgAGNI+jtBJ6/C5+rY59MHLdq0bPiPylAp1nQ6EvFY=;
        b=CPCWsycuVKP4Y9prlNJat2M5ZPKCyH/zioTDHEWsWt3jGITEXd3vq/olJ6tbS3FyyE
         wgLmRQqYeZA6QZ5WixxzoIPLA4HXG5i1SgKfWp/2+E46B7RM8hJ4sTkWUcxUWieBMAyr
         nAKBi4DJwi/rBidkiOQ9V8k4w8DZ+kGiGQwlnuewUyJjTxayTXJQntl9sPkCfwIZtOrF
         RK2QlDaDQFfrYG9TbxpHGg46X6xnITXWvAbBHlgQYTg4/vCOYnHJpTs1EUDxsTCmf3M6
         +ICpG6RQVhCghosTdCuFO79MnXV/yXY6kJdYYRx4KGqtTstqw6CF73Bp3maoSP+Mbb6m
         cN5w==
X-Gm-Message-State: AC+VfDyvgOcU1tvqKxGAT5s0VA0meajURJqaXnt2/9YbntFyJjQJfoF8
        zXhYx6PqSk4L4DmS/yqk4lJiCfP0UP1B
X-Google-Smtp-Source: ACHHUZ7Y0TBeQX2fd8lGvisO3nhb1pLzb0aA5uKxiANiaOdr2vJEWbJRrVvcs/WRCIT2N6iql56deytoA2V+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9cc5:6f12:98dc:d684])
 (user=irogers job=sendgmr) by 2002:a25:5404:0:b0:b8b:f5fb:598d with SMTP id
 i4-20020a255404000000b00b8bf5fb598dmr7276423ybb.6.1683581493105; Mon, 08 May
 2023 14:31:33 -0700 (PDT)
Date:   Mon,  8 May 2023 14:31:28 -0700
Message-Id: <20230508213128.3622268-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1] perf arm: Fix include path
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

Change "../cs-etm.h" to just "cs-etm.h" as ../cs-etm.h doesn't exist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 860a8b42b4b5..46154c226fbb 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -12,7 +12,7 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "../../../util/pmu.h"
-#include "../cs-etm.h"
+#include "cs-etm.h"
 
 struct perf_event_attr
 *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
-- 
2.40.1.521.gf1e218fcd8-goog

