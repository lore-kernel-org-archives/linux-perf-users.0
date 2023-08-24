Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86A0EE49AD
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 04:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbjHXEO5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 00:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbjHXEOg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:36 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F93171B
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:14:29 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c0c64035b8so2761575ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850468; x=1693455268;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+7xUX+eQzSie7iWr2Aj1jLiysTzidRjiqSjjI4y5Nk=;
        b=uU1EeSRyWsOnWw8WEo2g3bS2sR9n78nACyt4JfvClGGDbCVGCoCvCZsQqpt+AZ2CTq
         YJEBNspR5QYXGNXUpidC8y0uaV+h7RkN0R7zg1zvA68LMQEI9jZNhJIz+AIWj7xTqKZY
         sGd4skfuyBLEAIwqroRuh3zqwCrbNAN3HOL5zEa2N+N32q+VSOPHHDCFR9w9zPx6b4EM
         gDIjcYujmVBTUEpsWKx9sWxNG3D7VVdjyVjG0gMmuKOJz2uoOYL7PcyRLEr6mZ+k9AZu
         pvuGWtNZ4aB2ftmOL3awDgXXaWf+LlBLNLKgjQE+swgMFHKB0Hqui0F3ABcQ3LGfGS7j
         AR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850468; x=1693455268;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+7xUX+eQzSie7iWr2Aj1jLiysTzidRjiqSjjI4y5Nk=;
        b=Hab4Ig3sBXEmpw1ZrrW80+XAE2yNYX3Dz5UbJsPdwgHH3tx7HUr2JuZFhJblgIjeuB
         OurMUKOUyA77ZuP/c8/4+qxPYJBJzV0irnfyPkzFhA55gC1ENZhUhreC7LH45gpsOrAE
         liH/wXRQqV8xRhM/F9wQLiMX7XDiR6GvxUfdz8tM5PZVp8IXCJyCte80cFa3vb3oP6bQ
         Bz9aPsbBZXQm7ixlEuA04asQO3kLawCo6Cl4PUUozbVG+VGF/HOzs/2lLYO+vvzNyt29
         nc3D7Sb6kXvA1VP6DaTixMiGtUw+xtNVNXUHs+BGz64SZq6fLx/2FifTHhAlNTFj9ulb
         wPGg==
X-Gm-Message-State: AOJu0Yy9XtYkMmj0gi0kHTnFXMpBxLJn8pkm7itcTLjIGpbjwNym84J3
        13sSJ4VbR47xi5YLcChavOiFEQNg6Bu8
X-Google-Smtp-Source: AGHT+IGUdFfyT2rsPjoGhQ7i1sFxV31nUqycJqtfiepKpwR//LF7/kpDZWU4+yRSyscZ09VLHA9H44SdCBhF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a17:902:fb05:b0:1b8:a593:7568 with SMTP id
 le5-20020a170902fb0500b001b8a5937568mr5165739plb.8.1692850468304; Wed, 23 Aug
 2023 21:14:28 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:29 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-18-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 17/18] perf jevents: Sort strings in the big C string to
 reduce faults
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sort the strings within the big C string based on whether they were
for a metric and then by when they were added. This helps group
related strings and reduce minor faults by approximately 10 in 1740,
about 0.57%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 01335a452e70..e5bce57f5688 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -113,13 +113,24 @@ class BigCString:
   strings: Set[str]
   big_string: Sequence[str]
   offsets: Dict[str, int]
+  insert_number: int
+  insert_point: Dict[str, int]
+  metrics: Set[str]
 
   def __init__(self):
     self.strings = set()
+    self.insert_number = 0;
+    self.insert_point = {}
+    self.metrics = set()
 
-  def add(self, s: str) -> None:
+  def add(self, s: str, metric: bool) -> None:
     """Called to add to the big string."""
-    self.strings.add(s)
+    if s not in self.strings:
+      self.strings.add(s)
+      self.insert_point[s] = self.insert_number
+      self.insert_number += 1
+      if metric:
+        self.metrics.add(s)
 
   def compute(self) -> None:
     """Called once all strings are added to compute the string and offsets."""
@@ -160,8 +171,11 @@ class BigCString:
     self.big_string = []
     self.offsets = {}
 
+    def string_cmp_key(s: str) -> Tuple[bool, int, str]:
+      return (s in self.metrics, self.insert_point[s], s)
+
     # Emit all strings that aren't folded in a sorted manner.
-    for s in sorted(self.strings):
+    for s in sorted(self.strings, key=string_cmp_key):
       if s not in folded_strings:
         self.offsets[s] = big_string_offset
         self.big_string.append(f'/* offset={big_string_offset} */ "')
@@ -574,19 +588,20 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
       assert len(mgroup) > 1, parents
       description = f"{metricgroup_descriptions[mgroup]}\\000"
       mgroup = f"{mgroup}\\000"
-      _bcs.add(mgroup)
-      _bcs.add(description)
+      _bcs.add(mgroup, metric=True)
+      _bcs.add(description, metric=True)
       _metricgroups[mgroup] = description
     return
 
   topic = get_topic(item.name)
   for event in read_json_events(item.path, topic):
     pmu_name = f"{event.pmu}\\000"
-    _bcs.add(pmu_name)
     if event.name:
-      _bcs.add(event.build_c_string(metric=False))
+      _bcs.add(pmu_name, metric=False)
+      _bcs.add(event.build_c_string(metric=False), metric=False)
     if event.metric_name:
-      _bcs.add(event.build_c_string(metric=True))
+      _bcs.add(pmu_name, metric=True)
+      _bcs.add(event.build_c_string(metric=True), metric=True)
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
-- 
2.42.0.rc1.204.g551eb34607-goog

