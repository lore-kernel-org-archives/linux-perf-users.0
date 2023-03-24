Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D3EC76196
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Mar 2023 07:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCXHYS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Mar 2023 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjCXHXt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337D12CEC
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:23:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e23-20020a25e717000000b00b66ab374ba1so1058328ybh.22
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+twZgD2lANnEj4Ejgw/Tmpo0NzizDYZveDuYYTFvBkQ=;
        b=SWvZOQZzGbL+4m830PxxQcYm/+IoASmFxlJxcy93YaBxAHqY2HYr0hb0AbK36J+Z1r
         KIcyGN0RnALk9GZNfMqrHdYVfBi9CW3eMQPBmdUuCL6tgnD+2TurBHTMPNmjEV9YpCmH
         ftN833h+lKBP3j6mumN9tfy/OSPTuwwPnGu0bLJe6CK0KDKk1zfA2k617TC+gIag4kxD
         zYOzmQjbb6/8V6gfyGXDl9xKSOpCY25m5jjMCV41exFdA3OhVpVtZpq4S1dD8XmB0NYG
         iRISrPiVbGMumorkMHZNWN2IVqgRE+lccnzdAllCJlxMAi0iabaSONF3Xjfvy7KlTgBL
         elVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+twZgD2lANnEj4Ejgw/Tmpo0NzizDYZveDuYYTFvBkQ=;
        b=fNQNc36TngSTJMg1BQwctrsH68f3jttLqK5WIcv5dk82Zdur021qCWazVLNCTqpCSr
         BaY/NoItgzChX4P7fJGEK/PUo1gpPo8zlscc8eDHD4JA+Kt10mYq7V9UMUp6bRD158cC
         qAqbPBK6/CIIqG1vT4iPJ1rL/Q9VyxpPC6FUUw4cpnQFs5+cjHIhySz11aQFRpP8o90i
         nYG0CkMKh9CE40GAMc+/eFOuCP0d3pYcSPtu2jRFg53NJzV2IgxCyvwYHngMkzexVlkn
         0YLKO4dQcRoMTjOlOAhh60LgRzn1DccowavPq6L3LPqBIjfdnS4szxKJz8fFlhwEWYqs
         YVAQ==
X-Gm-Message-State: AAQBX9dwIYKMJzj8PnamJCqBMqlLPVMpHI/GNDZtkZrYbBSJVdpDDCh4
        C9/mZiOYas4SLQZjNAlpfKNTMxl0Jhy1
X-Google-Smtp-Source: AKy350aXXKzgEOH65S8VEA7hDBdvZm+V3aREXE/mfJ94S5n64ddYtTWpd4eyhZD3Cq+Nr+hLeclvv1QNL9L+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:1148:b0:b76:5c0b:3573 with SMTP
 id p8-20020a056902114800b00b765c0b3573mr574672ybu.5.1679642613109; Fri, 24
 Mar 2023 00:23:33 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:16 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-8-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 7/9] perf vendor events: Sandybridge v19 events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds BR_MISP_EXEC.INDIRECT event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv               | 2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e41c289fa427..41d755d570e6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
-GenuineIntel-6-2A,v18,sandybridge,core
+GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 54454e5e262c..ecaf94ccc9c7 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -210,6 +210,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches.",
         "EventCode": "0x89",
-- 
2.40.0.348.gf938b09366-goog

