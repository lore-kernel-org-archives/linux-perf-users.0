Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DE3D79EF
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881791; cv=none; b=gdgyj2xxi3p8P3t/DYcJpItK+InUaHfmKUWLHHHdxTA+ynIwOlPzIOP/d/FUcXA7e9YKIBS36Vqm6adp/VgbHFTRXLUnvvMD7OC5OsRPZd27mm5QKKUOPJ02ovlpwensWNgQSIiUjQf1HmWR8DgycAR9zsxQxIPbg1sKDVM8QR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881791; c=relaxed/simple;
	bh=IbC2/Uv+OwgNdsUSxVe0dDSD6YkupNM+8CS/sKKIkn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dtNOl27k46pcGLUm8ByC/c3PRyuCrBqEMgjdIyngfoWGF1ovfQv1TBg9Y89uSLv+BQTq6iRbaVctl1AnVZie7jsUnDPQL2cU84wpEgfSrihdroMUTNwIAO0uGdEtC5DZn0UeYW57yWu63gOj5kuVo3MGjp7emUvKsj567Go1AQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfdJ1Sjn; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfdJ1Sjn"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-395543dc382so2583865a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881788; x=1790486588; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RImjqQxLqE917MV39LXvpY8Ea24gVcGwCxa1lmYyuM=;
        b=hfdJ1SjnxyGZHnnBr/gP0zyU3igI8g0oyr/LEwpmbtakDCEZJlM3+UVy8zx/kIA7as
         DAYp40JPVSzUFVDBMSlRF6MY2LPkuuudGSLqUO2MGsiPDQREjkxrPiY4Tl4sQmwtzaNn
         brYKgB6Oj+7fV544WRwvn2Vjm4PSWM19Owmu8HuzoBJshed04nmkR0H1UTapEm+fQZw3
         uYDnlIMmAzxCbpOyic45nnua2A1mA2IXZAgmqGRaYQG5YyAaofWpfzT4owwJGqQ+gGj5
         IRf6OsXVXfR0WWPcm+6RZQW79vnprybgamnyYS+4avGKhWsg9Fju4xb3EJrvYQJU3i+c
         Wgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881788; x=1790486588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RImjqQxLqE917MV39LXvpY8Ea24gVcGwCxa1lmYyuM=;
        b=FqyM7haM5BRGr0U3OCGeSOz6ch7N8YzbTBZ3edfNQ5qLX4pz6eh7Z8ZyQ2DETwsdZM
         zh38/L/O2dgz8QygbfrWASJP6qAzOKtCNWqcBBhhMcpXB3kUNyFgvevYb4S1Wq1WL+/W
         EznkCwCgASaHHzATz42Pm5luVnKL/Xkk4/bm+c5CUOop9kMjmePNSKogBFKfLi8LAsPa
         ITSqtbGFIlZdP8kIdmUmau28IhRBOORzxXLHXINcwVGbCP6hhfjWhn+p3xSVEKs8vtB6
         HCmRZ+iJwkgtJxQ5+c/gQZFoPsDzBJpDIh4sFj20UKUXX16GHZWRXA5ocs19ThL/l7bk
         nkxg==
X-Forwarded-Encrypted: i=1; AKwUvBwS/DzDfaTA5lQW7XFGT/EYCLLizuSkaa6Z6bVgK2qcP+hvpJDpzuMcCgqU9hT+Dd5ytdzHPWQSV7+9FvtczQQf@vger.kernel.org
X-Gm-Message-State: AFuF++mmMzq9AcjAUXYWRzD2wH9GKkqqozs7JTz19zj5wIU9MgG9ApSJ
	5VlUN8tiEe7LuSJuu1AaAiRjfXhBjAWEIEiIN1CJRkC4bR+AsCbsKyyp0y3FyVcW52/5boOE1ol
	reuA4n82zEg==
