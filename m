Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB4CC61D97
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 23:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjAZXhQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 18:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjAZXhP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2023 18:37:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5346140
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 15:37:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a14-20020a5b0ace000000b007bf99065fcbso3596762ybr.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 15:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVzLGDFk0ATwExjUMDftjSNFZ72W3NZoCawlQdDdpKY=;
        b=g6B2e931x3l/7IDGJTFRhdD+fs2W/iVGC/9/OGD/9xMyNzGYszCJRBhKhZt8qdb0WS
         Mj4civh5fQtEFSx7ZF/uP0ogEmf9FMzTNTsU8yOqUqcVDSt5VwMNO54ItUxJPiA8uJTg
         AL1z5/zKgUzr27kAbh21VOmJTCvtddk6RlAZjaVOzky+kZxObvNrMiuJFnCpUkFR4yvq
         dKqqGywWp2j8skVstAWywqYG+9Pko+yV+k+DLlDTB+OMOjp8bxuAroLXZbINOHKvRfbz
         dAbYmSe2q28FTiGup4oyTPsrSx8RsMEOI/JK4pIcY9DLJ4ch4Zxbzv+g9fBeBmdT/Yar
         Kv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVzLGDFk0ATwExjUMDftjSNFZ72W3NZoCawlQdDdpKY=;
        b=0ntGfvOuHwlDfwbhq/ZMCK4uwzw7ZVJqvob44Wqk09Q8ja3uL/hm6NjUlyr9xLko8S
         BchH7y2VqzIl2p7KN0FpXCAoYMwDhTT1mklK/jL20uoHXrvExxyi68xL77fDUQ0Z3+3y
         WjmQOmGOrrMbpZh+A2kJKLSBuRCmg0qfm/zk9AkKJWinCItZfoK8Xs1wcX9NKZ5kUVG5
         CIH+xgJV10A7IWa8juAt6HdMcVonle9vGidWagewoGLuRV8p117LH/Nyewi4pS3lvU+V
         vCH56sR6elnR0pykpqD6KRuLIMKhKiwoNg3tFh8vBhjGafGbQEsxw4KkRbj75PSRYi2r
         QxkA==
X-Gm-Message-State: AO0yUKVFCjKzfDJI12sJQklJeBBTi4t5OoiHQAvnct6VDc+71a91gy3+
        idMFMGs0GIimd2U4zalJWHV9pq0TjTiK
X-Google-Smtp-Source: AK7set+Iv2jmW6JOcsgy1uCNPGEoi/rn7S52ZxdpjWt6UB9uRDAOijygh48h7MPGC6ch2gn93vDjHr3/VJ1L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a25:6e84:0:b0:80b:4da5:cf19 with SMTP id
 j126-20020a256e84000000b0080b4da5cf19mr1962472ybc.455.1674776233289; Thu, 26
 Jan 2023 15:37:13 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:32 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-3-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 02/15] perf jevents metric: Add ability to rewrite metrics
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
---
 tools/perf/pmu-events/metric.py      | 73 +++++++++++++++++++++++++++-
 tools/perf/pmu-events/metric_test.py | 10 ++++
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 2f2fd220e843..77ea6ff98538 100644
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
+def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, Expression]]
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

