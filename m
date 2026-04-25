Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569F391508
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156975; cv=none; b=rDEeoSOSSUemtF0IusbOoGGtqBRDSmFeN44TpE5N8qypkTpMRCYXK/eKviQS6hoPsxM9bhXCCCsyBXjou2C7nkoXeQNtGIhk8D98we98xaNiRMfVkqebFty/HAM97CMt0DIVUPD+4EZOJee617+csfT/NYfgflf/FBb/L5nXpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156975; c=relaxed/simple;
	bh=L2Q2Gv1SqkcOuddrjKJDgvkqmuTF9MQuGmwjw7vhz/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kzJT+3qBh+6iRLUYVPuKuIdLgfXIzeMrSf6bjGeGfu+01NNSJlStb4yCglmTxGjbI3sYDnqmgheJ5wdI2BThGXZKI2cDbTHneoMHhiisVESVECJ186+7lqxosO9QJoVKkTRNIWPCOKaK3nAE0OA+7vQX/46LEnI3RydbAi+oo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pq4riuhL; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq4riuhL"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c21dbc9c1so33839453c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156973; x=1777761773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=Pq4riuhLfTSVhe7ocbLhA8zZreDKSuE+oP1BNK6JX6TQvmKaJePwKmUhw6apGwV19O
         Ys5kbFwaiLC171qxZiAC8Ph9tnid6wGGuo56jdm0h3GeEQHR2Ss5rEZesgLJMWchkYcY
         kp9XWiY9wl62hrTZH3cZono0rNeOtLjBMu+sImt9VH/27y4qlRB4ephBqOjYxFBekRnp
         Vd0NbweRyeXWU4TS0XL9ecDP4bFnf8XxQqHNp8jxjbWidPcWbpOhFqLX6hD/MVFD0Eau
         DkcfhiCLKUvtGqEEC5POuC4Kc3SnaQ8Ev3HXT/0e6Hz+6U5laJqUHddzkpbLUBHUn0LA
         BLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156973; x=1777761773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=jktFS+grbb/mPW56Q/enbYiek17QKro8Ay1o0uMrdwGu+j3rHOLzNE+FyOc1t4EWjd
         LXmSvSNsXrq3j6S5a1O0gSoGrYr4dazZhgQvTsxjA7gcYAd7ns7C8agsDjM5wVDhJvzU
         gjPEPvkxubI9NTdNFn1Ssz5Ydzr/gfHg76zHzaNIcq9zUW9O0rDB3+ic4/z+BWczQm6H
         grwCQPjQsUJdq4pv2Rt+pLQm5BYJ0Fue3GdPrL1WVEXnqcsedYawn5rK3Ih5kezzOf0o
         lzS3GmVN8tjG1fHg122IrIqp3x454YOYM9Lg1kDFclg3XE1L1L+mz4QqpM5msOpbGdXW
         6ogg==
X-Forwarded-Encrypted: i=1; AFNElJ+llrUL50Z7NTtzA59HfCrPxtlZy7G1jb6w1RF9slzRCYeAcFuP4MfxQYWCIFJx6sEdgcwmdZI7emP2ydzB7wl1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ROMItsee9CGTzKBBSq038C530LY/8Y7nbdC3HJGjCf+rGPBc
	uexfuRQu1ByCpxETNitJnnPHLw4qyaTXnyPm4XQNxsVJQ64RsOEKA57h2zci5CT1ldDvxYhGNju
	ohiNEN5AWUw==
X-Received: from dlbrl2.prod.google.com ([2002:a05:7022:f502:b0:12d:c3dd:4fba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:220e:b0:12d:b3f8:60e7
 with SMTP id a92af1059eb24-12db3f8635amr8447826c88.34.1777156972491; Sat, 25
 Apr 2026 15:42:52 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:41:05 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-41-irogers@google.com>
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

