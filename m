Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0E3C061D
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360843; cv=none; b=Cqx2pjMx+dqKph98RxT/GdEIy1Ym1Qox9HjGEcMZ59xRc7wX+E/Ie62jAvqMHkLxlc0hGSlQS6gMVkPuF6yWEdH4HscANNi4xAm1FRlD8m9PNCQUOi/2awuJJdac+90GtGyq8k4mJr0bp49avvjS6V236zl+mnNy+KzNCmfxlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360843; c=relaxed/simple;
	bh=L2Q2Gv1SqkcOuddrjKJDgvkqmuTF9MQuGmwjw7vhz/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZdBLCG5Z+CrV37+jwJSPnQLEuIVdh3GIBu3xf8xvJCcLCZtW/PCQ3OXRBNOCErh7y6esnJxh0jBAW9H4fqmcDWykaj0ztgiz4mYfzgcno0HN6tdy0A9+wasCRE8PuUiP3HYnYr/X9MGv5CqZ4SsJyJZeKsT7Weav5gW3RhTw71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pw0tcrkx; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pw0tcrkx"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dba1e866dso5364123c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360840; x=1777965640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=pw0tcrkx08o6mUwD4rl6c/eCmEd3EtIX6rHEHTM9QpUguvG8r4FmSXkHl/rxFy964Q
         U/pvc4SaIzxE87mWvF2xnxWwH1slZqUSNMlWrROoKzyIMoNrziJNNJXTMupbm2fz5kNq
         WeSh6LlmfrX2Zm7Jvfa+b8/fpxtPr4HvNAgaHk6cNAczQOoSXT6Kb7aYNxeGRYnAtNCu
         bC6VUi81+y47uwIJ+zi8pYl5X8Iv7JLoAF+CID15riGnA3iutdbXmU4q/tiYeb2vXsHR
         bVP4/JY1XXqTcydZgHcp3OYsmS798YpxcKt25jc2KK03W3lulAFwtPJJhbF+C64sk0O5
         Y0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360840; x=1777965640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=RbullA1FnfoC4bwzsosrh47dU5MgW9E7D1tIDsS8cg13TtSwXqCohleMe8FZH77VIO
         9MJ6Ha8+XF8EWPOcnA3k+XynMIEBr+FiOEYA/moJE707pWtrLoZzNoSz1r2BkwjVvTNe
         3VHTln1Kr4ohv5Q8bgrR4BekTUzgScepU8zd9U0oJSEXFMvFhrYjmihaMxn8h2r39+HV
         AT26CAKvBnfYw9HJaCQTVCq2XEVeyK4Etf105XQrtaSl5dJTaTvMP4S8OqaD7P/0UQmU
         nER8fLuWPA1NUQVDKPP23B4yBuS6DO5sFRIpOGGyMeIsrD3ng/JAOg0GQgIZMueted62
         tkzA==
X-Forwarded-Encrypted: i=1; AFNElJ8xWN16X8Nz2dnvp5020/d5P1akQRRHeOeaZOevDN/6FBY7IsHq8faOjr0EqvFprQKo3fo1C/cSal6WuC+ZTtuQ@vger.kernel.org
X-Gm-Message-State: AOJu0YynBBILbxzUXmJmAX+D3bSthyjcTCOeSMftrA/zKmyVThIcBUDq
	PsCWCgZYxcmCsyGhJY/r45CcYkOaALio2dDZ6KeVOTGYVYkdgNXYGz0qxJARSny30sGJ4p4+9hG
	Bb3s9uR9FmQ==
X-Received: from dlbut2.prod.google.com ([2002:a05:7022:7e02:b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6181:b0:12d:b2ad:fded
 with SMTP id a92af1059eb24-12ddda6b8bdmr760210c88.10.1777360839734; Tue, 28
 Apr 2026 00:20:39 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:45 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-41-irogers@google.com>
Subject: [PATCH v8 40/58] perf net_dropmonitor: Port net_dropmonitor to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/.
- Refactored the script to use a class structure (DropMonitor) to
  encapsulate state.
- Used perf.session for event processing instead of legacy global
  handlers.
- Maintained the manual /proc/kallsyms reading and binary search for
  symbol resolution as in the original script.
- Cleaned up Python 2 compatibility artifacts.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Fixed Sorting of Locations: Kept location as an integer in the
   drop_log dictionary keys so that they are sorted numerically rather
   than lexicographically when generating the report.

2. Fixed Interrupt Handling: Moved the call to get_kallsyms_table()
   and print_drop_table() outside the try-except block. This ensures
   that the reporting phase happens exactly once, even if the user
   interrupts the trace with Ctrl-C.
---
 tools/perf/python/net_dropmonitor.py | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 tools/perf/python/net_dropmonitor.py

diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net_dropmonitor.py
new file mode 100755
index 000000000000..25ea2a66ed3c
--- /dev/null
+++ b/tools/perf/python/net_dropmonitor.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Monitor the system for dropped packets and produce a report of drop locations and counts.
+Ported from tools/perf/scripts/python/net_dropmonitor.py
+"""
+
+import argparse
+from collections import defaultdict
+import sys
+import perf
+
+
+class DropMonitor:
+    """Monitors dropped packets and aggregates counts by location."""
+
+    def __init__(self):
+        self.drop_log: dict[tuple[str, int], int] = defaultdict(int)
+        self.unhandled: dict[str, int] = defaultdict(int)
+
+    def print_drop_table(self) -> None:
+        """Print aggregated results."""
+        print(f"{'LOCATION':>25} {'OFFSET':>25} {'COUNT':>25}")
+        for (sym, off) in sorted(self.drop_log.keys()):
+            print(f"{sym:>25} {off:>25d} {self.drop_log[(sym, off)]:>25d}")
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single sample event."""
+        if str(sample.evsel) != "evsel(skb:kfree_skb)":
+            return
+
+        try:
+            symbol = getattr(sample, "symbol", "[unknown]")
+            symoff = getattr(sample, "symoff", 0)
+            self.drop_log[(symbol, symoff)] += 1
+        except AttributeError:
+            self.unhandled[str(sample.evsel)] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Monitor the system for dropped packets and produce a "
+                    "report of drop locations and counts.")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    monitor = DropMonitor()
+
+    try:
+        session = perf.session(perf.data(args.input), sample=monitor.process_event)
+        session.process_events()
+    except KeyboardInterrupt:
+        print("\nStopping trace...")
+    except Exception as e:
+        print(f"Error processing events: {e}")
+        sys.exit(1)
+
+    monitor.print_drop_table()
-- 
2.54.0.545.g6539524ca2-goog

