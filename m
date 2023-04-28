Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB89C77B60
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjD1Hqm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbjD1HqR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:46:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C63C4EF5
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:45:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-556f0e26a1fso23449787b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667840; x=1685259840;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DTTYiMDl8Yj+KSHhgdntFRxS2mVbWmHBiQYwku76Lg=;
        b=qd+DYrRoF9UrhejdC0nON/UlJQaAIVFR5ZToOhT2HGt+8h9fVGOy+qgHbt4IX2bQrg
         ZmWAIxHaimCnyHyO2Zj10nznxyh6cb4t4jsmXyxeuPKWo3RcF6+0DsqHLwsRbx9d7kJn
         bmNGIPq0z6ZnYSnmdo+MH2vJo/sXSbodg4ku2cLCG/426YCnKrZHbUlnl+cOXelY487H
         QvYq04sZ6Su5J2LBmfHeYD8V24YPrYiiEdcPYcCXA8pVvVaHveXHn/QBfjXCxSVPtO6G
         Sw7HAk2kkRhMYYWgtz56zuOfXTr3OARaP24f8x5gegA1uOSP0HS9UYLdhuocCtBHXqCa
         gsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667840; x=1685259840;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DTTYiMDl8Yj+KSHhgdntFRxS2mVbWmHBiQYwku76Lg=;
        b=VbVeNIG7KWG1IrA7KHN5hvAIgrlU66D8qRLPaTXb2RXkGyM0aLffCZGOMo8mmWYxpw
         6H6JCQ/oZWPGC0fv+1PpMWn9T22r7iwCmqv/ALsxWrMz3K5tAL3Rd4H+OWNCieo85H2o
         ssDUIEIIhLJinD3UQLuJ3c1IMTkg7BiLn9oUD8m7H8q0zqF5EZ2PkxUnjmx94+FhWRuQ
         s8hta/KULkl3asT2E1/TJ5zfsowdqCEtx8pmCxhI6ajN9GVjwo+UnatABBP1y+oaAsSN
         rQwiM8Pdv6ambKF0GHNKgSqkxqAC2dr0e2N0cJ1+n55dJwVDGlEHkmvNJTqOS+NrpWMd
         K52A==
X-Gm-Message-State: AC+VfDwvRPNgCHt4fEGc8mccp4hzig0kpiCGE1vms2baI1FEVwv/2p4h
        HR6GL05dVHl2HAkX9UzJELTwHQKaPGgp
X-Google-Smtp-Source: ACHHUZ5nEY59oqWs0BVgiEE56Hl1+RolQfKAt4eBAdzdB0mfKpY48+4gnBWIfxIjzYbVg8OFygH2dRdb3TFW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:b145:0:b0:54f:b56a:cd0f with SMTP id
 p66-20020a81b145000000b0054fb56acd0fmr2839463ywh.3.1682667840314; Fri, 28 Apr
 2023 00:44:00 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:06 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-41-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 40/43] perf jevents: Don't rewrite metrics across PMUs
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Don't rewrite metrics across PMUs as the result events likely won't be
found. Identify metrics with a pair of PMU name and metric name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py     |  4 ++--
 tools/perf/pmu-events/metric.py      | 28 +++++++++++++++++-----------
 tools/perf/pmu-events/metric_test.py |  6 +++---
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index b18dd2fcbf04..487ff01baf1b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -391,11 +391,11 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   except BaseException as err:
     print(f"Exception processing {path}")
     raise
-  metrics: list[Tuple[str, metric.Expression]] = []
+  metrics: list[Tuple[str, str, metric.Expression]] = []
   for event in events:
     event.topic = topic
     if event.metric_name and '-' not in event.metric_name:
-      metrics.append((event.metric_name, event.metric_expr))
+      metrics.append((event.pmu, event.metric_name, event.metric_expr))
   updates = metric.RewriteMetricsInTermsOfOthers(metrics)
   if updates:
     for event in events:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8ec0ba884673..af58b74d1644 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -552,28 +552,34 @@ def ParsePerfJson(orig: str) -> Expression:
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
 
-def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, Expression]]
-                                  )-> Dict[str, Expression]:
+def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
+                                  )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
 
   Args:
-    metrics (list): pairs of metric names and their expressions.
+    metrics (list): pmus, metric names and their expressions.
   Returns:
-    Dict: mapping from a metric name to a shortened expression.
+    Dict: mapping from a pmu, metric name pair to a shortened expression.
   """
-  updates: Dict[str, Expression] = dict()
-  for outer_name, outer_expression in metrics:
+  updates: Dict[Tuple[str, str], Expression] = dict()
+  for outer_pmu, outer_name, outer_expression in metrics:
+    if outer_pmu is None:
+      outer_pmu = 'cpu'
     updated = outer_expression
     while True:
-      for inner_name, inner_expression in metrics:
+      for inner_pmu, inner_name, inner_expression in metrics:
+        if inner_pmu is None:
+          inner_pmu = 'cpu'
+        if inner_pmu.lower() != outer_pmu.lower():
+          continue
         if inner_name.lower() == outer_name.lower():
           continue
-        if inner_name in updates:
-          inner_expression = updates[inner_name]
+        if (inner_pmu, inner_name) in updates:
+          inner_expression = updates[(inner_pmu, inner_name)]
         updated = updated.Substitute(inner_name, inner_expression)
       if updated.Equals(outer_expression):
         break
-      if outer_name in updates and updated.Equals(updates[outer_name]):
+      if (outer_pmu, outer_name) in updates and updated.Equals(updates[(outer_pmu, outer_name)]):
         break
-      updates[outer_name] = updated
+      updates[(outer_pmu, outer_name)] = updated
   return updates
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index 40a3c7d8b2bc..ee22ff43ddd7 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -158,9 +158,9 @@ class TestMetricExpressions(unittest.TestCase):
 
   def test_RewriteMetricsInTermsOfOthers(self):
     Expression.__eq__ = lambda e1, e2: e1.Equals(e2)
-    before = [('m1', ParsePerfJson('a + b + c + d')),
-              ('m2', ParsePerfJson('a + b + c'))]
-    after = {'m1': ParsePerfJson('m2 + d')}
+    before = [('cpu', 'm1', ParsePerfJson('a + b + c + d')),
+              ('cpu', 'm2', ParsePerfJson('a + b + c'))]
+    after = {('cpu', 'm1'): ParsePerfJson('m2 + d')}
     self.assertEqual(RewriteMetricsInTermsOfOthers(before), after)
     Expression.__eq__ = None
 
-- 
2.40.1.495.gc816e09b53d-goog

