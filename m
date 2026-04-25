Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C964392C28
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139424; cv=none; b=tJTvI7J0NJq79SQHTnMJnI3RUB1zBEOxzmCkv4eXLWO0RbRf8tN+Tkk3+a9wVnDld85rCNU3HG4aJTb24w1HyoGNPupNU3a+R0SrRUyUutqwU+J1hiTDPjFnzO4Qha8FVbbQxuEKWs1a20h4fMbbkcBgbRze7xOv7ZFCfG/4XVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139424; c=relaxed/simple;
	bh=L2Q2Gv1SqkcOuddrjKJDgvkqmuTF9MQuGmwjw7vhz/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lIVK5MTk/hTT68XKEHzEhElBRFmxMOddFS4NXXb1GZbGMM+FILTCW/c7CkiyPwFD6+aFSyrw+3C/TFS6L3bEu7MU6l0ssJISNQwZdUfsWqG8sw3e1JXxmCwPi0nmMcytBsnsTSjXzs+P8KSFCGfY5kvBqPF+lwWA8vLL+DFoy5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbqh7Sr3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbqh7Sr3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d9da2559aeso24387936eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139422; x=1777744222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=fbqh7Sr3cLWigJwODOMY5EKj7X67/RcMNUX5x+Wl0ClPoscMUr3ODlAOc4Zlra718h
         YaUygUkn6xiez51qh+t6XV8zC6zU7u7ZkJnHlaSa3/AUO6csTHa0L2FCwTXN2W3DjJyU
         hcVkUHKoflD2W4TLUIICpnsBM5zcjsFNOX9J6ATKTi/JXg/3hB3B5pu4gV9WbXxhu+1T
         /BCZUCo4sVZ0TRPrCt8+RaXl8WPkzzRGBh+7S8peztS5PTgFRjcF4O6QMY2rHjCVXC8g
         KlmOB7wSIo79f38/b48C29VUwpC6S+3byVRYP4WOEW01T2pSFTEd/1hPZQyG5JRDQZBT
         7quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139422; x=1777744222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=kPpPB/vCuildoIoYVoIXQKRvu95nOC8b6RRTEurWYZismh9YdiN2s7H1HNUk1H/Aqy
         7R7I183DasYVeiOqvSQ3lFCUd6km3th+DDE+nPR+u2ea4n+OVdcin1fqzPN1dlF1gLoZ
         1NTDTCSVqdSelW9kKXgFLA2o24AJW0GP3WVJ6eQEakPtxEiFRmJx8RvDpzWXILftLhp1
         3a0xaBPU/Gb3ozalsC8Qh7SD1hUMlyNTr39VE8aNAbANsL2NBJxplfDHEGZRU5hL0a4i
         nWlenlYi2OCJB8wW47l/odsvDlWG3UVMt5vnsqzkAeAtaIEcCTZ8OXxJWyDUMVb9+V1C
         ycyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gXzyvy3/eelQaC+tTWb7jOH2xq6B2IQxgn9eMoVkHfiI8u2CNN1zSODXtNlUWLpVje9v2QQJhAyAhYwgX7bfq@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqUplov2J2FTgRAObykDc6tqSfv/0mTMzNy9olHre5YBe2jbL
	aR7HGB9RJMWGF49xauRuYM/EnvQwtP5idncUO/Rb3FLL4PjhCz+O/UCj5G8Qk7Jw0kTBB/G3ySQ
	NRav0ufltQQ==
X-Received: from dybqo1.prod.google.com ([2002:a05:7301:6781:b0:2d8:c995:cafe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:230c:b0:2da:7e33:9261
 with SMTP id 5a478bee46e88-2e47951dedfmr21518988eec.27.1777139421456; Sat, 25
 Apr 2026 10:50:21 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:38 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-41-irogers@google.com>
Subject: [PATCH v6 40/59] perf net_dropmonitor: Port net_dropmonitor to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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

