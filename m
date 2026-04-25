Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799038D686
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156947; cv=none; b=T+KJyYanwY9fouetXuTJM6WGRJoZKyELFVdNMKN/HAphtcaBOkkS4qQHXOgOGIdAGAWniPE2/ZFSvFjV7l+oVBkSoJN0XJ2YmpoCxkKv346gv+Cq4aISOT+TacIbpmLUcnQiHiOpiEtCN16SLkLNz26EbOU34C0l12ORrGoZgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156947; c=relaxed/simple;
	bh=vx6IVFKsB1ON0PlvRVEBkeEhDRXrkHr25y7aVh90UHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UOYpgCGeZ7YrAQTrRc3yDIEZ6z/YrxbVwR56Kp/wZPxklgC7B8HoOEzi+n4GwzENfxewVrefgaEWnMFl42f4Ns7yOQa06Y9mGaDB8DQSbfsy4tvR7JZDkDoxRUdf5n0xiPapOzlbre5iG0nxhxYFSpMFDS8fk65UkA7M3pUL1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ+DnPw0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ+DnPw0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b454cac322so84524265ad.2
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156945; x=1777761745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=uQ+DnPw0+XSPUPZm0C3eB0hycTtUwVBw2SiV/YkX/NB+KpUl4UzvydrE1dooqGpEJu
         dq6mO9X+zyQF/uInxuGg1zQc7NN5wBAn2LlFNwKX6sff9CZvkYoBD9xOwrC8oSdQ3DMv
         Rau3PgD0ZnRc3e0J001r+uC/n2HRKcAmyb6mrv7dcnhRg5PqvmCXelsZF5cpl3Wqfy3b
         LL+ez4i7DmJasHrWwV6CVFIy5I2IVlADjuVOiTM7UUzZOcDcPAh3LwHdpU4EDovdO21D
         tAZgVE6tXmXgvx3RnAV07UOL+OiyQllvBM5pJIQMzG62ZUTutJe583rRUGSN6Vv6n+gx
         x7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156945; x=1777761745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=tJGJ/8cmqlN75dANZRKp2mXx7pFNeettIkRljQ6O7ah5YpAkRxfQ9V/6h1LsB5iR/R
         y/0jtMf58guPwX9FtPyJp/VvegBlDAl3tv8QC8CglM0VxpZHqg56/Sa5oEMqPIW4yAR+
         2L0HdKaSGmSNN/jiUwemVp0mdZD8fCkDUx0JQORKbakaGpTj4f4MbB0q1pnPNFd/IzAi
         2l6Sx1aexig1NAiuiuUcxFrtT40Rr1SijIlx3NAXHGo8rlLvm7yPh2Cd2lfjY71ewIOD
         nCMHuKtf0AYJMp1gjbZkmBObEzyhris2Nf88TO5cdknjQN2jDPedgO0rJOJyhTmWDSiW
         cREw==
X-Forwarded-Encrypted: i=1; AFNElJ+1suPw1pXZsVP6YK63eOVDtu8e3zClf+qXc4+P5oHbZ/RhFMoZ63bcmO2Vnqkb4yfWFGL0PH2xaYa61apXbmxB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/95qPYiX5dKOUtt0TC03Ed5GzGKFKvXDR1Wu0HRMvq7dY8uR3
	Xa/Arxb/b2ym/T8ma/80ac+WPGFnnS4lAInVJVNs5Bh/3u+ngDE0BIy5AxTww3RQBcPBy18NQBG
	isbHFSlAQ1A==
X-Received: from pghx8.prod.google.com ([2002:a63:f708:0:b0:c79:26bb:5545])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d91:b0:39b:89e0:2e37
 with SMTP id adf61e73a8af0-3a08d6f22bfmr39696669637.14.1777156944816; Sat, 25
 Apr 2026 15:42:24 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:51 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-27-irogers@google.com>
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

