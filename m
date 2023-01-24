Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD45C38142
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 06:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjAXGe3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 01:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjAXGeO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 01:34:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972493BDB1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:33:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-506368dc06dso23151637b3.9
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZSaBnOGu/YbrmaTZVReqHf2hRiUdQmwsWkYLcRqpH4=;
        b=QtwP2zENUXWgyJHEws+BG/kFMb+DmxPDNYY8UIr0limSpS9S9IAP3MRKKOjLy68uHg
         YGu0i3Flajm+2md1xS3IJjuju2tpXjRb4jluoezQwdWH0WxzT2vAfZGoHeX+kjJMB28X
         N747+5LD0auc7KLvYdv8aPMiBliZwca8AvbduJUTnEq6voumSG0HC+zSttGSFFxgY02o
         EfloucCxpZkcpSRjpWvVoL6G1Y/SxMnciFfUu1u1H8mlD1E5yGXGuLwqfiQz29t6j0+o
         mTSadFJ33kvQRNes3Q36k1JwZu/FTbMEWmlmEBfxc0y8Ml2snp5tG3BUgZgRnrZqTBRE
         oWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZSaBnOGu/YbrmaTZVReqHf2hRiUdQmwsWkYLcRqpH4=;
        b=6u5H7sxYqexZv3/01NNrBbNRQHZuMtIwHheMJBiI1/ttpyO4nx8NHP9acRLXdH4p9I
         kj9GlGN9vv9Aw4v8dvRAbVpubAiHJ684tmqYik5OnZn5t0CcArOZAN2sMIKfdI81YikJ
         k7a/Rx6dkhQoxO9GHzDUyJhHwjPZt58dpZ8iZzQJnfB4d/e24nN3lX9dUxGayx0iVcyP
         U2G+Vc0K6KO21iyLv9M4dlnPVlMv4ODTpXZ6u3bEgjcORoxkfrl5SBRrTjemXp0SUeBQ
         nk5yS8wXJoK13rXZXlAEsAzk1cpnlWpiZB5zK+FTSHBpWxvnVXf+EnksYMJ+iUXdBT2v
         5U/w==
X-Gm-Message-State: AFqh2kpQDqngniC56MpC9jKogw4ZtSzsqMywoE9GeMjC6Bv7C+z3KNY6
        iVi7mro+VwXHrMvQoMujIMl26qcVYF5S
X-Google-Smtp-Source: AMrXdXsJrxxO8jIp9f4xgEtR4Uc1j/O6uCmzm5bkzgsdb8o+F9xNdzJMgpeb8JqTnOypA/AiAzZUvpDGgAEA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a81:9848:0:b0:4d0:f843:c376 with SMTP id
 p69-20020a819848000000b004d0f843c376mr3009528ywg.63.1674542034884; Mon, 23
 Jan 2023 22:33:54 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:12 -0800
In-Reply-To: <20230124063320.668917-1-irogers@google.com>
Message-Id: <20230124063320.668917-4-irogers@google.com>
Mime-Version: 1.0
References: <20230124063320.668917-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 03/11] perf jevents: Rewrite metrics in the same file with
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
index 0416b7442171..15a1671740cc 100755
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
2.39.0.246.g2a6d74b583-goog

