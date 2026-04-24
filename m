Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6A3E7148
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049323; cv=none; b=tBN2Ctv0JvL8prNhSkJ0rG37fSXJkDruKw4ClWBDu+P/YlViS4Q6hNlbMTZoOGHEu1IF2S12NiR7SVaKlRK0zq4nAmYJ08VCGvTNsf89Zusx8QCWNBvmDZw5zSdDQggoOo6lRPDL8Flc2FwW4Ki6Xd06lSurW5FN4b6+SxkmDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049323; c=relaxed/simple;
	bh=vx6IVFKsB1ON0PlvRVEBkeEhDRXrkHr25y7aVh90UHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QNOn9z/SqjQBU/XBIFhWkw9Jbgo8aXQ78dqZNZh8gWFhzvOFyhqM1TngGBWsM57aYyKxv6Ng5UP61CfQBO7itAw2ANuDApmxTYwS+aJoI0koMi8DQK9om+Ra7CFvsZwGRGJ1mkdUwEtKIdCujeL519PJlcwLkqfUKOWtxQHVpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNc6ZnwY; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNc6ZnwY"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso5197871eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049321; x=1777654121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=aNc6ZnwYAfBWf97E01aKb6c7ofKrBgulcuYzTPgBcDiqO+utITYVMsb7fBp5JZ4sJg
         NhAhycf2ImsZhLyfl+YvMrR8J7bApE/GzSq0QmklYWrsH+66MynpDHHEZPn4sA+3Xl9D
         K5VAa4AP+5l9nCipOsx4RD5zm4xEl00Mk2trIOzGJqRw1fqJH2+bpuzcXmR5EGCQRhvo
         g9hPxAkhJVCZ9nZiuhclPFQrEVQYAZlugvGN97dhUFGH+M68RtG7aaADRNtAUZVF0kw+
         PNJwFgXZkvv7KE6CcDJpLDtykXdiB5E6qoF3YNetfNjG/bSW/J5BsaPSl4+m3dPxZDdG
         sgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049321; x=1777654121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=AaJcetP0URNJwIZI99xt8oqZgQ8tb1DT4VpegpGPoMVLXypUw0dkEoHCaVUetFbYe/
         bUdDFWJsF4/gmsANGDB5xsp8zNJ4ntW5uP2iFiAzdiPXSfZDtJSsTTL+P5X1WArSAkiG
         mTbwyCZMSJTlGTqBfHfcuflOC+Az+jX8mXPgOiaVgavBcNz1BJ54QJMMMkQkEFJdQngZ
         QUCUTSHGP5Iv6yO0DUqEmCMJ3MKKN8Ch0VQASQkHUES7vWzLCm6kZiBkstncraDU99DL
         l+EEdPf+A8DgSoOyllfaarVSUwYYDuNq68pSjJbvKSfMmtlgHSaMLx27f/rpRobs0RQg
         oJrA==
X-Forwarded-Encrypted: i=1; AFNElJ9GamS4kl8k0jr8+sXQteYsdELtGLwJ6+gXjTdSHdDWRuLSWH8wrj30qmNKWWN6FAvySBf37IbpqhzF/q0TM1dY@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWIANOANMQf8jQUaslLgyCREEHJgjbdm4FikQcyOhVgLQYInL
	4hcmJxoAZlXyN1W5QYBbP5dzelh3/gZdDfGOWcyJhsISo5Va8QAflOJLpE9RuIO5Osi5GYC5YPL
	hekyGiyU/PQ==
X-Received: from dybnj1.prod.google.com ([2002:a05:7300:d081:b0:2da:5e63:c8e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d19:b0:2d1:9b35:4edb
 with SMTP id 5a478bee46e88-2e41a1e3fb6mr12966215eec.0.1777049320843; Fri, 24
 Apr 2026 09:48:40 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:48 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-27-irogers@google.com>
Subject: [PATCH v5 26/58] perf mem-phys-addr: Port mem-phys-addr to use python module
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

