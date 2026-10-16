Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605044BCB4;
	Fri, 16 Oct 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185713; cv=none; b=gKLZ9isHD32Wioi58vvyRgxSW+9utd1CpHJGhaGGRzjnlnRL4+W1eOfAtWs5ysGby0Ecem06nn+piDut2cT8t3Nx2RBICaE4TFQIovEanUy5KAnobzPlWV8sUrdnUZQ1cCwVWfpAnMYNdHv96i0rwVlP25Mp2/ZWujSN+wRmRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185713; c=relaxed/simple;
	bh=v+fqRHVpf/VmyJ1Yo59RihFlb1U12b0JrEMQIq7SkJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6IaF0xp+JHVLN+cLVd7HVZdP+cIKACqlpLenn6RUBWj67a7f79y7hbQmIjU5a6eqyW3w2bfh11B8KktsmUr6uY9ccqnmNYEvebZ8IMrX7C/aH6VD+CI5dQrOVPwsduH88Y09Ora+9Nzdt5OvQdQSZ6zJV54nxZpMe9YNQ5N3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXQtYVkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXQtYVkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AECA1F000C5;
	Fri, 16 Oct 2026 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185712;
	bh=pnDAKm+Au1xaZ8ArKsT0GxxKAtGTvE4AgWUEmegeeuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fXQtYVkwAs2Ml/qSdHQTgCCzWQcu7kPTx6hPSxxI6lW9uNJSfkzpjheGr1IUvQ/hd
	 pja5ezdQbuYS8Y+VHrswVs2ruXfx4AYjF78I0XbIbA03wWkIBW3xd1ODkCy3dhAb+r
	 UO3DOZKVsr0gfJuCw4PDg3f4uvlgZIiz6iSlaot3Vv8MsvBBHJW97USxMA70wpZWeh
	 eVmXM0x29JU3dMwJhepp0RK67YSU5WnyUDOwTRT/kr8JfEMmuDEr+eaMgzG/k/oDzn
	 EA9UX3U2hA2KglRN9J3jp4ig1yv6Dz5KtWqUy3KIc4gtfVgbmbh4+8cQ6sYBghW8qc
	 c6iYUtwpViCJw==
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
Subject: [PATCH v4 13/21] perf test attr: Ignore the dummy tracking event and the terms it carries
Date: Fri, 16 Oct 2026 18:20:54 -0300
Message-ID: <20261016212102.76550-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212102.76550-1-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
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
index 7b0e9944ea299bd9..47a09f00000ff762 100644
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
             if recorded is self:
                 expected, got_event = other, self
@@ -286,6 +319,9 @@ class Event(dict):
         for t in Event.terms:
             if t not in self or t not in other:
                 continue
+            if self.hide_tracking_via_dummy(t, other):
+                continue
+
             recorded = self.recorded_side(other)
             if recorded is self:
                 expected, got_event = other, self
@@ -504,6 +540,29 @@ class Test(object):
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
 
@@ -585,6 +644,8 @@ class Test(object):
             for event in self.result.values():
                 event.recorded = True
 
+            self.drop_dummy_tracking_events()
+
             # resolve group_fd to event names
             self.resolve_groups(self.expect)
             self.resolve_groups(self.result)
-- 
2.55.0

