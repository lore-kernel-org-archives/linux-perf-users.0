Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7D5C27C76
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 01:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbjAZBT3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjAZBT1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 20:19:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB5961D65
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 17:19:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a14-20020a5b0ace000000b007bf99065fcbso377077ybr.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 17:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=huD0JuZGEuI+QB16/3OseXYdE1VwZ132kWp/N/R3RrQ=;
        b=rTbDbMoZwX1IxiSAhBMvgsAMkwqnPSsCsT3OJVNe8UCTB/FWTprz5k4uKZp1tDZ7lF
         duLEgY0/eRTz7UK6fvuf2BUpehJvLT5EfvcQ2ERgEj3mMXfpcN32qGV95ZLPxlFKFat6
         gxGUbfLV2lIuWvBk42OWCvATH8vWKdZfRGTf9iZ3hReoi9b54Ji6SVJsUsROsBPZ5zfa
         RUXgztW1PdZ5x/JW7fHO2R8nM3cplbx4cM4jIL2AUR4SpjIBb2l72iodLt9cLTf/ylZy
         /AZP1zGM0b00OZ6/Dl5o2ximJbHk2eytTwW9w7RdiPgvK1bL0//e3wmE+VpFGOoHfhUZ
         QlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huD0JuZGEuI+QB16/3OseXYdE1VwZ132kWp/N/R3RrQ=;
        b=PetJoWs31qd8NyZB/CAUMuYaL/rLLwNqcoFUr0EqczQYkpMEo/Qhj66A8Z9ReEATbC
         6AMT3Cicb+XTsqbSqacjy2ZsAhVnHy3DUGcyAY3J+erE+28Xly6fFTZogT0JlksarrUP
         DGV0SR9PelpOIiNpFojPd+Q2cgcSrkWwp9+WFPvmXXirRQd1Dm/EDAA4+K3haTn3tzcq
         G2/22PnYrbcGgUL/qmYdg0q21s1t9nHKCVJn5yNLxySacxh6fB1NvPnEzBSMS11QIfzp
         asLjJHvlCne2szHEAo4CWRfMHFvwEmbW0xLPJgxGfSaVLHnhQYIk10KSVH3S1uhH4R4K
         +3BA==
X-Gm-Message-State: AO0yUKXghD3+VFGrDZw4HCRyxJr99xVfWg5yLghZgIh3QHtIGKvr6q7z
        PC6UHJxxrdAKwFs1QDUS7dmN60Ojfryb
X-Google-Smtp-Source: AK7set9vO1vrQhi595V0ugIEqxSyCu9JqVLPO/3EUj900ZH0P/aY8yQ4pOCJKudRnOJIIVkFi/3xg+JuKtlm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a25:abee:0:b0:80b:82a1:c2f7 with SMTP id
 v101-20020a25abee000000b0080b82a1c2f7mr841341ybi.391.1674695962350; Wed, 25
 Jan 2023 17:19:22 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:44 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-3-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 02/12] perf jevents metric: Add ability to rewrite metrics
 in terms of others
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add RewriteMetricsInTermsOfOthers that iterates over pairs of names
and expressions trying to replace an expression, within the current
expression, with its name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py      | 73 +++++++++++++++++++++++++++-
 tools/perf/pmu-events/metric_test.py | 10 ++++
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 2f2fd220e843..ed13efac7389 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,7 +4,7 @@ import ast
 import decimal
 import json
 import re
-from typing import Dict, List, Optional, Set, Union
+from typing import Dict, List, Optional, Set, Tuple, Union
 
 
 class Expression:
@@ -26,6 +26,9 @@ class Expression:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
 
+  def Substitute(self, name: str, expression: 'Expression') -> 'Expression':
+    raise NotImplementedError()
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
@@ -186,6 +189,15 @@ class Operator(Expression):
           other.lhs) and self.rhs.Equals(other.rhs)
     return False
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    if self.Equals(expression):
+      return Event(name)
+    lhs = self.lhs.Substitute(name, expression)
+    rhs = None
+    if self.rhs:
+      rhs = self.rhs.Substitute(name, expression)
+    return Operator(self.operator, lhs, rhs)
+
 
 class Select(Expression):
   """Represents a select ternary in the parse tree."""
