Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61923397E9D
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157125; cv=none; b=FlssA7JhqouJk337HJvUDQ/HOWyZ1CwREXquo9b7Bthn6dT6fryNPxWqBb9XlDZZsgJ2EsrH+MuhfF+f7XCsWf0rHB/SugvZT5M/N/qCcA4fJZQ8gKJ6WzT8qt3KCNA6bS/Pkv2VYSqrxGGfOU2dus69fri3r6moIzao/yDV4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157125; c=relaxed/simple;
	bh=jeR4Y5tYrqM+VRciyZ38jmj8C+EvBF6bkN0wvPo/M1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ilY4JVnwCzj+74Y/2Bz26M2dC8zEmUABoWbq+5Fiz9cHaleEG0FmEwhnBw5+bKzIrIbwksX954mChkE31HGK4Li0n46lOGDJmimU8VKL/7t5H+rAycR8pylm5jzsUNlWS9MjvYhWlQNZlEbJZDg5DT1p+eLB3UTCZxICxyQNq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p71mB/nZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p71mB/nZ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso10526794a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157124; x=1777761924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=p71mB/nZxmYxi0pLxj4sSKW7wQYeV1icYpl2cYFM20ra4Hou7xRD9L4qkMdLx3Ui1g
         Hr7BujNOT2M4oVlJXUKhAWprj3KYmumu2R/XMoiLzxweHtC744Na8h9pd1WWxPuQo0F2
         HjidMUMvlNqoa/bUXtq/rM7ZLZMggYEltLcRTgKumgmRs/0aHUS7IaObI1/b7T76gnaI
         Q3icJir/oY17F7KfawCCBm9XiYe0HmonZs7KrP7GBiC1WrCsehVdW7SuYHQf3WmS4tUl
         GVOTGhDsOz3j0L/KmSMWMVMXSKuOGPw5OCNPqj0bBNQ/3wBlilNDo80y7FRpfur5pRgF
         X5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157124; x=1777761924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=itmkYudI4JK0sG5hONIjIAdxcd/TGPQuhhTgveZ/NlAiEqUiSb5TuDvkqpC84m7AX4
         B5Y6RkUTpIBCZ2MYS06nIBihjguzO0MnZ0SHFE27Gd7Cv5FKkAcTN2dK4IwLLz36I0c9
         iuyAqd8Cjc4oFegpMZu6uVcXDmmMfxpFIeVoJe9qL2GM+o8RwhQRtSW/3rHCCtkbsTFc
         ifuzdo80MRpuK6UfkXU/pmndQuntDDdy+/pXw11MG5evDJJklx9mweTbauWkopuha1Lc
         PflwDeQkXHdiypLvM6y0fwcSIKfuvj76jGFPWMKwr8rnDjVJ+UTmXSjyPQgQC0yonEpg
         tKZw==
X-Forwarded-Encrypted: i=1; AFNElJ/LZBqCpWaAmESOcnIkPttTr3J2PjceAQpUlqOZZ2BnXSWA512YrVn6r0EepyPP2emFlUJKTHlv70xCnHklkb/O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NQ+FOOHr5hEkfoVkFkCaQ1aBLXvv4cfdxEf16gKow/UB1OZ4
	QSmhe6XdqMclM1/5ZJZZQj9K7NL7Ge7W9hsJZ2s4W8gHbDYMoW1GcbtZNV9foZNSYO9lUs4k3/T
	Hz34x9d/AWw==
X-Received: from pgem18.prod.google.com ([2002:a63:9412:0:b0:c79:85be:4c5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfd0:b0:35f:c729:de9b
 with SMTP id 98e67ed59e1d1-3614048ad9dmr39241184a91.20.1777157123571; Sat, 25
 Apr 2026 15:45:23 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:44:55 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-9-irogers@google.com>
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

