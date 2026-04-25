Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24A39BFF4
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139446; cv=none; b=QHlJ6CLAShjuO8Dn4k7kLWfuSRi/IHAoYJuaA9iCNMxxCFcWCT2q24Pp1sPNdHkBF9y8nUCaCkeh/Zk+9xd0sr8zQb/gnRHYSh1EU0Q/U+Q/J/O3qvbvbzlv/TTwGcQQb5lN/jDGb3I4Ag1PO5YWPx33EDFA6rHxzBCGcmB7N00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139446; c=relaxed/simple;
	bh=jeR4Y5tYrqM+VRciyZ38jmj8C+EvBF6bkN0wvPo/M1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZYJFu2p4us9CWwRYBai93sF74VVpII3boJTu5eRL6wFl4s7uGnvEByjkdOez+oDqm02zOf6ATLiieMEDMK1OIyuzu6IMYM1Pk3eJ3Dk4BIHVVhee8keitw7+1ebZLg5kJwPmaikcEThkIRyCFFjqIpBSaIygWYkpxmNIjaeeZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pc2qWmGy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pc2qWmGy"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so13449870eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139444; x=1777744244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=pc2qWmGyG4wB7VlDD7Rdk+Dl5j7CyJfxJpNZDFcZJNf+twfnqp/VMjusM+20p3Bjf+
         ky9vJYTZGleK5H076N8BwdcPVlkzcBhs0F+mR/A0LC1zrgb5hqvY2eDywR8FBmx4aZgd
         LULKQLeJPLf1q5zQXPHSwnYK9I+6EFER+h/Qe8tB2T7s0GIiqdvlgNES9yb7qTI4vjHe
         bMTXDX6+NewzNbWDf1lInSibHSKTVGB6/Z1da8Hlk33KyMgETltaMSSIeefSCK9Y/RS2
         luLpPitHwz0mCP53qkd1CJ22IpU/oN0YzdITrul6OH1ToFgRlZ/0Y011l1LPnmItuvrc
         wfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139444; x=1777744244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=Oy3fj4/1DLCQBZ+Iu2buMu6By3NJtMsFe1ctM+cNHfcX05VofTW0on2jGwyDj83D8u
         kyYd2fGeYiclWQRTf4cmqKg4bZddVv+41Dc8id3k2ZruOHUL/COHK6+W13myyi08dnKn
         9SoJVTPFoXaUhCSggP6IAoKK15oXCqksD0FBxy5jQfc8l/tOV8GUz9IKC2VTIf/27afC
         gDGROnSuE2WqmSgz2LYZWG28JTEfmDK1EzAhem1OBloxi3ltieK0v3tlxVv7g7A299fE
         c4NVKO4QxzQRTwoYNAyx9F692h+dOsLXl+7QCHZY6akunXnhIRmQV5xitlUHiLlUXp3U
         x4UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ScDTmwAwdlzI4v1wiZBEQTPtBKOP5yIjYENQoV5c+QHP1rThzCz+vBEas9uU2PIiz6ehMjIe/VrV2mGI5pCLY@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdouRvvPMlifvrjLq7lzgj9M+o3eHC4m7Xf/mvEorL26xioYO
	uxz5oGb3fjevBe31lvWG+H7FsjhBAJdEIGN6ZeNmJEvCrX184Zvg9XrXU7Zno1uJuTkT+w+UdCo
	19ktrb1BDhg==
X-Received: from dyjh29.prod.google.com ([2002:a05:7300:561d:b0:2e0:f299:f616])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5725:b0:2ea:ed70:3ea8
 with SMTP id 5a478bee46e88-2eaed703ed1mr1585196eec.29.1777139443462; Sat, 25
 Apr 2026 10:50:43 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:49 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-52-irogers@google.com>
Subject: [PATCH v6 51/59] perf wakeup-latency: Port wakeup-latency to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the legacy Perl script wakeup-latency.pl to a python script using
the perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It measures wakeup latency by tracking timestamps of
sched:sched_wakeup and sched:sched_switch events.

Complications:
- Used min() and max() built-in functions instead of if blocks to
  satisfy pylint recommendations.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed Wakeup Latency Logic: Modified the script to track wakeup
   timestamps per task (using sample.pid as the key) instead of per
   CPU.  This ensures that context switches are correctly paired with
   the specific task that was woken up, even if multiple tasks are
   woken up on the same CPU or if a task is migrated to a different
   CPU before running.

 - Prevented Memory Growth: Added del self.last_wakeup[next_pid] after
   successful latency calculation to prevent the dictionary from
   growing unbounded over time.

 - Added Error Tracking: Added try-except blocks around tracepoint
   field access in process_event() and tracked missing fields in self.
   unhandled instead of ignoring them.
---
 tools/perf/python/wakeup-latency.py | 88 +++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 tools/perf/python/wakeup-latency.py

diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wakeup-latency.py
new file mode 100755
index 000000000000..1b0db115abcf
--- /dev/null
+++ b/tools/perf/python/wakeup-latency.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display avg/min/max wakeup latency."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class WakeupLatency:
+    """Tracks and displays wakeup latency statistics."""
+    def __init__(self) -> None:
+        self.last_wakeup: Dict[int, int] = defaultdict(int)
+        self.max_wakeup_latency = 0
+        self.min_wakeup_latency = 1000000000
+        self.total_wakeup_latency = 0
+        self.total_wakeups = 0
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        sample_time = sample.sample_time
+
+        if "sched:sched_wakeup" in event_name:
+            try:
+                pid = sample.pid
+                self.last_wakeup[pid] = sample_time
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif "sched:sched_switch" in event_name:
+            try:
+                next_pid = sample.next_pid
+                wakeup_ts = self.last_wakeup.get(next_pid, 0)
+                if wakeup_ts:
+                    latency = sample_time - wakeup_ts
+                    self.max_wakeup_latency = max(self.max_wakeup_latency, latency)
+                    self.min_wakeup_latency = min(self.min_wakeup_latency, latency)
+                    self.total_wakeup_latency += latency
+                    self.total_wakeups += 1
+                    del self.last_wakeup[next_pid]
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary statistics."""
+        print("wakeup_latency stats:\n")
+        print(f"total_wakeups: {self.total_wakeups}")
+        if self.total_wakeups:
+            avg = self.total_wakeup_latency // self.total_wakeups
+            print(f"avg_wakeup_latency (ns): {avg}")
+        else:
+            print("avg_wakeup_latency (ns): N/A")
+        print(f"min_wakeup_latency (ns): {self.min_wakeup_latency}")
+        print(f"max_wakeup_latency (ns): {self.max_wakeup_latency}")
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace wakeup latency")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = WakeupLatency()
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

