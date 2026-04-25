Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDC3A1A5B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157470; cv=none; b=G5RWE4440FaX5xU8cUmhV/Pv58FCwd4xFtQTWBDTXcedY+nSiA2QoRtSYMIto4SuuXwAUY97VAchJDen8cCBMt/FQNJrU0ePDKyDZWDzueFgef/Bp1Jxq1DQbB+Xzc7FNRdqkneEwhVuYiAju+meA/6pol1q6cec5B8uWfYlU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157470; c=relaxed/simple;
	bh=vx6IVFKsB1ON0PlvRVEBkeEhDRXrkHr25y7aVh90UHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIzsZFqhbsiJY+MxNsgcdwkCztzj2xZFOxJAQIocepROsntShm79ZgJ11cd6Yi1ftd4j8eUjAPIN5+Qe5Ud6oe5N2aYTkwauZWcMg898kn/i3j9iX+k/AgXkvQ2Mf1xd00hSOree/B3mA3C0CQx7HKGNbb6eBOS5SSlhtna2gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btB07TBB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btB07TBB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4019so11833815c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157467; x=1777762267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=btB07TBB3iUQxNLZ0oYb9JeECq99I7mDoVqv6OWjP5XLOJOSBI96u2V+iJbB9i2cys
         ylvoyZL5zSzQytaLQXvm7LChp2PsxDDg/S0JxkIGOnyv/KaAOH4HcuDKKudXxl+D/Q3a
         gHuYJudUuUy23BX0FUokCbhJ9ER3ei1eL9ADL38tVmaczNtMcfmwyBfLplE6qeYhKoMu
         +tC541m9JH1n47vtXH+EIvUQiAYbYysThM/2tVA9Kj1UFxWeg1/kR1uAYUJKaEF0yppr
         lBUWSYzEMM41IRpLkjRzH2KXA9HL/wA8QBkXO9vjES+ylf3tuY79WMKa59LM+XZQSnH5
         wkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157467; x=1777762267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=p5TSFcqI7GftwnWP5pgUGXzxuhbgayK7uYik3CtQLh9VOacs+FF9nyl4aNBZt077uv
         3aTd+x0qI77ViIFGzdhbhQlVVOVE262xyIZgipLxUyoNA318iaPCmWfg8lV9Q8zQo1sH
         cIXewvrhJ+cZAd0s4IZSDMf7JLISPO4TPF8hRDi/ZH65MOz2TigQpOwxdSYHeHdPqRyH
         cystWPeh/cg32yszLVgD0yfOKyTCAXNGl2fzhcrre1qdjUB0IA4MC6hVj733Zl4n45IG
         yTUL1NfY2f5I1gKLmJJzUCmCRnzJ/XMbBxgY6Wn/w1JvaCM4evK5MUoS7uyGJRaPx7qJ
         PhkA==
X-Forwarded-Encrypted: i=1; AFNElJ9nXrdX9hXD6mk/oDQ/kYspPjK0JdHIgZPwQr+KQZR8Qgi+5JY9DKqe2L5BqoY6IyOY/xAUlt7WfEgnkD+yET0y@vger.kernel.org
X-Gm-Message-State: AOJu0YzQclh9TizaZPIsbDinR7SkPkypgMMEFG6Xq2hvzVinX+dZzIkl
	G6Cb1AXMfM2nxhN8WY+/EWdfaat2ajqc3KdAEp9INQ+EXlPiS7C4umLjiDGfmBz7buHeZ+dcLtP
	cBxPTlrN1sQ==
