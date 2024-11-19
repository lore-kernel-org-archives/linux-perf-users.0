Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2001D27B4
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039297; cv=none; b=gSMw5NDowsPygCShYlmLf30l//J7WGIdmVRzxpahrJc2KQkoTkpMBQ0jrwkbHjPWRtMTDhLpA5wnPpl7CaChYk68OPGe4UdKkFdJLwIo/MtNH68okR3W2rhZ9ZaiAsqIPnK0Xa3i/lGh/DukZolX6lp9tPl0Tbc+FFhGaIrrFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039297; c=relaxed/simple;
	bh=FRCD0mklqsM8YzYKgxccyE8kvTxTAZqJyW2FOK9fwEU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=Ia6EObg4Ew5s0pzbx2yUtgsZV8s9LlMbhXKzIUS/1tcGOqMlfd7VPsVRC0JY2xAjqCU88dagpsc8/j3SvZ6YfBfbodabkhmtNQIMzReQ6wxhfii1Hz+EOZKRvZzdJdU+W6Ahnh+GvQomdr6qjFW7E4hCccxr4yOETKgae42IA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDxLJvKl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDxLJvKl"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee6a218044so58462977b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732039294; x=1732644094; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TQFCW5HyokM6GPCpSGZP+kz1l/ptP37eeUF9xzXvHb0=;
        b=mDxLJvKlRVvGJrydo4xi2l7efx1WLQdpGZ1g3a9gpZHD6ESGF7Mb6bMDIb9ljZETgH
         4zO57Jlu/+w0CO5A/0J0mPA9+Luqm4Tv1C6LMM59x/0/awq6vjwIBWX3LACuaVwBeA+B
         r7SLcAeLib39Ag4zy+qWsaFaJC/UEEVqZ8dlYd91AUEZ5hifpZwJ9v7sYJ1bCJar78y/
         pFzbt8aALg4bRD4omusDd6Zg/fDgi77+fih32Nn5V9+Z/ZltomI9r6uHOFoqVtWJwOmv
         sP4nbbAiBZ6kkIQKl6DwxLyKMxGMyo8bD6TEi8CafxP0va39wRSyyCjxVbMrV9RppiFX
         mqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039294; x=1732644094;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQFCW5HyokM6GPCpSGZP+kz1l/ptP37eeUF9xzXvHb0=;
        b=vHCSH9Az63BAcg4HCnvvCOXmXFF2tPRJz9kVqSAx3Ee7vYxxjt6H9aMfOn5fqhI2bX
         i5LbTd56/i5M4a7Kgf48Co9UeQiif0jZ1UpfEbcOyvawoXB1g0ClTQdohDsTh4sDbrGh
         gT6urAorFg3XxYFrr1ndmkBvVteDlFC1nX0PMQ09XPH+RXVffEXlT5oGwBsqj9W1g7s5
         4dkEwJcXysK4rUJ5XdLnAW2i22CZZex1ee+NOwjMYAKApPmTD4rXGWND4ZWcTnPSU6Jl
         8+m51YoIDSSt2R6DYWWLPuCRd8Ye720wMCnHAycdJklxP7YqFkMqjDkCaPlIHOU2yItu
         zk8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJWu2JKE4KkHKGieb2V56dahE01gQnKwgoBBMY0Y792sgX4lHneLK/6atGRwlwyZMPaQsdx2kKgPRyDUtWhLkL@vger.kernel.org
X-Gm-Message-State: AOJu0YxyftrXMoFu0Y0uioWpRts1zSb7cnDzrdxgHYXhGVH1UnOHj/GJ
	xl6FzApcmc4o+L4yZdr/2lSTzhTou7LM3fAexCjxhHWqn2Z1OAownXQ0YCe1HMPfBg5ORKoOIOL
	puV70nA==
X-Google-Smtp-Source: AGHT+IEaamOMz7Fi+3YLgkkmVXxvJJt7gmHsMBKdyAI1rOlv3UWwoAKvdNTU/6CyNZsrYp71LWCKSZKKZmJq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:89d:ee73:740b:dfb3])
 (user=irogers job=sendgmr) by 2002:a05:690c:8c1b:b0:6e3:1702:b3e6 with SMTP
 id 00721157ae682-6ee55c8cf88mr588147b3.4.1732039294050; Tue, 19 Nov 2024
 10:01:34 -0800 (PST)
Date: Tue, 19 Nov 2024 10:01:30 -0800
Message-Id: <20241119180130.19160-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Subject: [PATCH v1] perf script python: Improve physical mem type resolution
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously system RAM and persistent memory were hard code matched,
change so that the label of the memory region is just read from
/proc/iomem. This avoids frequent N/A samples.

Change the /proc/iomem reading, event processing and output so that
nested entries appear and their counts count toward their parent. As
labels may be repeated, include the memory ranges in the output to
make it clear why, for example, "System RAM" appears twice.

Before:
```
Event: mem_inst_retired.all_loads:P
Memory type                                    count  percentage
----------------------------------------  ----------  ----------
System RAM                                      9460        96.5%
N/A                                              998         3.5%
```

After:
```
Event: mem_inst_retired.all_loads:P
Memory type                                    count  percentage
----------------------------------------  ----------  ----------
100000000-105f7fffff : System RAM              36741        96.5
  841400000-8416599ff : Kernel data               89         0.2
  840800000-8412a6fff : Kernel rodata             60         0.2
  841ebe000-8423fffff : Kernel bss                34         0.1
0-fff : Reserved                                1345         3.5
100000-89dd9fff : System RAM                       2         0.0
```