@@ -225,6 +237,14 @@ class Select(Expression):
           other.false_val) and self.true_val.Equals(other.true_val)
     return False
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    if self.Equals(expression):
+      return Event(name)
+    true_val = self.true_val.Substitute(name, expression)
+    cond = self.cond.Substitute(name, expression)
+    false_val = self.false_val.Substitute(name, expression)
+    return Select(true_val, cond, false_val)
+
 
 class Function(Expression):
   """A function in an expression like min, max, d_ratio."""
@@ -267,6 +287,15 @@ class Function(Expression):
       return result
     return False
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    if self.Equals(expression):
+      return Event(name)
+    lhs = self.lhs.Substitute(name, expression)
+    rhs = None
+    if self.rhs:
+      rhs = self.rhs.Substitute(name, expression)
+    return Function(self.fn, lhs, rhs)
+
 
 def _FixEscapes(s: str) -> str:
   s = re.sub(r'([^\\]),', r'\1\\,', s)
@@ -293,6 +322,9 @@ class Event(Expression):
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Event) and self.name == other.name
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
 
 class Constant(Expression):
   """A constant within the expression tree."""
@@ -317,6 +349,9 @@ class Constant(Expression):
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
 
 class Literal(Expression):
   """A runtime literal within the expression tree."""
@@ -336,6 +371,9 @@ class Literal(Expression):
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
 
 def min(lhs: Union[int, float, Expression], rhs: Union[int, float,
                                                        Expression]) -> Function:
@@ -461,6 +499,7 @@ class MetricGroup:
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
+  """Transformer to convert if-else nodes to Select expressions."""
 
   def visit_IfExp(self, node):
     # pylint: disable=invalid-name
@@ -498,7 +537,37 @@ def ParsePerfJson(orig: str) -> Expression:
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
 
-  parsed = ast.parse(py, mode='eval')
+  try:
+    parsed = ast.parse(py, mode='eval')
+  except SyntaxError as e:
+    raise SyntaxError(f'Parsing expression:\n{orig}') from e
   _RewriteIfExpToSelect().visit(parsed)
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
+
+
+def RewriteMetricsInTermsOfOthers(metrics: list[Tuple[str, Expression]]
+                                  )-> Dict[str, Expression]:
+  """Shorten metrics by rewriting in terms of others.
+
+  Args:
+    metrics (list): pairs of metric names and their expressions.
+  Returns:
+    Dict: mapping from a metric name to a shortened expression.
+  """
+  updates: Dict[str, Expression] = dict()
+  for outer_name, outer_expression in metrics:
+    updated = outer_expression
+    while True:
+      for inner_name, inner_expression in metrics:
+        if inner_name.lower() == outer_name.lower():
+          continue
+        if inner_name in updates:
+          inner_expression = updates[inner_name]
+        updated = updated.Substitute(inner_name, inner_expression)
+      if updated.Equals(outer_expression):
+        break
+      if outer_name in updates and updated.Equals(updates[outer_name]):
+        break
+      updates[outer_name] = updated
+  return updates
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index 15315d0f716c..ced5998bd827 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -2,7 +2,9 @@
 import unittest
 from metric import Constant
 from metric import Event
+from metric import Expression
 from metric import ParsePerfJson
+from metric import RewriteMetricsInTermsOfOthers
 
 
 class TestMetricExpressions(unittest.TestCase):
@@ -153,5 +155,13 @@ class TestMetricExpressions(unittest.TestCase):
     after = '0 * SLOTS'
     self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
 
+  def test_RewriteMetricsInTermsOfOthers(self):
+    Expression.__eq__ = lambda e1, e2: e1.Equals(e2)
+    before = [('m1', ParsePerfJson('a + b + c + d')),
+              ('m2', ParsePerfJson('a + b + c'))]
+    after = {'m1': ParsePerfJson('m2 + d')}
+    self.assertEqual(RewriteMetricsInTermsOfOthers(before), after)
+    Expression.__eq__ = None
+
 if __name__ == '__main__':
   unittest.main()
-- 
2.39.1.456.gfc5497dd1b-goog