X-Received: from dlbqq11.prod.google.com ([2002:a05:7022:ed0b:b0:12a:7182:6cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4395:b0:128:d24a:a5ba
 with SMTP id a92af1059eb24-12c73f90c45mr19012420c88.20.1777157466999; Sat, 25
 Apr 2026 15:51:06 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:18 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-27-irogers@google.com>
Subject: [PATCH v7 26/59] perf mem-phys-addr: Port mem-phys-addr to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Give an example of using the perf python session API to load a
perf.data file and perform the behavior of
tools/perf/scripts/python/mem-phys-addr.py.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Added command line '-i' option and cleaned up pylint issues.
---
 tools/perf/python/mem-phys-addr.py | 117 +++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100755 tools/perf/python/mem-phys-addr.py

diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-phys-addr.py
new file mode 100755
index 000000000000..ba874d7a2011
--- /dev/null
+++ b/tools/perf/python/mem-phys-addr.py
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""mem-phys-addr.py: Resolve physical address samples"""
+import argparse
+import bisect
+import collections
+from dataclasses import dataclass
+import re
+from typing import (Dict, Optional)
+
+import perf
+
+@dataclass(frozen=True)
+class IomemEntry:
+    """Read from a line in /proc/iomem"""
+    begin: int
+    end: int
+    indent: int
+    label: str
+
+# Physical memory layout from /proc/iomem. Key is the indent and then
+# a list of ranges.
+iomem: Dict[int, list[IomemEntry]] = collections.defaultdict(list)
+# Child nodes from the iomem parent.
+children: Dict[IomemEntry, set[IomemEntry]] = collections.defaultdict(set)
+# Maximum indent seen before an entry in the iomem file.
+max_indent: int = 0
+# Count for each range of memory.
+load_mem_type_cnt: Dict[IomemEntry, int] = collections.Counter()
+# Perf event name set from the first sample in the data.
+event_name: Optional[str] = None
+
+def parse_iomem(iomem_path: str):
+    """Populate iomem from iomem file"""
+    global max_indent
+    with open(iomem_path, 'r', encoding='ascii') as f:
+        for line in f:
+            indent = 0
+            while line[indent] == ' ':
+                indent += 1
+            max_indent = max(max_indent, indent)
+            m = re.split('-|:', line, maxsplit=2)
+            begin = int(m[0], 16)
+            end = int(m[1], 16)
+            label = m[2].strip()
+            entry = IomemEntry(begin, end, indent, label)
+            # Before adding entry, search for a parent node using its begin.
+            if indent > 0:
+                parent = find_memory_type(begin)
+                assert parent, f"Given indent expected a parent for {label}"
+                children[parent].add(entry)
+            iomem[indent].append(entry)
+
+def find_memory_type(phys_addr) -> Optional[IomemEntry]:
+    """Search iomem for the range containing phys_addr with the maximum indent"""
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        position = bisect.bisect_right(iomem[i], phys_addr,
+                                       key=lambda entry: entry.begin)
+        if position is None:
+            continue
+        iomem_entry = iomem[i][position-1]
+        if  iomem_entry.begin <= phys_addr <= iomem_entry.end:
+            return iomem_entry
+    print(f"Didn't find {phys_addr}")
+    return None
+
+def print_memory_type():
+    """Print the resolved memory types and their counts."""
+    print(f"Event: {event_name}")
+    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
+    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
+    total = sum(load_mem_type_cnt.values())
+    # Add count from children into the parent.
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        for entry in iomem[i]:
+            for child in children[entry]:
+                if load_mem_type_cnt[child] > 0:
+                    load_mem_type_cnt[entry] += load_mem_type_cnt[child]
+
+    def print_entries(entries):
+        """Print counts from parents down to their children"""
+        for entry in sorted(entries,
+                            key = lambda entry: load_mem_type_cnt[entry],
+                            reverse = True):
+            count = load_mem_type_cnt[entry]
+            if count > 0:
+                mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
+                percent = 100 * count / total
+                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
+                print_entries(children[entry])
+
+    print_entries(iomem[0])
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Resolve physical address samples")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("--iomem", default="/proc/iomem", help="Path to iomem file")
+    args = ap.parse_args()
+
+    def process_event(sample):
+        """Process a single sample event."""
+        phys_addr  = sample.sample_phys_addr
+        entry = find_memory_type(phys_addr)
+        if entry:
+            load_mem_type_cnt[entry] += 1
+
+            global event_name
+            if event_name is None:
+                event_name  = str(sample.evsel)
+
+    parse_iomem(args.iomem)
+    perf.session(perf.data(args.input), sample=process_event).process_events()
+    print_memory_type()
-- 
2.54.0.545.g6539524ca2-goog

