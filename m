Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78154CF68;
	Tue, 13 Oct 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922500; cv=none; b=fJJRSftInjdIJGGAULO/GUDrWNnG5wGUKokVtTu14waJFsrkuLiMW0JUdXU5W/T76BkSORpSowJJeVuCF6whvBd91xY1YDAtWezNuNUK42SM0s0OcVB+rntbi6FR4DQRzimNm9HsqrBEPLU9nX9yVQyMJgXm48oaOiuugr8RISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922500; c=relaxed/simple;
	bh=FuNzl/Ax4aG0F9wbAmJxt+kk8IzBqbXyqPXwHo38Lec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnPMT/xzXbDNnsMoCWRR+9Ng02gA4drrXFwvghdtsO7vJWafsTKKgKdXGYwj7SBzXuGLGcSnKbYQIUVGs23okGEK8m8WkXuuQ1MS/lFeP8q2N9f6C4I4KHMZXUAb15IOCucS1UbL/H/MoUdmtLdj96FBEZYUU7Edg6VHI9YoNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD9XNVW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD9XNVW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C981F000FF;
	Tue, 13 Oct 2026 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922498;
	bh=XEuA9LYQZKS/oSR/ys9cZ6R+I7hy6Yt5O2XsZifO0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AD9XNVW0pdZOxqjmDV2QbOHR1mVKDbJT+uiujeuUjG7UTGF7HZpmQhSQVa+MeXq6T
	 Qw+b001aewGVRpyTf1TZXLEU52xDxCdcTh6cL7i3jDg5RN0nMGBm6KuJLvrZmsSDHL
	 VUn8xnMXbv5nfEtunR0/FMUYqvAyfzanowDW+dtrWLsuTLdzECx2i/9Fed3xXPfInQ
	 9BQq5FDcTfzghNYozfT/XSRTVNd26PQPXZu9XWhYxqzOiPBYZurNgrDStULPJTLaa7
	 zQIXGpNiR5jkAajPBZ9DjgykceZ3fnd8iDG9NJOcPmOp/N7MvfpyyiSQswurj65kRG
	 PPgQC1qYm0dEA==
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
Subject: [PATCH v2 11/19] perf test attr: Ignore the dummy tracking event and the terms it carries
Date: Tue, 13 Oct 2026 17:14:06 -0300
Message-ID: <20261013201415.36428-12-acme@kernel.org>
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

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index e911684428b1b74b..222ce6f598831e3f 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -61,6 +61,21 @@ PERF_TYPE_HARDWARE = 0
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
@@ -243,11 +258,26 @@ class Event(dict):
 
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
+        return (getattr(self, 'tracking_moved_to_dummy', False) or
+                getattr(other, 'tracking_moved_to_dummy', False))
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
@@ -267,6 +297,9 @@ class Event(dict):
         for t in Event.terms:
             if t not in self or t not in other:
                 continue
+            if self.hide_tracking_via_dummy(t, other):
+                continue
+
             recorded = self.recorded_side(other)
             expected = other if recorded is self else self
             exp = self.hide_core_pmu_type(t, expected[t], recorded or expected)
@@ -478,6 +511,27 @@ class Test(object):
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
+        for name, event in list(self.result.items()):
+            if is_dummy_tracking_event(event):
+                log.debug("      dropping dummy tracking event [%s]", name)
+                del self.result[name]
+
+        # The tracking terms got carried by the dropped dummies, flag the
+        # remaining events so that the match leaves those terms out.
+        for event in self.result.values():
+            event.tracking_moved_to_dummy = True
+
     def compare(self, expect, result, strict_groups=True):
         match = {}
 
@@ -559,6 +613,8 @@ class Test(object):
             for event in self.result.values():
                 event.recorded = True
 
+            self.drop_dummy_tracking_events()
+
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
             self.resolve_groups(self.result)
-- 
2.55.0