Before:
```
Event: mem_inst_retired.any:P
Memory type                                    count  percentage
----------------------------------------  -----------  -----------
System RAM                                      9460        90.5%
N/A                                              998         9.5%
```

After:
```
Event: mem_inst_retired.any:P
Memory type                                    count  percentage
----------------------------------------  ----------  ----------
100000000-105f7fffff : System RAM               9460        90.5
  841400000-8416599ff : Kernel data               45         0.4
  840800000-8412a6fff : Kernel rodata             19         0.2
  841ebe000-8423fffff : Kernel bss                12         0.1
0-fff : Reserved                                 998         9.5
```

The code has been updated to python 3 with type hints and resolving
issues reported by mypy and pylint. Tabs are swapped to spaces as
preferred in PEP8, because most lines of code were modified (of this
small file) and this makes pylint significantly less noisy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 177 ++++++++++++---------
 1 file changed, 102 insertions(+), 75 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index 1f332e72b9b0..5e237a5a5f1b 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -3,98 +3,125 @@
 #
 # Copyright (c) 2018, Intel Corporation.
 
-from __future__ import division
-from __future__ import print_function
-
 import os
 import sys
-import struct
 import re
 import bisect
 import collections
+from dataclasses import dataclass
+from typing import (Dict, Optional)
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+@dataclass(frozen=True)
+class IomemEntry:
+    """Read from a line in /proc/iomem"""
+    begin: int
+    end: int
+    indent: int
+    label: str
 
-#physical address ranges for System RAM
-system_ram = []
-#physical address ranges for Persistent Memory
-pmem = []
-#file object for proc iomem
-f = None
-#Count for each type of memory
-load_mem_type_cnt = collections.Counter()
-#perf event name
-event_name = None
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
 
 def parse_iomem():
-	global f
-	f = open('/proc/iomem', 'r')
-	for i, j in enumerate(f):
-		m = re.split('-|:',j,2)
-		if m[2].strip() == 'System RAM':
-			system_ram.append(int(m[0], 16))
-			system_ram.append(int(m[1], 16))
-		if m[2].strip() == 'Persistent Memory':
-			pmem.append(int(m[0], 16))
-			pmem.append(int(m[1], 16))
+    """Populate iomem from /proc/iomem file"""
+    global iomem
+    global max_indent
+    global children
+    with open('/proc/iomem', 'r', encoding='ascii') as f:
+        for line in f:
+            indent = 0
+            while line[indent] == ' ':
+                indent += 1
+            if indent > max_indent:
+                max_indent = indent
+            m = re.split('-|:', line, 2)
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
 
-def print_memory_type():
-	print("Event: %s" % (event_name))
-	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
-	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
-					"-----------", "-----------"),
-					end='');
-	total = sum(load_mem_type_cnt.values())
-	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
-					key = lambda kv: (kv[1], kv[0]), reverse = True):
-		print("%-40s  %10d  %10.1f%%\n" %
-			(mem_type, count, 100 * count / total),
-			end='')
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
 
-def trace_begin():
-	parse_iomem()
+def print_memory_type():
+    print(f"Event: {event_name}")
+    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
+    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
+    total = sum(load_mem_type_cnt.values())
+    # Add count from children into the parent.
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        for entry in iomem[i]:
+            global children
+            for child in children[entry]:
+                if load_mem_type_cnt[child] > 0:
+                    load_mem_type_cnt[entry] += load_mem_type_cnt[child]
 
-def trace_end():
-	print_memory_type()
-	f.close()
+    def print_entries(entries):
+        """Print counts from parents down to their children"""
+        global children
+        for entry in sorted(entries,
+                            key = lambda entry: load_mem_type_cnt[entry],
+                            reverse = True):
+            count = load_mem_type_cnt[entry]
+            if count > 0:
+                mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
+                percent = 100 * count / total
+                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
+                print_entries(children[entry])
 
-def is_system_ram(phys_addr):
-	#/proc/iomem is sorted
-	position = bisect.bisect(system_ram, phys_addr)
-	if position % 2 == 0:
-		return False
-	return True
+    print_entries(iomem[0])
 
-def is_persistent_mem(phys_addr):
-	position = bisect.bisect(pmem, phys_addr)
-	if position % 2 == 0:
-		return False
-	return True
+def trace_begin():
+    parse_iomem()
 
-def find_memory_type(phys_addr):
-	if phys_addr == 0:
-		return "N/A"
-	if is_system_ram(phys_addr):
-		return "System RAM"
+def trace_end():
+    print_memory_type()
 
-	if is_persistent_mem(phys_addr):
-		return "Persistent Memory"
+def process_event(param_dict):
+    if "sample" not in param_dict:
+        return
 
-	#slow path, search all
-	f.seek(0, 0)
-	for j in f:
-		m = re.split('-|:',j,2)
-		if int(m[0], 16) <= phys_addr <= int(m[1], 16):
-			return m[2]
-	return "N/A"
+    sample = param_dict["sample"]
+    if "phys_addr" not in sample:
+        return
 
-def process_event(param_dict):
-	name       = param_dict["ev_name"]
-	sample     = param_dict["sample"]
-	phys_addr  = sample["phys_addr"]
+    phys_addr  = sample["phys_addr"]
+    entry = find_memory_type(phys_addr)
+    if entry:
+        load_mem_type_cnt[entry] += 1
 
-	global event_name
-	if event_name == None:
-		event_name = name
-	load_mem_type_cnt[find_memory_type(phys_addr)] += 1
+    global event_name
+    if event_name is None:
+        event_name  = param_dict["ev_name"]
-- 
2.47.0.338.g60cca15819-goog

