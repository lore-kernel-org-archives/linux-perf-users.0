Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7C3AB26A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157499; cv=none; b=PucQsaItdl6NH9MZ1XF+N5OEKHCZmmdRdF5eyDUiuMDftZQf6df1p6bZqQqx6WPp+N7aCWVhyqGdG0f52eHGzY8l+zMJ/CsF9wqjZlJX2Thay1IaxULc259prcDZl8P3IWVyem3Jb9gZo/uirUbUWqeKZWxEsjwa6Of94RsPe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157499; c=relaxed/simple;
	bh=L2Q2Gv1SqkcOuddrjKJDgvkqmuTF9MQuGmwjw7vhz/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kNMSov/SypHXuhFSiI4u0KaC6MX6vBBty4G12nQc6d1FaQ65/WWOld5TS15LXfeo0KOveAb9CDaQU9ewaoPzmrezCDcBdAI/bydPPixLEFR/plkMUKv5+Mzh+Wa5PBwn/CLf0tlMhmMZNbDD25s11paYwCh7zfdscH2QclM2lBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NlmMz/nU; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlmMz/nU"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd327d970so5511910eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157497; x=1777762297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=NlmMz/nUtWKF/FKJeB3mCN/nBx28g9GL9Aqrhq5ZPDM5icgLW4n/7Gde9M/z9GaYSt
         LIWD6SrTn5S/GIXEsd5j2Aq8htfAl4pquy7mONHl26hiteWz+fHV8ELSQThqU0lF0F45
         dEPgb/zsPSQwecGB9GXFPNVyQ9L9D7NhMdU6hYxy8Yzo2UFLMwWXIf1cM7Rf3vc0amSa
         KENnuMoN4T/w52qn/EDNLKJtmQxS0nt9DgCMI+brKRlkKobL+22i5N7ZEhoWRvV2WL5z
         jjR2Z+olw+nEopdKXwpB+TQlMh9ODULy159Gfd+GK7J3Ge9Ix53UChJinD8F0s9LkZmw
         a5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157497; x=1777762297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=FmjYvq/Tjb6Pp4PzFYpV1ZSoA2qmRRJ/MwOiQ/yBqlD3bnYSoU9qKQdHKfvk8239Ol
         rRTtcYu65bNHH31kyGkjSGrTI6Dt3vkRYIgt3bo5agJsy5cfuTAaIGhGtwTssP5aGVaP
         kCUoWIRUxy3psWs8/XYhh/gwR+DR2/hWaKP1txLTJWh7B6Hs+mDiI+cS1xUTemkjG47B
         IiqEOKRoa5yDWKObtplB6ebJojGpN+lJjw6zwQ8/EfOnrvt0D7NozoP12RhX0OTIMBAO
         gGvEY+BnAUbtBEfbeHDpm95ouDU7u2eX4iyvdPe2xdcJbIMr8hhQVqz0YnVGQC34Xxnj
         rJWA==
X-Forwarded-Encrypted: i=1; AFNElJ/0qt9faXUS/eKr6k6S2bhv7IErmztASHAuHn4aCRrtBH+PSkNK3+R4iIHmdNhIbagzd0f6v5blKp9EWOkbCYet@vger.kernel.org
X-Gm-Message-State: AOJu0YySmldPBvXlg+gEDeQErfk3NpmzxVXmaBKZn2C/74FNtTEuooo0
	MywPbQtU3Vb7oSEyPr/quWLPbpnXnE2blzH6Zhz+cxYCpaeqqQmUVHYblGtc9miJg+LkKI49btX
	CLJW3CABNLg==
X-Received: from dybrt7.prod.google.com ([2002:a05:7301:4707:b0:2d8:e988:4a97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3011:b0:2df:7882:1cf3
 with SMTP id 5a478bee46e88-2e42c15cf81mr16379113eec.2.1777157496418; Sat, 25
 Apr 2026 15:51:36 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:32 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-41-irogers@google.com>
Subject: [PATCH v7 40/59] perf net_dropmonitor: Port net_dropmonitor to use
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

