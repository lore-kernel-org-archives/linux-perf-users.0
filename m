Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2323B27FA
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157522; cv=none; b=RlT5qGW/Sp5EPdr2bO4+l9BMHZ6eT7WXnNQ3BW0wSqpBbj3Q55fC/Dtu1L8Bq7NGoZyI8s+OTYGmi227UIZVVLjac+TYUvVR/KAEbSbLvHSoePyh3lJyPbU6pNgwLNUbEEWKFWjW9F1rIrG7Fd2P0TYHVttrmQCpLgIWvTBUsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157522; c=relaxed/simple;
	bh=jeR4Y5tYrqM+VRciyZ38jmj8C+EvBF6bkN0wvPo/M1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hpnzK/zgu/A6Zv7DPwwCAtkw5httzIJFFU5LtEVvMXWjmiDsGa8iqaaDPYqmpvhw1G8NpF2Dx/ZG/Uzp8m5Jkn8SsytDh+aS3qT9pqKLR6bMPoN6ujng2tPT8EGKrB5DIjouUu5FzJUmR13+6kQoMAvNA3Q1awRXa61hEgDyBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAuqNxSG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAuqNxSG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8ccc7593so10496477c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157520; x=1777762320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=WAuqNxSGVtbUCjNTKJOJdafRLxr4736F0MwgyrhkkZclXFKvxVn3msLMMKqeTNhJ+V
         ZAgVl8637QU0lnm9zO0TxVQZecAuw/eqqUqvfqiSr9aHaJ5brZoMo+DMRpZ91Q6o3NcF
         BPEwjdpQtz7XYqV72Fl26ogcnl6Lnl4TYYk/smyYMIdUXl4Z213Xg+oRvSYne6WA4Rby
         D5mfKDeSDrGTQTMaiu3i6UKeb/ECWk5QXK3uY8OUqPNtltV9kTLhSsw9wR7wdne0asjf
         8BiUTkB3rZePspnQCeJFiDnVObAGWw7O2b5aD81tacLCN8tl9oSKnhYYclySknjtW6K6
         RJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157520; x=1777762320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=Dw+NgwOSmJRCUU2s/ss8zofs8meBj5tzef2neWH0sCwDV3HX4acWqQfntZUirLZLon
         BEuL9AbVqBHl4PYqcglG7bvq2J9C+QRNO7DnwsEx/s0efD288UQRQZnAePzxfpe1EJ+Y
         7bM9oCe6M6JJxS2pYNCazP5kZonWVGpwPCOvHoDQDd3jT1CzJLV3u37JdzZVGhptrm1Q
         /o0OOLjvIaG4XlH/Svs4na/+pKeabc5XcvWiykSD9JJLS4xrft/QBk6rW7aRsHvqL2dd
         3s0ieZu/5uNoGVNg0p0L6yyZMK1jG6YXvcxABLalCN4SOG2KaorOvNGBrLuYxcHc4Fqg
         MxAQ==
X-Forwarded-Encrypted: i=1; AFNElJ++pukITXsK59Z5FxYpb2jcQAPEbYQQS3zxCeAw7B/bw2fRst3iaZl5tZqoWdaKz5d5HGVO3cFYlxs3Z2L+OrDc@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqWMIh5wmbY4+4MjgIXflj4zymNw9dATVLwRkk2yptYNUxWiL
	5pkfKIrbgFGPQmMs7rwcpWrT9hBo6s/j1qda6ZMrnfoCxC1rNRPh4xEhJKl3dYY9ui+YL2T6PQm
	2Oul6zZEd9Q==
X-Received: from dly15-n1.prod.google.com ([2002:a05:701b:204f:10b0:12a:83c5:a16f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:90a:b0:127:33e0:ea40
 with SMTP id a92af1059eb24-12c73f7fbaamr18492849c88.15.1777157519599; Sat, 25
 Apr 2026 15:51:59 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:43 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-52-irogers@google.com>
Subject: [PATCH v7 51/59] perf wakeup-latency: Port wakeup-latency to use
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

