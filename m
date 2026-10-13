Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D954A7C5;
	Tue, 13 Oct 2026 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922483; cv=none; b=kIn61/tlekJfE9LSJj/DFKyZoEM1TsW3MBk9ZaLgIBQfzevpaCrALO6ihRPk3GH8j2U6CG3EaWO+TrbQJRv7uYNvKHVZaNG+ElftPkxfFlnoYyM64VaGZJU2SrRw2pLD7l+FeuOI4fpPrPm360AKI2FIS3Lk2Xz/rShT/oNswPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922483; c=relaxed/simple;
	bh=shb+X9RZhGe2vFdaniacTlJ0uA+vvD5eiiv7TT/79to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4ZGXCIMroBCmCJhVV5O4ryjsBoZcwA44hcFhPExojNc3Tw8hy2ogDtGa/MnQwLw2qBvgkbGj7jk+w/w1EJqsnMx2ewacU299B3UbDT8hh5ZtIQ63UnZp0wYtP36ZtOPHgVQbT8DaurKkxipcyWLQCyb86UOOD4Sq+mHSmBeSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlDJ3/wZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlDJ3/wZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0492E1F000FF;
	Tue, 13 Oct 2026 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922481;
	bh=J75Rf2aefD1rmdHAa8hpd0EVTtpLGr2UwPu74f/0Na8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlDJ3/wZIa3SE8jIq5xPy6g9pi2e9+WO5+WJ4MArw3zaNO63gBZl2XoXfoACSLO+Y
	 KWZgsrHeWQrGjWIV7ObHZ3fwwAfrcV20GI6jUErSI2+OV3x0xO/hD/yYNcAjok2A8X
	 vmb2uqrcsv+XpOKUNF2DWzAgTzu9GGnibHU5fmW7qifwPjMuoIGRea85oxXYP28bHX
	 2eS0iH0dCWyx94gDs7b/8asyLadUZcitOiFO2Wyn2diZym3wU3607lZnzgJQ/m/gJJ
	 mwNzcvTmYrIsFVme2esG6d6DA5/czKXlf1EMEIAhnPn2N/cmGmJWcMb0R6Hwy5NUaL
	 uKbz7sXPNfSYA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 05/19] perf test attr: Relax group checking for ungrouped expectations
Date: Tue, 13 Oct 2026 17:14:00 -0300
Message-ID: <20261013201415.36428-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When matching the recorded events back against the expectations,
attr.py requires every event opened in a group to match an expectation
that declares the same group.  The perf stat default metrics open the
events of each metric in groups, but the test expectations only verify
the event attributes, so test-stat-default fails with:

  FAILED '.../test-stat-default' - group failure

Only enforce the group of a recorded event when the expectation it
matches declares one.  Expectations that ask for a group are still
verified in both directions.

Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based on default ones")
Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index b55c9b881e59852f..f254d03c1b253c7a 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -353,7 +353,7 @@ class Test(object):
             else:
                 raise Unsup(self)
 
-    def compare(self, expect, result):
+    def compare(self, expect, result, strict_groups=True):
         match = {}
 
         log.debug("  compare")
@@ -387,8 +387,9 @@ class Test(object):
 
             match[exp_name] = exp_list
 
-        # For each defined group in the expected events
-        # check we match the same group in the result.
+        # Check that each expected group is matched in the result; an event
+        # opened in a group may match an expectation that doesn't declare
+        # one, as those only verify the event attributes.
         for exp_name, exp_event in expect.items():
             group = exp_event.group
 
@@ -397,6 +398,8 @@ class Test(object):
 
             for res_name in match[exp_name]:
                 res_group = result[res_name].group
+                if res_group == '' and not strict_groups:
+                    continue
                 if res_group not in match[group]:
                     raise Fail(self, 'group failure')
 
@@ -435,7 +438,7 @@ class Test(object):
 
             # do the expectation - results matching - both ways
             self.compare(self.expect, self.result)
-            self.compare(self.result, self.expect)
+            self.compare(self.result, self.expect, strict_groups=False)
 
         finally:
             # cleanup
-- 
2.55.0

