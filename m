Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74C4A0907;
	Tue,  6 Oct 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303231; cv=none; b=PLVMdQ8aO7uPPRkG6IV6JrkWhzH+AmoZaoRBiZ0cZ6KSnB1bbdDMo6AiPjd1GIudmBmg1rFqwnF9zZqsoKKt0jpkamnR7rUsUm9rtglq9LnG0hQWDVRXv/LGBiarzURxMOSmIEjhGv1Z6IRuZIoby2W1rtyfFMob9c7EbWFtBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303231; c=relaxed/simple;
	bh=foRBywCAl8V0gqjaRY8lJTj3xOYXyA4ucoK3PuIi+rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STvX/rjdBWA2NkYTQYMVgX2pZWhSsisaoeKO2VPZJSbKeNfxUikvKpJV0VkTJXiH/S5h82tei1hBxjXdcwZ+HhpuwUmPfaqNcGvkDQ1GixPFP+n2u/MAZv7cZCgqhro/8ZKfu5IxrSoHQMxMaEBbRqK4L5O3nuGKof9rGhTc8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RApO3FUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RApO3FUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97291F0089B;
	Tue,  6 Oct 2026 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303229;
	bh=Q4+xle4RCRi3s1J+buaPw99E1w5/2n94aKjMzgS6CBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RApO3FUAf56kFazoxF+eET83qVGvD6jY7bW9i0qVUz79SsXTJNW01MyFDxb/vvVqH
	 1+cpSHL6lJ4gDKcsnTc4rXimuT2yJF9Gw1Aj6jw1Bqgs3PWKpg2MgI+vOwxMrUhyAQ
	 mlg0fkvxjZ8uXS3AiYaNmqnSvIdv4Ix1I5VcnNTL1+yIfDDT/tDX67P3nI+bYyj55A
	 tQ6/z2qFfLghogLntw4ZV1jA1T7PtUCgUNmoRRLb1PXv55HbE0nQquQ5hvQ61VVgSR
	 +R2RKj2V+rySf8D0xIaM7t7I+yz0KOPFdquJHAKQ8R0NhkeKvSWFA4OFfc5kOCn+zc
	 LKevG3UBWG0+A==
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
Subject: [PATCH 6/6] perf test attr: Relax group checking for ungrouped expectations
Date: Tue,  6 Oct 2026 18:13:09 +0200
Message-ID: <20261006161309.3078488-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
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
 tools/perf/tests/shell/lib/attr.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 68f06df9565a0811..3319abfd451c4e4f 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -309,7 +309,7 @@ class Test(object):
             else:
                 raise Unsup(self)
 
-    def compare(self, expect, result):
+    def compare(self, expect, result, strict_groups=True):
         match = {}
 
         log.debug("  compare")
@@ -344,7 +344,10 @@ class Test(object):
             match[exp_name] = exp_list
 
         # For each defined group in the expected events
-        # check we match the same group in the result.
+        # check we match the same group in the result. When matching
+        # the result back against the expectations, events opened in a
+        # group may match an expectation that doesn't request a group,
+        # as such expectations only verify the event attributes.
         for exp_name, exp_event in expect.items():
             group = exp_event.group
 
@@ -353,6 +356,8 @@ class Test(object):
 
             for res_name in match[exp_name]:
                 res_group = result[res_name].group
+                if res_group == '' and not strict_groups:
+                    continue
                 if res_group not in match[group]:
                     raise Fail(self, 'group failure')
 
@@ -391,7 +396,7 @@ class Test(object):
 
             # do the expectation - results matching - both ways
             self.compare(self.expect, self.result)
-            self.compare(self.result, self.expect)
+            self.compare(self.result, self.expect, strict_groups=False)
 
         finally:
             # cleanup
-- 
2.55.0

