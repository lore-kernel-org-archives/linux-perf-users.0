Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD63A5444
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960663; cv=none; b=QLKIgt+ML0qs6UKgzy53aeUU/UuqFMPMZBFAtPw2WKglb9HLZ/xjXPUhd26VA/tLdsy8AGMttQ5984MoUu0Cf+ndeZu6Ag39A6gXv520ufSf2eFVOy+4ItxbjKiSAKLRBv99GG6KQPv/6fJ3u9Wl8h+kXxwgvZViChPzzhVNg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960663; c=relaxed/simple;
	bh=21yvkvvibRcBFyLCzkOEhs7yL1I2GHfegyLuugszGUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NCR7u0zeGYjBcJ0oLfdnmhYIORM5rtWjktJb9NXwmDz0t630nHkhpUqzdkiUPpgcSC42oqCqNXxIo2gJESPHNTPIex57Au+k7MUIBJrObRSSKTv26I/qPDprMm8SbnezRJNNGxw7xNo4VXmgUxwaahROpyGSxZjM8IlTUjCWcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCtxKUfY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCtxKUfY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4055so6000324c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960661; x=1777565461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/UtXMyLWjYDcjA91HkS9s0ti5HVEoifX0Xw3V4fIII=;
        b=uCtxKUfYapiKwXhFW7REj9jqfER0TDJ71G8xV0Z/N++c/oJQjpm7w1jHDnTLtQ14D0
         pNwaWa2EpFb3TrDWLg7VwYU6uyWMOJ/6i/JArrTE6461LeTo7G700shIXICnz+UviHls
         XS5A4RDHyc9xrcTfKMsZGcBzWeQskSkxFEdfhxKP+MOkJMZqHqBO/TbTOsKE+dcOos5T
         t9Sqlro0d3sZYBKpEk71fJxB7RUqa+gzHnqQrOy5mu0hZftOVNUaVrCzJGS2x2psDsXd
         IN10M2unDGqIu9pXRGhEOHVDpELGPuyobdYQf6sL+Wuh9d5pTERjxDtaBC1ZH5GxnBoE
         F/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960661; x=1777565461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/UtXMyLWjYDcjA91HkS9s0ti5HVEoifX0Xw3V4fIII=;
        b=qKffApzjDc4oyluisqyIEzIk2x+NK7/Lw9xsunSO7r0Cf9D2ntO7hEUDk+kMFgOPU6
         FHBA0a8OZBMuynJKN6IAfrq9VfjaRcqZWogDA1NLI8fCu3t6KoJthf189bPGlu0SUiRS
         OhSXoqX2nsiXQIvb7PJnz7r/8kxl3jFElCf4RRSaGWP+VFVOlHqIvHuNi12SlGX46qc4
         9EGJNF9z3y+Hat4TatRZThzQ9mruwIPvqEQz0xtqWEm27FZD4YrHwSBz3ZG1W7Oe67pU
         aVg/C6XadIA1LaMAwhhnvqNObI1RaNdKi/QLj91XmBU63nqbaoyex9fUtmtFboM9EF4a
         HuKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ys18Zu+FTHar87598/d40LD6TAbBFnBRjAA92HN1qVQ3Wl9r1vYKeORe+PHtkzsRkQKH1CDuudt3SlHIYRrcx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtljp8h/9NcnoFHLpksaOwwkfE9w4xYeI5AXcWKnynHHQgZBSw
	/dNCT0wqFNrCsuX5CW22OQoAvM3nnlYAdd6uGHtCzmFZUJJarBv1XpQbD4Q5Xg12+fV08LF8GBH
	m+MHfLyqxUA==
X-Received: from dlbvg2.prod.google.com ([2002:a05:7022:7f02:b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b99:b0:12c:2dd7:9099
 with SMTP id a92af1059eb24-12c73f9fb84mr15302324c88.30.1776960660831; Thu, 23
 Apr 2026 09:11:00 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:32 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-26-irogers@google.com>
Subject: [PATCH v3 25/58] perf mem-phys-addr: Port mem-phys-addr to use python module
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
2.54.0.rc2.533.g4f5dca5207-goog

