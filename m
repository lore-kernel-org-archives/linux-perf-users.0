Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BBC00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 07:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiG2HoG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiG2HoF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3874357
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s14-20020a5b044e000000b00672caf96368so3305464ybp.21
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gJpUpfYLbWgWjOwgXjGO+9lnopmpvExo4+EzC9HEZTY=;
        b=dGCDlxqp0N92i8FI8IxZI0RMts2CVs6exeUrA29GDqYZd2sk37RGoacdGjeaGAaPEl
         veyYOZBOQmOc24vq5FT0+v67NmYoZPupwBcSbyu/TNItgl51jakqAeFTk7FmNHcuwF5s
         pyIEjbOqMtfjIMC0SNfrA/UQR/Pr/nXMZCMoS2MA3Tz7jvRTZwt4bIihGAMsFxtssia9
         seAGqe9IhHByUB8BHUkgIW6PmueRB80GtUkYVRFSbRtaBOL1aiIn8a/sQ1FGp59m7yT7
         JqR4pii4eZKYpIEeR1WUkTYi/kra01qzW5F6bRMrxFc4RW5XMmwU+T37ESVmuzmhsVCX
         WIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gJpUpfYLbWgWjOwgXjGO+9lnopmpvExo4+EzC9HEZTY=;
        b=yNI1TEI04aDxRu32II9nM0iESgKcpzNvK05LCRpJSXVEdGM18JAWbqBaSuQTbWdOuh
         ldrWaPnDW5fSmmV0NSw4fKX82JQSpoQ04PxhL2BLvkb+7gkdV8gqOHJLMqNo8W0VTiHs
         m8vq8Lsg7xEnlffCFMPl0Rj6j3sEVxuwC610S4HoEbYxDc5bx9NLqm+n7Uqo9kTomSFs
         N2lgMPYoiXvnj1nkyvksoVgArKNxPpKa+XbMbewb/v7kpN/vy3yRpeqAViYKNwb06jfn
         g3GZ6Qkkw7bm7yWTWQejPWGSAowSRjd66Pv0ZtGsKiaecjdzihHB88tnwVS+RmknP4Uw
         PtBg==
X-Gm-Message-State: ACgBeo0/tt8nJrXGdLyQf1JRtvAghxVUt4Lixs2Tr4LA6fz2zA8Ba1Zi
        S1GE31rKD9j5K7ixczXi8gfqwnyBkRFD
X-Google-Smtp-Source: AA6agR4xDcMfnB3k6eIsa+YSBZau3gw42uQA+UFZp9uzUXHPo8lYPYIQ1NrBgvJdmk8BPuBm/TWyurtIPhKV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a05:6902:70c:b0:670:bb85:766e with SMTP id
 k12-20020a056902070c00b00670bb85766emr1640653ybt.428.1659080644298; Fri, 29
 Jul 2022 00:44:04 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:35 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-2-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 01/17] perf jevents: Clean up pytype warnings
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
2.37.1.455.g008518b4e5-goog

