Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31FB1CD1E4;
	Fri, 16 Oct 2026 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109944; cv=none; b=rpve2p4JzSkW/TVLfsj88llFudXHLGrtZiuv5eDRIXCJdRT8ldwnBj+PIvIOuAoIsDtEdFL677cx+ydUFLUMTP1pTKbPJwN3SjvGiY76gF6NvJ1DHAapCj3g0Xu3xa0/Llx52R/GsrHtMHVVZcGtBkDaRNUYN10zBXoV8NMicyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109944; c=relaxed/simple;
	bh=30A+mZvAX+X2EB/Nmf4O8qBc5lmLwSd8N/bZGzVhrIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B222vV9acTLFlDfNim6dkNS3xWK/faVdAouHZn1xv5cQfes/jEkcSNNS5r2z2iiWg498Mkrbzcbkq6NA+6+xbM18flKU+h6t0sEkd2AT783UIeE2jLdAg1Xf3nJ27HvkK49ybMNioJDs/NAirNKMnsytlM+lnQvFzFX14KG4A4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNMM5ybZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNMM5ybZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDD71F000C6;
	Fri, 16 Oct 2026 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109943;
	bh=r/O/LS+JOnQTqJBY3m1juJWDC12ucJNtzXROp9rHI7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KNMM5ybZXJmZQpOPVg7YFlpVUQMVsIMc++c2FA6c7h1P6HkOP3E05FE0v2n4Mv4PX
	 7Pv3TYWLjxuFYOYabm6DVXCGY6GmbgT3uuhXTF8Ze754RjcVND5ywY8uLfieKEFp9B
	 J6SV9UhnHf0fsmII1NqnlwVAt9swSOMRAm7uBkv5FdRx+q7srawyc4uHNpLO+GhOvA
	 LelyWml1GVSHnUbmP5XmYySDxHdeQjs9gsKgNVABW60WB7dQ05inuw6Lxi20LVI2dn
	 mCa3weTmlmR9GYPA9DXay2L3vWr/x2VdiPvdg+Jk/VDx8TCOpCVMW8coqaaglq5YX3
	 2qMspDENzOfQg==
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
Subject: [PATCH v3 05/19] perf test attr: Relax group checking for ungrouped expectations
Date: Thu, 15 Oct 2026 21:18:29 -0300
Message-ID: <20261016001843.71978-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
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
index 2d7dd26a5737777c..087bfa4532b69c58 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -372,7 +372,7 @@ class Test(object):
             else:
                 raise Unsup(self)
 
-    def compare(self, expect, result):
+    def compare(self, expect, result, strict_groups=True):
         match = {}
 
         log.debug("  compare")
@@ -406,8 +406,9 @@ class Test(object):
 
             match[exp_name] = exp_list
 
-        # For each defined group in the expected events
-        # check we match the same group in the result.
+        # Check that each expected group is matched in the result; an event
+        # opened in a group may match an expectation that doesn't declare
+        # one, as those only verify the event attributes.
         for exp_name, exp_event in expect.items():
             group = exp_event.group
 
@@ -416,6 +417,8 @@ class Test(object):
 
             for res_name in match[exp_name]:
                 res_group = result[res_name].group
+                if res_group == '' and not strict_groups:
+                    continue
                 if res_group not in match[group]:
                     raise Fail(self, 'group failure')
 
@@ -454,7 +457,7 @@ class Test(object):
 
             # do the expectation - results matching - both ways
             self.compare(self.expect, self.result)
-            self.compare(self.result, self.expect)
+            self.compare(self.result, self.expect, strict_groups=False)
 
         finally:
             # cleanup
-- 
2.55.0

