Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFE39657D
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962115; cv=none; b=q/nFTXjVgZOg8UxQp222Juv5ivyGIMA6zSmZq08PNDlQuKYxUfa1bfFODVCkG8vCPIEBXV1wevzhyAjrCIqyXEPdENBI6V2z1pl1aw7FSaHEypNHV/cc7nBeRLsGXrCoxKRouySUF6R1X+NQuFQaS59vcQhvbfMN5ieJfWRXSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962115; c=relaxed/simple;
	bh=21yvkvvibRcBFyLCzkOEhs7yL1I2GHfegyLuugszGUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ulb8FQoaXJGekEqU2lcknrtLXV9Nlx+zB9stiQVY3ce+nnC1qofi6BQiDYHnuRNqxq7r/wRdpIEkYwC0FqxBp3HdjuJoGkb08PTmoBCo824EV9KNX9EDXXuCwtVaieS1+L3MCfvm9Gt9LHUXzP2sshDQyFRtqr2BLsFdMIMg6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrDY8+GG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrDY8+GG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2e60238adb1so14082090eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962113; x=1777566913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/UtXMyLWjYDcjA91HkS9s0ti5HVEoifX0Xw3V4fIII=;
        b=YrDY8+GGSXUVGRA6UB1dv5bSOsj9ypgbo1k/cOgwC7UX13sJ+TdEIkK6to0yW4UrNH
         OxkmpQo3MlhVSm36hVcS6TfI4aWRqx6bcI8Et6v5XhITsIU2mDePlyNzHzRlLOzpsJYd
         w3pboA2d9s/y5gCgElBD3WU3Q7V2o3fL/lv7qROqBHXzMNeo2Q1UwKUbSZsG/GahK9eR
         bWY1eU0Fo/s6lo3v/ADq8MjNnof6K9KzDLp7EfUuOlXcTEFNOjHupYmgLAepfawvG/pG
         dAddHqxLyy/epguVtbaaHFhyNXBvF9C9kxY0iXsUOKCRl8Fomf5UIMTGsbf2hQ76UX/O
         kBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962113; x=1777566913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/UtXMyLWjYDcjA91HkS9s0ti5HVEoifX0Xw3V4fIII=;
        b=mGJ50Qr4XXwZY8lWTBgfq2dCEXYWt/P7+Ay9ci1fAUWDxS8e7Rk8DYIvof2ugBL3TA
         xnVmuxGvtawTTMvvCvf0gErEVzkdbG4Jk/WMLZgKXAWpJ2X8DVIc4H3veJE5aP07ZPwR
         g/BZvN1Z/1XojFf37OQZyF94XSMWmBv9nmrpwjJvpNAKPSThu4baRCjzIPpz3QT93HN9
         YWjEAsaZpnMZRvfAFX0ZI3eYtS6RmPYU6UADf10b0a6lkaxm3ZvNJ9smPl6AnvE5YNBx
         fvzTV9yenLq7yzUcpHV53wMj8bMUxiCwstWsqIcY4k/BKS8sDvWe2rL/IdxJyL0EyvoO
         9KFA==
X-Forwarded-Encrypted: i=1; AFNElJ+NxCDqzRFNgBluu7ZFwUspwj5srTyHOifF+rI5G0QcQQQuAMrOtIl3kvDUA0QwcPaJwBUVOAPPbniwzWL8igoJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMv4k4m8CvqZS4d9BJRaj6p+epqQFwYifEfCIK+6HbRTBxmfag
	yR8DfytEy6WsCEDmOrcB2yEQj5oCffsp7ctOQLRn0X2KP1Vah9f1ivRapZpWaY7qGKNul9i6JbH
	47Jr8ybtXfg==
X-Received: from dycrm24.prod.google.com ([2002:a05:693c:2a18:b0:2d9:8328:8324])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f14d:b0:2ea:b7a9:580d
 with SMTP id 5a478bee46e88-2eab7a9593emr4347715eec.9.1776962112744; Thu, 23
 Apr 2026 09:35:12 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:34 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-27-irogers@google.com>
Subject: [PATCH v4 26/58] perf mem-phys-addr: Port mem-phys-addr to use python module
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

