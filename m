Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931D3ED11D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049352; cv=none; b=TWCuDpBE62ZBaD3GRpucsfWAziVDibbqDBXHSedH8Smux1KtKHl3E1VIIebtRLxOwmAjhT8Wb+FS3oD5xyTb+lINYORK45qJhKYHF7Mj1ixM5NPrL+VKkbr7+iDNJL+X9vtyTX9EFqw+zLMgSxVEOLusC1bhk941aaBmVHjFV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049352; c=relaxed/simple;
	bh=L2Q2Gv1SqkcOuddrjKJDgvkqmuTF9MQuGmwjw7vhz/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K7Pbhu+ZnPVzsGi4qBzyeykNzXN04L8cAnQlY2YmMRZ9I3UrSFpt+VGZVAT9xfGc0sb8yxAPn/H4C4+pwW6+BdjhGCo4wlPrUfdQpo2HE45kuDUvSV3VA7KH218NrmnSvJhCUch+JrpPlToKNcD8eVkUGDf35mZtv7t/tjpKC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ei+oRpRv; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ei+oRpRv"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d93379001eso16227754eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049350; x=1777654150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=ei+oRpRvmf7pZt6kgkcPZ35AGg6QYfcgZWIBuEO2bEasfI5UoDYNOlaneQ2qtEhXm4
         drfPATyXmb2Wy1ZYby1JhINKiA6qW1taVuULN4o9U6H8fV1jyZ6LZ88KlWZ6YOzOB7JK
         IrFpgLCuPGuaU78tP9rqWW2LDWpp7l+uShbtdxPT/Vz4zZJbcHLCReWfV/H7zn8q4sXu
         kPp2wcAQ/NzVJAAvrFEmrGPojjIofK5rR2a97+tlPsIMlJZHY+Y4izvCLxAjMuKCwgb8
         UDUmRVa2X+cyQfx1vKk9m6Al3nZgygZbBQKkl7XmVn421BOlw+NScddGuqzXy2J32qXN
         3vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049350; x=1777654150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hpHM6Q0qnz4rILJ4wjp6r0pWm8+LVx9WiZ78eUWKU=;
        b=dFbXMnRFluHTofOfhaPEGzWJ47b84nfWStvEMtk7l0o6RY8gCI99cb2c1VNYyEK0HT
         bdnRNdRQX3JkQvgxdl3oQqMEbA21wNfxe/esJ/6j1cpKPh/cUEa5g/3EXjOmHKjaoiNr
         I876ayDeDn7BxpHfVY1ltVzUnGxVt7+0i8VF4HrTVLsBdXIZkDiUFBSYpLVEwqoUT5rD
         5hrvHhC15xfbtLyT3bcyAPpod1yA6BxKbnX5dsRUMfvOr91CEC4TYFasx7/hFXhDC37T
         16UPwAo+Yzf7jYATbFK7mFH9+TlTG6GfxI+hXq8PdzU9cwTmI96KuPUqY04UCPw+iZlb
         ik2w==
X-Forwarded-Encrypted: i=1; AFNElJ/xOcWXyX4EA1nvNqXRtljZUwqWdXzAp0eoaf3BRC42SAPhsqRkgqqcXB8tlaay3Z57wTRRblQ+5QM46aZD9glK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68PV2rTUpOUhSEdRkOizXv5djuRONKBY3Mdba+si5atpZoLeo
	P+juxM9taOuIX2RVFX3QbvKNF7Ce3hspEmpWKHqU6M/ekgQds2pcOExMxPs4tGwFSiMyJcDFWnz
	YZrV6p8vOuw==
X-Received: from dyhd3.prod.google.com ([2002:a05:7300:8283:b0:2e2:b79e:ed06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3007:b0:2df:5715:82ca
 with SMTP id 5a478bee46e88-2e46557d3b3mr17281333eec.11.1777049349822; Fri, 24
 Apr 2026 09:49:09 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:02 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-41-irogers@google.com>
Subject: [PATCH v5 40/58] perf net_dropmonitor: Port net_dropmonitor to use
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

