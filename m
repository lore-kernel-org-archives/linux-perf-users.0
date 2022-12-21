Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2AEC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Dec 2022 22:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiLUWfR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Dec 2022 17:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiLUWfF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Dec 2022 17:35:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D18178AB
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Dec 2022 14:34:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a5-20020a25af05000000b006e450a5e507so19307725ybh.22
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Dec 2022 14:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6Ltg4f6uWL2k+LZiF466krcgS3aBizbqVelMESPLmU=;
        b=KLo5zAINtEhTy5AFiXvYhnTWFonz2gHXklS2cIgblZMzDqBGkvD/GjAhIbm8nbedAP
         G43TLqjfZ6HYOq6kQ3M6MlobEyHfYtBTwzBDWRY/dm++ym7mS1yUHPofAqRwrn2R9QTg
         ZUN2Z4vunBRPE/O73l2AeZy+wuvJR97b1giojICmxup/IQgwWU+JA9ojKBP2fkomqql7
         ScZmQ7bSmFvruZvR4ImWtFGVRKLnQvkCks8Yq4MAzbAYZrWkjagLKSOjUwM0JrgKJDd6
         x8JqtGCGq7mXrCezWgcnTJlXlDVc4lMkKIq32ZgeQ7x4oKx+RdEHJsX3QoiCzLZLgNCa
         iyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p6Ltg4f6uWL2k+LZiF466krcgS3aBizbqVelMESPLmU=;
        b=jyXUJ8iHDnQVw+QEJrNH+XsfkStJdSH6plBeTvlzi22HAMoPTAKU/937Ac9nIaG5ve
         TEH2mUYY35PAPeul6hek6folqdvWf8RQ8gBMw//2kmdjxy+AU2uMPT3pQ7V9ytrhbfar
         nEObxHH1efPSjidR4SdL79flFr7SSZ9cP3tY2NqF9ydxImYUg/f9WwXybXeShRox5ZP3
         f7K32RxfSY3nLLUd4JGxt8w7PRR5hhk0iOYarlfQQXPe95JLNuUwdXPW7ywjaUJ7iuaR
         1AwVnJRMkDo4FFbXxzGn0kkmrjDcxFMu5MgD8tbPCkf2dPLSKr8jPOGW++/WZlPZEzx3
         aCwQ==
X-Gm-Message-State: AFqh2kr5AdzXYNHD4OiQVE2K5pQkmND5YgYTK0W2K9slUC0vxQGp5jJS
        aBIIvuQ2P/wIwazNUiSpOl+WsSxD3CKA
X-Google-Smtp-Source: AMrXdXsci0AMSF8Hr2DpdojcQrgVMbQ5l9lfm2lHEIIViWRShp+iXq7vcYMkxVW6Y3EwFrGoDRp5Su0CP7t4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:62bd:f120:1fd8:1d21])
 (user=irogers job=sendgmr) by 2002:a81:b642:0:b0:373:6e8a:e7db with SMTP id
 h2-20020a81b642000000b003736e8ae7dbmr317784ywk.144.1671662090799; Wed, 21 Dec
 2022 14:34:50 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:14 -0800
In-Reply-To: <20221221223420.2157113-1-irogers@google.com>
Message-Id: <20221221223420.2157113-4-irogers@google.com>
Mime-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 3/9] perf jevents: Rewrite metrics in the same file with
 each other
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rewrite metrics within the same file in terms of each other. For example, o=
n Power8
other_stall_cpi is rewritten from:
"PM_CMPLU_STALL / PM_RUN_INST_CMPL - PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_C=
MPL - PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_VSU / PM_RUN_I=
NST_CMPL - PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NTCG_FLUS=
H / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL"
to:
"stall_cpi - bru_cru_stall_cpi - fxu_stall_cpi - vsu_stall_cpi - lsu_stall_=
cpi - ntcg_flush_cpi - no_ntf_stall_cpi"
Which more closely matches the definition on Power9.

To avoid recomputation decorate the function with a cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 4c398e0eeb2f..229402565425 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -3,6 +3,7 @@
 """Convert directories of JSON events to C code."""
 import argparse
 import csv
+from functools import lru_cache
 import json
 import metric
 import os
@@ -337,18 +338,28 @@ class JsonEvent:
     s =3D self.build_c_string()
     return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
=20
-
+@lru_cache(maxsize=3DNone)
 def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
-
   try:
-    result =3D json.load(open(path), object_hook=3DJsonEvent)
+    events =3D json.load(open(path), object_hook=3DJsonEvent)
   except BaseException as err:
     print(f"Exception processing {path}")
     raise
-  for event in result:
+  metrics: list[Tuple[str, metric.Expression]] =3D []
+  for event in events:
     event.topic =3D topic
-  return result
+    if event.metric_name and '-' not in event.metric_name:
+      metrics.append((event.metric_name, event.metric_expr))
+  updates =3D metric.RewriteMetricsInTermsOfOthers(metrics)
+  if updates:
+    for event in events:
+      if event.metric_name in updates:
+        # print(f'Updated {event.metric_name} from\n"{event.metric_expr}"\=
n'
+        #       f'to\n"{updates[event.metric_name]}"')
+        event.metric_expr =3D updates[event.metric_name]
+
+  return events
=20
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
--=20
2.39.0.314.g84b9a713c41-goog

