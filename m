Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EA3D75DF
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916626; cv=none; b=KpF+0retujrXNnBRiLtYtrL8OLp2AiX93daSGgg+yh3tq1+O4GlirEpjRi4uhIyWRo5dy4RHmmGgXe/wY7GBiLMjRU1Cd8DKN1xPFG9XZYuOjMS8ov6oQ1AWWWZoalBW+KxQfzkRWPrxoaJoCxxhPbtMs/slMPsT7GM1B/YTdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916626; c=relaxed/simple;
	bh=xQbd0iHaRYIzt8AMDuf6Buy81mO/GSrAQzhD741t0ig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Er1mn1Uh6ea5d5fnT/MRK1PZtYcZDykXj2KUAYH9lbU0jolgoUU73TMsh+5Pl1g9vu9D4DlAfaEGsmtHXdGSiB+XTHc6N5VAdJOK1gCZtMvtFgfwtVlFSUq3GzqXhLYH0vpspV2twVahQRpN5mxGS3AQFo1i7umD4TjO8mbj2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dy3dm0OP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dy3dm0OP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8de02a4dso7487460c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916624; x=1777521424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pu8V1iDQ1vqVL+s/ZIuaxiAhicRo85duFyctDJVPVaQ=;
        b=dy3dm0OP3SssdBK762w93vgRMra9JFOrZWUA4L2wwb7k19mGlLXRCCLV5bu5KNL4I7
         RcZzw8zGEdt2y8FFlFHiC1cFmR2lqGQfRRLUm7/IXcNr26KuacNol6YoH9R8ZJb+Jws7
         sFLKSuQItK6a8FDeoA3+hg5xjx5LgOC9X8oaKfWo+wqD4BgFso5JXu7UEHMmGQ3KdkzH
         /OuVlTOE8DPwHJUhHgy9qzGg6ufQb+wO5h9b9Gt1ybB9snNvuS/rIgOHha5+25u1Hw8Y
         TLQccH5gjlJwrD+VBW3mQ8EWe7Ub8Ab6ZVpzBaARJEghZllypWqwI1aDowfNPm8t5oOO
         1U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916624; x=1777521424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pu8V1iDQ1vqVL+s/ZIuaxiAhicRo85duFyctDJVPVaQ=;
        b=Dhv9w1B4GQpuInx2cIXm61RqGkr2g6ffgqoayh1qbZqHI3luK4plp3iRSkWeYKEt1t
         jeTVzMQ/zLUwcn0HThOl5PtEGZAd9nlziMiskRl8bA/nJgGTpwc3sOLqI+SNXQ6SU69t
         K7dWS3oIgeXRO50QFULIuNZ6NZt4kK5G0L3veNHnDpqlNftcjZXeJQpgRMEJg6o2MGu5
         rGYGqVCo+ouZX73Q4UIx53ly0hLWyd/uzc0PiEvktZVg+GzQ9oPVOZhDl9KZI3U/UtSi
         7zun8fuoVsSdqgrSmJBbLSoEfBd/b4iydEkxdosk2XZKcBnAoDWXI2Lm7znYPiWsGhsm
         pQOg==
X-Forwarded-Encrypted: i=1; AFNElJ/peBCD5YEguZKqtXh8p3TqNKVuKU/S6GYFDP0Pp5GVx3iaG3ImtoxGN5L7anz37GC4ZJbQyE7V3KNg/hIHKEfi@vger.kernel.org
X-Gm-Message-State: AOJu0YyO77aXpc38AQ/hdlYzBBIZdC9+6kvyial4Ye5BA3Lmcn5E9obQ
	Qs5JBGZYs5nO+ORurC0glLTPEm0+9Dy0+Agwm5G5VPme67I4+awfnonm83e0B7K3CEzaBugV4w9
	st3/jcBJHTQ==
X-Received: from dlbcf6.prod.google.com ([2002:a05:7022:4586:b0:12d:b65b:1fb3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6290:b0:12c:8f92:c6ba
 with SMTP id a92af1059eb24-12c8f92c9damr9827510c88.34.1776916623604; Wed, 22
 Apr 2026 20:57:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:07 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-41-irogers@google.com>
Subject: [PATCH v2 40/58] perf net_dropmonitor: Port net_dropmonitor to use
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

