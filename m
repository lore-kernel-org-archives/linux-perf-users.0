Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042A37AA94
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139395; cv=none; b=dRGTkAPvMUF/O2xURH7fNBx9XYTbCng48zGNXEqXwpYM+rj3iHx+MPVk/p9zqGC+q3MDxKdW4XFQCZBeL6Ybxpoz0AlCcVXbuNNrCiF2OYXsUGdVnBMXGvdxNbZWupih9VB9YzzDb+0reVa3jPXPEfx/OZ8OjC4wtHEcZkaQOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139395; c=relaxed/simple;
	bh=vx6IVFKsB1ON0PlvRVEBkeEhDRXrkHr25y7aVh90UHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ap8DlOUbfcZT+JFfydJ136/xf0OWNDKZshjMaVt7xEdauVtD502dTb8da2VRLA5Yp5W9YxfUBLMhbJZZeBiHykC+GqEQlyEg3nT1S2cDzsj0TfwHcXFOHajm3AZT07C29aK9zJXUl7ROTbe7Awr9AMyst9RPgti10nRy4xNmANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBcsSCR3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBcsSCR3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so8702084eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139393; x=1777744193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=QBcsSCR3c3LFhkjh1R1iGs5K+gBqmZXYQQfz7CZ/lhbJmx8RlCKUe4Znop0/PgZkOJ
         Lv2q5joBOiesgYJHaZcupp+L3dGyDpfXM3pq6n6aKevU+CpB3JDFQ/NLusSPjip+P92k
         JRH56v1FrjfTMNu0sRvvHSa8XH28dD7SR1wJBSrSLyFA+dU+rZ3vuSlTPQnI1ARUkAAp
         G3304GyyzLUod10F+k2tt7bo6OcBDwV9ljqBHAmkayUbL2a5WlSI8t3GL+6vn13tiD2G
         2KwV8av0fRwgdEgi+hDvF+F0kmqjQaZ4EDIHbyiEjfX4mWKakNO4/zJs45hWOc37U+P3
         LN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139393; x=1777744193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLDLlf+sgEgN/cBLQvW28zSQKGyhqbeTTGXjAT4IZ18=;
        b=L/isNY/9blLSEfsx0+5c1UkAvioYOP8gfiyIOAr/1OJ+iLBJJ2PSc577Duu/MdDYCK
         19BDoftXRVMtOSg/J/uPlX24GsJe/0wswpUPJxC/AMDSl3hdx1h6jhYtNbcLDCCHFdh3
         wAHT1auXbjvWEuYe3PCDE+RAcwvWftwZJp3cKkK1KHa2Vp0zxQIzkpeLwLBJWc3W9wsS
         TwAT13N91PC1OVkRytZeV5QUduCstAq03ynuLs7UomA1qPGwdFRFLVUhqSwbx+EtGo62
         WDjAsOSq/7SDFfwvkVyuR33C8L9wBZHYi+x/e9yshkdbN3sihYdDRjGNN67bDGaf/qGv
         1tJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x4CDFeDhG+XQgEYKtv9Oet9UwXD7cce+jT+zmr9EKuBLJ1iWzeZ1NqPRV6zqN485kl9xaca6s4wUPPlzRWEgw@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpIOxyuJ3QydPV7nFojwaKhQ8fIO9CM6upDQjpI3uJUwEAC8F
	tmEWcKMlldjP2GV0Y81eUTm0a7QlqEGb4tp8eNRzZATz/aJ8j84VLU3YEsWyJrPlprG2fVcO4vt
	waCbWo2livg==
X-Received: from dyji40.prod.google.com ([2002:a05:7300:7a28:b0:2d8:dd18:baee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72d1:b0:2d2:d7b7:5c61
 with SMTP id 5a478bee46e88-2e477c9bd68mr20346170eec.14.1777139392399; Sat, 25
 Apr 2026 10:49:52 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:24 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-27-irogers@google.com>
Subject: [PATCH v6 26/59] perf mem-phys-addr: Port mem-phys-addr to use python module
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

