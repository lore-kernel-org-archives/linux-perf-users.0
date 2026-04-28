Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91BA4218B1
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360863; cv=none; b=DHW6LUC0u/ffH1D9Y0GIpPrD37sdQb2fIAJbi/oQ/8Z7ging9WHxPaQ/d28cVUWCm+sbfWTu46sG9V/s/7I5wWW6xhWSCWeMStILkhfNL3z06KGZoQHbciWnRZqYpl8ZUgSoxm/julPOlIMB/HNjBavjR0jhRukwIHLaRiC/R20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360863; c=relaxed/simple;
	bh=jeR4Y5tYrqM+VRciyZ38jmj8C+EvBF6bkN0wvPo/M1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RoPNiHXn/5gQ284oZ96EnouPUytab1pBi6WBvE7OXTfGnkwufttBHI5R/Ce6WVOjaHdFigavPbS6CmBw+QVxOI6HlaImOFFeB31klDjuSF8XSkNCvqjM/WdG4mrp+BI4t1LyvMVzagz1QsLl7Y2oYvtz/e4bUpmlZERcrvbVh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzokUCui; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzokUCui"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7985752be1so4374501a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360861; x=1777965661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=rzokUCuiqMJgbvkCpnXAYIlw55LZlCDtruVim2u2Ux0ipms0vmyAeIrFxNnVhN8bWL
         H1F+nmOzO0kjPtNMTI1A2wFca6/IL2XhRfucPe76BiKGOs96rLxr/4GpJktVF/wX0i6G
         QKyOmHAMqNpHQTYxTr30qxtdfnVYPFA9i48G9xX9X88k89PWqOP2FqDPJp0QuZDWDft2
         71D8G03sadat261S9zmB9bhVdewNuYIRCiM6LIThp+MsPscanSFhlJwhG3mx927Essx6
         NEBFXESklI3iRH9/dOdYzFFioigkbHRv3TAIwy1eW5ljPMyfjAwfvQyZ/bCfOKuRIj6a
         nBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360861; x=1777965661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vO51mkUv8czx4QMNQNbvlHwQFmUDbpKAVfeUaPjKEk=;
        b=kUmtbC6b9jI5Ah8eDsxMaPoo8i8++vLUkJ8nQxGU96F7vst4S91+MMbiDyE9ZXLbo9
         tNsNG/KzH7c6A/KgQarHRnTi6eWjusXSO1e22iyVz/PK89ISQMCobwoKIfw8ojusDB2O
         E1+hvc4dehmTkhMRoYqpu5NbtHKEihbk48H4LWFM6xgsut4CEunt99VHThpOTPO0nEP9
         JFCh4MHSVz5wkM3tEgVskz7GwaYcC0k4BHi2XSlJL31LjeHPC3RXvpwSiQyXD2md7NHN
         xnys803U3UFOn9aCPWd0gT8YGRST4D/t8sO+A7xUraHUTBKUPWwk852HGOn9P/aaZOQ4
         jpmA==
X-Forwarded-Encrypted: i=1; AFNElJ9EL0ogiOvCuVyF1CKYlPhb97bEEbAKKD0mP3eVO6peDe+hXg5Cmc/mJBR5puXOQ+P4rrXNBj1dME4ot9kmFea4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ExQ5yRXynxorpiDB0LUOCl21pJUvyCNRGj4xda3tEp1CKpCN
	8Bl5mRBuZ+ff2P7vtODpQxOesv+OLIW4GvJq8WKz5ml8Bak+VcNbN+J5v3pkAGR3PgXzYqS4W7i
	vycdkwcu66A==
X-Received: from pgac11.prod.google.com ([2002:a05:6a02:294b:b0:c76:a6b1:ed23])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a120:b0:3a2:f14a:4290
 with SMTP id adf61e73a8af0-3a39c27ff64mr2278598637.38.1777360860923; Tue, 28
 Apr 2026 00:21:00 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:56 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-52-irogers@google.com>
Subject: [PATCH v8 51/58] perf wakeup-latency: Port wakeup-latency to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

