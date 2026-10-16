Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF6274B53;
	Fri, 16 Oct 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109961; cv=none; b=C7pqubptB5Teeeg7Pi9QgeZexYJkSce53JM2h2EpkF4Oqoyd1nxxo8b8v+C0odKzF02aLFIbt7JW2ppRMyktAakRrVhbvOj5ysllbW/9PkzFk5oZ7vT382wCUfC0rI+4pWKpMO8rtUs+TT4d5VgHd0rhn39u073jy3s7egWtW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109961; c=relaxed/simple;
	bh=ZFNUKZlxoeMEDwC1FgW+LkwUFqKx68wvS4gqQEuefLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psGb8z0xemtAnNc7OIdtt1ZF6k2w/N+gQdSLD+6j4Jut2qRj2QTaafJTWEKUPTeXKJMX+kZRIgrS1cYn37LoQzENt5mNiELA6nd3H4BDdi2TDZUByuG1oJ5wsyt+Ztxa2WKbQnSBeroEp+ee9qjQYeh+3HWrAHTllt9i9lV/YuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Hf4fXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Hf4fXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173411F000C5;
	Fri, 16 Oct 2026 00:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109960;
	bh=LOlJPiFs1nB95zh7JhmjLdEJl42RhOfbS/7B/uL7Hfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/Hf4fXb2Ml49+vi0VbRcg9yVs3LJoyqxJUimSHRRbK8kDTs/zArusU6QpK/zKXkZ
	 G4NOWI0Sx9p2vf0FO3ThnbZL9kddC6FFl7zmu4Uyx5NRDSdf53kVNb4aEKmf1MVbWH
	 z39EAnHjvC2GY57qEKFKvu7sRtliZpZtDjoz+VoZDt6DSwcDABdGJnejE0yS5xc4Xf
	 PKBYUGTJpVZUMSsEFbq0qz8yPmBBeENAFFUzZIThWjtMJq7lIedAaRahUvUItRublG
	 s2VsOnhUo6F0sLnAV2G+G1uxYeVQ/mnQ1FS0EwLXdommU0TmHiGp1Sm79BzPWr0Lc7
	 JpykczpsJtokg==
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
Subject: [PATCH v3 11/19] perf test attr: Ignore the dummy tracking event and the terms it carries
Date: Thu, 15 Oct 2026 21:18:35 -0300
Message-ID: <20261016001843.71978-12-acme@kernel.org>
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

With more than one core PMU the requested events can't cover all the
CPUs, each cluster has its own PMU, so perf opens the software dummy
event to carry the tracking terms (mmap, comm, task, mmap_data), leaving
the requested events without them:

  expected mmap=1, got 0
  expected comm=1, got 0
  expected task=1, got 0

That dummy event is not part of what the expectations are about, so
leave it out of the comparison, unless the expectations ask for one,
like system-wide-dummy and test-record-dummy-C0 do.

And when perf used it to carry the tracking terms, those terms can't be
matched on the requested events, leave them out of the match as well.

The terms are left out only where the dropped dummy actually carried them,
from the sample_type it was opened with, a dummy that didn't is no reason
to stop verifying them.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index da4614068772eaec..c39f2603ec077b2c 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -77,6 +77,21 @@ PERF_TYPE_HARDWARE = 0
 PERF_TYPE_HW_CACHE = 3
 PERF_SAMPLE_ID = 1 << 6
 PERF_SAMPLE_IDENTIFIER = 1 << 16
+PERF_TYPE_SOFTWARE = 1
+PERF_COUNT_SW_DUMMY = 9
+
+def is_dummy_tracking_event(event):
+    """
+    Is this the dummy event perf opens to carry the tracking events (mmap,
+    comm, task) when the requested ones can't, like when there is more than one
+    core PMU and each core PMU's events run on only part of the CPUs?
+    """
+    return (event.get('type') == str(PERF_TYPE_SOFTWARE) and
+            event.get('config') == str(PERF_COUNT_SW_DUMMY))
+
+# With more than one core PMU the tracking terms go to the dummy tracking event,
+# leaving the requested events without them, so they can't be matched there.
+TRACKING_TERMS = ['mmap', 'comm', 'task', 'mmap_data']
 
 # The legacy event types, where perf may qualify 'config' with the core PMU
 # type in its top 32 bits when there is more than one core PMU.
@@ -259,11 +274,29 @@ class Event(dict):
 
         return self if getattr(self, 'recorded', False) else None
 
+    def hide_tracking_via_dummy(self, term, other):
+        """
+        The tracking terms are set on the tracking event, which is the dummy
+        event when there is more than one core PMU, leaving the requested
+        events without them, nothing to match on then.
+        """
+        if term not in TRACKING_TERMS:
+            return False
+
+        for event in (self, other):
+            if term in getattr(event, 'tracking_moved_to_dummy', ()):
+                return True
+
+        return False
+
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s", t, self[t], other[t])
             if t not in self or t not in other:
                 return False
+            if self.hide_tracking_via_dummy(t, other):
+                continue
+
             recorded = self.recorded_side(other)
             expected = other if recorded is self else self
             exp = self.hide_core_pmu_type(t, expected[t], recorded or expected)
@@ -283,6 +316,9 @@ class Event(dict):
         for t in Event.terms:
             if t not in self or t not in other:
                 continue
+            if self.hide_tracking_via_dummy(t, other):
+                continue
+
             recorded = self.recorded_side(other)
             expected = other if recorded is self else self
             exp = self.hide_core_pmu_type(t, expected[t], recorded or expected)
@@ -498,6 +534,29 @@ class Test(object):
             else:
                 raise Unsup(self)
 
+    def drop_dummy_tracking_events(self):
+        """
+        Leave out the dummy event perf itself opened, see
+        is_dummy_tracking_event(), unless the expectations ask for one.
+        """
+        if any(is_dummy_tracking_event(e) for e in self.expect.values()):
+            return
+
+        if not any(is_dummy_tracking_event(e) for e in self.result.values()):
+            return
+
+        moved = set()
+        for name, event in list(self.result.items()):
+            if is_dummy_tracking_event(event):
+                log.debug("      dropping dummy tracking event [%s]", name)
+                moved.update(t for t in TRACKING_TERMS if event.get(t) == '1')
+                del self.result[name]
+
+        # The tracking terms the dropped dummies carried, flag the remaining
+        # events so that the match leaves only those out.
+        for event in self.result.values():
+            event.tracking_moved_to_dummy = moved
+
     def compare(self, expect, result, strict_groups=True):
         match = {}
 
@@ -579,6 +638,8 @@ class Test(object):
             for event in self.result.values():
                 event.recorded = True
 
+            self.drop_dummy_tracking_events()
+
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
             self.resolve_groups(self.result)
-- 
2.55.0