X-Received: from dlec3-n2.prod.google.com ([2002:a05:701b:4283:20b0:144:dcec:b12a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d47:b0:39d:eac2:7bb1
 with SMTP id 98e67ed59e1d1-39e54ce1695mr18577371a91.4.1789881788036; Sat, 19
 Sep 2026 22:23:08 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:09 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <48bc7067e83cf9b5f3d619e0ee0ff636fa8d151d.1789880842.git.irogers@google.com>
Subject: [PATCH v1 17/49] perf python: Port mem-phys-addr to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port mem-phys-addr.py to a standalone script in tools/perf/python/
using the perf.session API to read perf.data files and profile physical
memory access types against /proc/iomem.

Improvements compared to the legacy script:
- Parse the full indentation hierarchy of /proc/iomem into a parent-child
  tree of frozen IomemEntry dataclasses (instead of only top-level
  indent-0 ranges), resolving physical addresses to the most specific
  sub-range (such as Kernel code/data/bss inside System RAM) and rolling
  child counts up into parent totals.
- Support profiling multiple memory events in a single perf.data session
  (keyed by evsel name) instead of assuming a single global event.
- Add argparse CLI options (-i/--input and --iomem to allow supplying an
  offline /proc/iomem snapshot from a target system).

Add a shell test (test_mem_phys_addr_python.sh) to verify the standalone
script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/mem-phys-addr.py            | 137 ++++++++++++++++++
 .../tests/shell/test_mem_phys_addr_python.sh  | 101 +++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100755 tools/perf/python/mem-phys-addr.py
 create mode 100755 tools/perf/tests/shell/test_mem_phys_addr_python.sh

diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-phys-addr.py
new file mode 100755
index 000000000000..5064e673c6a2
--- /dev/null
+++ b/tools/perf/python/mem-phys-addr.py
@@ -0,0 +1,137 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""mem-phys-addr.py: Resolve physical address samples"""
+from __future__ import annotations
+import argparse
+import bisect
+import collections
+from dataclasses import dataclass
+import re
+from typing import (Dict, List, Optional)
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
+    def __lt__(self, other) -> bool:
+        if isinstance(other, int):
+            return self.begin < other
+        return self.begin < other.begin
+
+    def __gt__(self, other) -> bool:
+        if isinstance(other, int):
+            return self.begin > other
+        return self.begin > other.begin
+
+# Physical memory layout from /proc/iomem. Key is the indent and then
+# a list of ranges.
+iomem: Dict[int, List[IomemEntry]] = collections.defaultdict(list)
+# Child nodes from the iomem parent.
+children: Dict[IomemEntry, List[IomemEntry]] = collections.defaultdict(list)
+# Maximum indent seen before an entry in the iomem file.
+_STATE: Dict[str, int] = {"max_indent": 0}
+# Per-event counts for each range of memory.
+event_counts: Dict[str, collections.Counter] = collections.defaultdict(collections.Counter)
+
+def parse_iomem(iomem_path: str):
+    """Populate iomem from iomem file"""
+    with open(iomem_path, 'r', encoding='ascii') as f:
+        for line in f:
+            line = line.rstrip('\n')
+            if not line or line.isspace():
+                continue
+            indent = 0
+            while indent < len(line) and line[indent] == ' ':
+                indent += 1
+            _STATE["max_indent"] = max(_STATE["max_indent"], indent)
+            m = re.split('-|:', line, maxsplit=2)
+            if len(m) < 3:
+                continue
+            begin = int(m[0].strip(), 16)
+            end = int(m[1].strip(), 16)
+            label = m[2].strip()
+            entry = IomemEntry(begin, end, indent, label)
+            # Before adding entry, search for a parent node using its begin.
+            if indent > 0:
+                parent = find_memory_type(begin)
+                assert parent, f"Given indent expected a parent for {label}"
+                children[parent].append(entry)
+            iomem[indent].append(entry)
+
+def find_memory_type(phys_addr) -> Optional[IomemEntry]:
+    """Search iomem for the range containing phys_addr with the maximum indent"""
+    for i in range(_STATE["max_indent"], -1, -1):
+        if i not in iomem:
+            continue
+        position = bisect.bisect_right(iomem[i], phys_addr)
+        if position == 0:
+            continue
+        iomem_entry = iomem[i][position-1]
+        if  iomem_entry.begin <= phys_addr <= iomem_entry.end:
+            return iomem_entry
+    return None
+
+def _print_entries(entries, load_mem_type_cnt, total):
+    """Print counts from parents down to their children"""
+    for entry in sorted(entries,
+                        key=lambda e: (load_mem_type_cnt[e], e.begin),
+                        reverse=True):
+        count = load_mem_type_cnt[entry]
+        if count > 0:
+            mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
+            percent = 100 * count / total
+            print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
+            _print_entries(children[entry], load_mem_type_cnt, total)
+
+def print_memory_type():
+    """Print the resolved memory types and their counts."""
+    if not event_counts:
+        print("No valid physical address samples found in perf data.")
+        return
+
+    for event_name, load_mem_type_cnt in event_counts.items():
+        print(f"Event: {event_name}")
+        print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
+        print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
+        total = sum(load_mem_type_cnt.values())
+        if total == 0:
+            continue
+
+        # Add count from children into the parent.
+        for i in range(_STATE["max_indent"], -1, -1):
+            if i not in iomem:
+                continue
+            for entry in iomem[i]:
+                for child in children[entry]:
+                    if load_mem_type_cnt[child] > 0:
+                        load_mem_type_cnt[entry] += load_mem_type_cnt[child]
+
+        _print_entries(iomem[0], load_mem_type_cnt, total)
+        print()
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Resolve physical address samples")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("--iomem", default="/proc/iomem", help="Path to iomem file")
+    args = ap.parse_args()
+
+    def process_event(sample):
+        """Process a single sample event."""
+        phys_addr = sample.sample_phys_addr or 0
+        if not phys_addr:
+            return
+        entry = find_memory_type(phys_addr)
+        if entry:
+            event_name = str(sample.evsel)
+            if event_name.startswith("evsel(") and event_name.endswith(")"):
+                event_name = event_name[6:-1]
+            event_counts[event_name][entry] += 1
+
+    parse_iomem(args.iomem)
+    perf.session(perf.data(args.input), sample=process_event).process_events()
+    print_memory_type()
diff --git a/tools/perf/tests/shell/test_mem_phys_addr_python.sh b/tools/perf/tests/shell/test_mem_phys_addr_python.sh
new file mode 100755
index 000000000000..ae2f2fba0d20
--- /dev/null
+++ b/tools/perf/tests/shell/test_mem_phys_addr_python.sh
@@ -0,0 +1,101 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# mem-phys-addr python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# If we don't have the perf python module, we can't test
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/mem-phys-addr.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, mem-phys-addr.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_iomem=""
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_iomem}" "${temp_out}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_iomem=$(mktemp /tmp/perf.iomem.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+cat << 'EOF' > "${temp_iomem}"
+00000000-ffffffffffffffff : System RAM
+  00000000-7fffffffffffffff : Low RAM
+    00001000-00ffffff : Kernel code
+  8000000000000000-ffffffffffffffff : High RAM
+EOF
+
+test_iomem_hierarchy() {
+	echo "Testing mem-phys-addr.py hierarchical iomem resolution..."
+	"$PYTHON" - "$script_path" "${temp_iomem}" << 'PYEOF' > "${temp_out}"
+import importlib.util
+import sys
+
+spec = importlib.util.spec_from_file_location("mem_phys_addr", sys.argv[1])
+mod = importlib.util.module_from_spec(spec)
+sys.modules[spec.name] = mod
+spec.loader.exec_module(mod)
+
+mod.parse_iomem(sys.argv[2])
+entry_kernel = mod.find_memory_type(0x100000)
+entry_high = mod.find_memory_type(0x9000000000000000)
+assert entry_kernel is not None and entry_kernel.label == "Kernel code"
+assert entry_high is not None and entry_high.label == "High RAM"
+mod.event_counts["cpu/mem-loads/"][entry_kernel] += 3
+mod.event_counts["cpu/mem-loads/"][entry_high] += 1
+mod.print_memory_type()
+PYEOF
+	if ! grep -q "System RAM" "${temp_out}" || \
+	   ! grep -q "Kernel code" "${temp_out}" || \
+	   ! grep -q "High RAM" "${temp_out}"; then
+		echo "Hierarchical iomem resolution test failed."
+		err=1
+	else
+		echo "Hierarchical iomem resolution test passed."
+	fi
+}
+
+test_file_mode() {
+	echo "Testing mem-phys-addr.py file mode..."
+
+	# Generate memory access events (try unprivileged user-space first, then system-wide)
+	if ! perf record --phys-data -d -o "${temp_data}" \
+	     -- perf test -w datasym >/dev/null 2>&1 && \
+	   ! perf record -d -o "${temp_data}" -- perf test -w datasym >/dev/null 2>&1 && \
+	   ! perf record -d -a -o "${temp_data}" -- sleep 0.2 >/dev/null 2>&1; then
+		echo "Skipping file mode record test, perf record -d not supported"
+		return 0
+	fi
+
+	# Run the script with custom --iomem
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" --iomem "${temp_iomem}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+}
+
+test_iomem_hierarchy
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

