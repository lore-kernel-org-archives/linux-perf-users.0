Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D08C25B08
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 22:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiHDWS1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbiHDWS0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:26 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A061D68
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 15:18:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h185-20020a636cc2000000b00419b8e7df69so429316pgc.18
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=FuugmUCF0TvRTU+HzlBpRf2vN7sysi6PxjIgBXMJd4Y=;
        b=l5SBZQVnabn522EriGOrgVBqUMbRT8xQi8ySOJ9glx8sVCcnbvcUcqndcZpeLQ+zbf
         +xJfe7I5AHvmHn7n1eweTfR+QO6XOQbAz0nqcR5vk/7TuCW8EYPsC+TDifyQn2HxgRop
         WyP8zDUUK5tXAO2qulPSAB2ylG7qAN0tInXyggGgsS4/ijsZIZyn+woZDGt9iqckR6Yf
         bQmvCbVJNMG/Fwz1P15luRDcf7Nbxi0z5Xqpkl5/TLo2jebpgVngq017qCVIJ+2mAxN/
         NZ2N0Lp8DwmKCeH5mXl8nEnTpcrrVcE8bV+ks+Qre8Sh8blqqTF9ZwMzkwrBDHNcSrHt
         JU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FuugmUCF0TvRTU+HzlBpRf2vN7sysi6PxjIgBXMJd4Y=;
        b=Ox44b5kQHw6uZ2bfpoUoUamxIKn2HzZP1oUoZucO3v+Ameby9xIW8/8qLkIiWQGfUw
         CPNOJ1nk2RQEZXfaZR7hq6D8CDdPtSKPDY0ck6f5p3ibpvvM+Y2cLuybL4hz+s4VGjrN
         w7qciH/AJ0TfSry1D0c83XiqzFMYPGCI00VX65IYQm/NQ7gibXOnuE0MqyN8ZQzYCnhD
         5DjUJd2vxKLCPNwU+hXmg7RXKfrULVdzvCtGosb+XNJJWdHULKPCBW4d0NrM4gBqHPLn
         de8I/24k4ZhH7Iw+djzxfc/3CryoBXsiAig4Krgu8Z5iYX+s3oc8yIV7mmXysfrHsegb
         sdpQ==
X-Gm-Message-State: ACgBeo0XIC4YF9Y10BUX+S+ccfQHDA0t0h9v558Cgc/jeoxVwEJQ9vGU
        Ub1J7skSlwzf1D/brjs218AKGDrX7iDS
X-Google-Smtp-Source: AA6agR4FGBjujwgqDlSb71XtFqqVCyQxC3yG7Bm2g9hTbvY0gPg8s3VEUGL9nf+YZH1gR5gaEj346sgYjzrN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1395:b0:52e:128a:23de with SMTP
 id t21-20020a056a00139500b0052e128a23demr3962734pfg.5.1659651505336; Thu, 04
 Aug 2022 15:18:25 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:00 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-2-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 01/17] perf jevents: Clean up pytype warnings
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
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
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Improve type hints to clean up pytype warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 83e0dcbeac9a..5b72048d50da 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -6,8 +6,7 @@ import csv
 import json
 import os
 import sys
-from typing import Callable
-from typing import Sequence
+from typing import (Callable, Optional, Sequence)
 
 # Global command line arguments.
 _args = None
@@ -57,7 +56,7 @@ class JsonEvent:
                                        '. '), '.').replace('\n', '\\n').replace(
                                            '\"', '\\"').replace('\r', '\\r')
 
-    def convert_aggr_mode(aggr_mode: str) -> str:
+    def convert_aggr_mode(aggr_mode: str) -> Optional[str]:
       """Returns the aggr_mode_class enum value associated with the JSON string."""
       if not aggr_mode:
         return None
@@ -67,7 +66,7 @@ class JsonEvent:
       }
       return aggr_mode_to_enum[aggr_mode]
 
-    def lookup_msr(num: str) -> str:
+    def lookup_msr(num: str) -> Optional[str]:
       """Converts the msr number, or first in a list to the appropriate event field."""
       if not num:
         return None
@@ -79,7 +78,7 @@ class JsonEvent:
       }
       return msrmap[int(num.split(',', 1)[0], 0)]
 
-    def real_event(name: str, event: str) -> str:
+    def real_event(name: str, event: str) -> Optional[str]:
       """Convert well known event names to an event string otherwise use the event argument."""
       fixed = {
           'inst_retired.any': 'event=0xc0,period=2000003',
@@ -95,7 +94,7 @@ class JsonEvent:
         return fixed[name.lower()]
       return event
 
-    def unit_to_pmu(unit: str) -> str:
+    def unit_to_pmu(unit: str) -> Optional[str]:
       """Convert a JSON Unit to Linux PMU name."""
       if not unit:
         return None
@@ -154,7 +153,7 @@ class JsonEvent:
     if self.metric_expr:
       self.metric_expr = self.metric_expr.replace('\\', '\\\\')
     arch_std = jd.get('ArchStdEvent')
-    if precise and self.desc and not '(Precise Event)' in self.desc:
+    if precise and self.desc and '(Precise Event)' not in self.desc:
       extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
                                                                  'event)')
     event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
-- 
2.37.1.559.g78731f0fdb-goog

