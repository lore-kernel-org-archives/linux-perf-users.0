Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999323F0755
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049375; cv=none; b=nieLn+Umf5bi2IWQ/SHuQpVndryNdBneGlm+9m1xc0PJLoe/1iOlDvnfZia+5Fg/qJk99koql7fV1gWRR6a6SQI3x/Mg3UMCRlmvXg24NedWwKpT6GMJKAMkeDuRInRJsN5By3UO8hSaef62yjWLf58jHtV6IuWZjsYSIf9xams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049375; c=relaxed/simple;
	bh=jeR4Y5tYrqM+VRciyZ38jmj8C+EvBF6bkN0wvPo/M1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QHb/8ptb/UhC+KfZBYT84GI8YovHd7g2Zhhi5lhvprBUrn1ltBE5BLeOOB09ctBKsnwX/Y86OemMiJHIEKjvCrnceaE85VXeX5OnnEAQgj5ALgHnaABV/3awbl1ejsKA2TWPK1/Rv0I4nhUZOG28I7ls7kwwyNxCOOQ0phKA7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blzUn35+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blzUn35+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso10403927eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049373; x=1777654173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=blzUn35+c8OBxK/98/wCqtww7g1jm4zB7aMsvDbcCzdaNn7Q0OlcIftDlUbw9eyQjN
         un1djRqhbbWI+GTHEQgNxWNxLWtLK+8OKPiMSxlRenQgWTFqVFE9a7MCx9FHI2RUmLj2
         Pz2V0TS7hUjvfxZkeWuOyNFI0KHGN9AbSs/rCjMk4BuMtkC41Lpd51ouCK8l8Csni7bV
         BTLBzBhP7ECblUOzUq+Too3+oPZJyydOvvJc9Xs6orVTQDiD/kZUdwwnTDTgygx7GI6D
         hrT/BQUJqwCHICWglPgJjTqwCqeNRKpuYLLtMtfYYhwlskOz8ZB8Cc+q4+Od2JLDJ7rY
         RmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049373; x=1777654173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=dNiz1OXRtDYbKFx8YeNLkF++cgF1Tp9RWxuQC/3VgWT30bqr1IV40GVHUXvapKTusY
         WY41qhw2F+y9AbUHNMF+kUprlw7dzXzck8DjSMF15gaJWIIIXF0VHVbMGxz1UecW4YBW
         tmOJb0cPRk8B9mEo+XTcnLatJxx4jS+5TL8tMoX/EWvFftWhu+GV4/YSApy8N1XeJOwD
         qez6Oi5aat5lgGrE0rY+2zUPfkcH5DApHQhYxgThM3c5fr5BtddG7gg+/Vvj+iTNBW1T
         VNiLJP9Orn75qBU7HrqvUzpbMBSmC2+qnrHogEn4n/s9G6oE1n9xT3FiLcL1/qn6ZPhH
         vGmg==
X-Forwarded-Encrypted: i=1; AFNElJ9GmtosVnvwNy4LQKU2qfZ66k1yMCbCgqK6O+E4WslRT3d2fxqKryU1MxTzpsXa4LSfkFeP9dm05SDeArtBz0nz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LnWQ1xI1C7gooE/B/pVB1liU0gV2x+TGcUaL5tU+r/T3dKom
	cJmivUgxooxvb6ypMWKCr8nBztwmw560v241J0/dxgCYb8H+ZlUuQd1AZlpVuAStc4Lv6fmYned
	3N8tLQ1OUmw==
X-Received: from dycoy3.prod.google.com ([2002:a05:7301:fc03:b0:2e0:fe68:96c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5ba1:b0:2dd:8ac2:9f7a
 with SMTP id 5a478bee46e88-2eada6d6539mr2779618eec.11.1777049372661; Fri, 24
 Apr 2026 09:49:32 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:13 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-52-irogers@google.com>
Subject: [PATCH v5 51/58] perf wakeup-latency: Port wakeup-latency to use
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

