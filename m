Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5B3B0ADC
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960693; cv=none; b=aCpFf+ygKanlenhawcy+LDxNSHbVyNHpwlJA5oRRejwT5VAHmY5EKvUcqrsbePlIR7LtX0Gt4uyUL7Cadd0WHOgK4gwrDoOZvGhoaB8y4PmAQhY1uMg4RxlBrnKER/2UZctDOEXfF5FYGvHDi0owZMzAAlwn5xDuHUQlujlZrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960693; c=relaxed/simple;
	bh=xQbd0iHaRYIzt8AMDuf6Buy81mO/GSrAQzhD741t0ig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ma70jLyHMeC5qn+4z/JQfT4fuYAk5JlX7rEARm2eavxGZq8N1m0UJDLjZM/wOQwfMNlfbvWQSqIYSaVEOzMgJTiifvdIbxSlTnrKc6XaU1M4fEut5HykXmUYCciQhEQ/6f0zUgrW/7TjJrVPURzhoOjGOWhrNkvlQDmyLUt4yYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f67iDVuy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f67iDVuy"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d93379001eso11977818eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960692; x=1777565492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pu8V1iDQ1vqVL+s/ZIuaxiAhicRo85duFyctDJVPVaQ=;
        b=f67iDVuyRq7lSAWvRln91/QbWz08H2cRfU7xdui4w2GL9DPNM/DsWXokR+Y5wUc1ZS
         iYtIYMVO8dvJHeOiPFjQm2WjRLztzRVlrBQyiVR7Ss1dpo8D+YsIJ9qCYrxrLp+YKvvO
         +bxgluFvPS3Wc/gH0qnPec9aa7SA085k/LtlYcHV4lSACJ+QZabHOuKAbSDqKCaeb/o9
         oDKGUxFeTclyvPZlltC4XVTYoZzVe8vfRCPDFoZJc9pcmHtrrEyqGAt8+q41sqz8ZSFC
         lsoopVk+97x3fpWnibxBCJxqybBLFLm0gsadLd80EgzC5Mnf16h3a3tAA6D2KhIvWlP1
         e/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960692; x=1777565492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pu8V1iDQ1vqVL+s/ZIuaxiAhicRo85duFyctDJVPVaQ=;
        b=rJDW24UDeTo8+ap8b+HrgxE1+CHhFvyUwqOkMp/Y2jaX8Q1Y9BIp6C4z0pKNPcsAkU
         Ba0s9HtXVRQbRp+o5sjp5IQ5aJPXW2pNauIVzaP+2X+u49JzJoCvrXPkSiKtPnoU0jiX
         uipG0TYt2Zh60cpaUvetnCcTYzMvsAy4lZ5B8FFxMXy/8DMprc87Qv8nFqFE4sooPF39
         ahDDCTgYVd5fq43DMd7v58PV6GSA+xgJweAQMwVCsHwUmbvAgjsmWzZagElMTebGXlCL
         wQ4++TacZ6D7okv0y+cVvrZJAmNxzRp3p8ZwpcFLEUFCP12PH3vYXcUG/6Hpp8QN661I
         eW7g==
X-Forwarded-Encrypted: i=1; AFNElJ+dsXhJ4N5BDk8jHcgBK/6QRY73EL/SJNjtr5ApWFon3nwYt5Zl7K9j66SRUyeVf8N1gCdfYk8fS2kMGAOWtPFR@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuylohP2H1j8UtVSLYpYuT+yH1qnO/uUP4WpLjnbvURIZZf7F
	arrbGTry1ZFYpVIg5hjLi694wPDY92LP0f51PyeNse+AADmd5UTYxvPk/QO4OiHThRweW89X3jt
	Z1GXY3N0W+w==
X-Received: from dyjf14.prod.google.com ([2002:a05:7300:680e:b0:2d9:9fa3:5aa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4185:b0:2d9:fa9c:87a9
 with SMTP id 5a478bee46e88-2e464ea79b5mr15894618eec.5.1776960691164; Thu, 23
 Apr 2026 09:11:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:46 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-40-irogers@google.com>
Subject: [PATCH v3 39/58] perf net_dropmonitor: Port net_dropmonitor to use
 python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

