Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BC37D130
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967307; cv=none; b=Aao7aQA/e5ZB/zW5cpf7OiqEHyE7PmGvhiNBSJVJ90xhRQPoRpXkZPVo71UAnH1SO4kou4BRk20MMJtZ7Ptjbk+H5sTgW2SWzsM8d+o4S+GZ97UD1vjXyhnQm00DRO5/S0/A7BSpdlbhGv9zM90bWXVQ582d4QgeIvasDNh7m2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967307; c=relaxed/simple;
	bh=tZpVnMgu6Lx2kDzVNyUTHY4Qq+PP3iuDHRLcS0PBQK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IvDCeUAcnfaqVePCXiPsme+Y/wEx1+HuCTHjz8xfLi8TwS1PIwD/f0GseHKYt3zwR8RldUeK1uHkmitN1sfD1eX/HGBFiMr59Dqu2WJb87twI7/mwXN+TElJb/P1uTTGaXutPSd12DScx7Fm79/peme+/jTsL0XA5BwV/SXZ2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbbDUz6C; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbbDUz6C"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so4878349a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967303; x=1790572103; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T1iECqO7ug3nMIoVu5+g1cS6NeZWyO6nDptzxPJ4dR8=;
        b=rbbDUz6CPJ0s8opm5D+8RqxJy5DOyFfj5AKksjXqlK/i+v/pLonenl7T6LhB6aRezU
         BafsqCUWECySQatQQRMJJ7QYELosCQXLMcUWhg4KmVA2+sOaT741Z75bVhfFey/KSVLH
         msU70IspneeQgoA15bnMvehsZPq4UNTvYMlHOxcJ1JF1o6fVYI8BaQTHTCiCsy9B/fsI
         JUCSozyow2KTbzIcOgQ5LG03aLTy3LuuTNzJqrXxYxXOwVhDnRsxfjQFn3eLJFUFfPkQ
         a5VHgOAingHdMvlz1YpHBZGMX8mJ5SayL+UJta4jBITYGA5yFhA/6cHrBJMMhqVY7wH4
         hVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967303; x=1790572103;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1iECqO7ug3nMIoVu5+g1cS6NeZWyO6nDptzxPJ4dR8=;
        b=zjSyeqWtIfvSxcbkWDGGHDlWWP7CC17PEtSBIdW+dODWAD3GoX+OUG7kOedBmoBo7O
         vX38P4x6Yrm1vhkOUtGyOI2Z92RimFsAaG5CXv1tym3x5D+4XEYer+uvTQDff0Fc7pGX
         RpZ4cSF6u548lEjfA5Tr6XbagKhyfqAnS291fXwP5oPUh0uiJcbBSLzxNrBQhVAGbP37
         ifJco3AEC3RVA0122TAKtoJGXt9jGqPFAMTBTQrClqjuFynwAO08bybFLdf2OHz5DVay
         i3ZJB8n9/OJYOz+/QxyI+WLaSSgvHmEtr4MU4EVyhyjfJMMuS88ScFnF59ZpRgzj7O4L
         3/fg==
X-Forwarded-Encrypted: i=1; AKwUvBxOrwWWP67YoZb+cGFJF08SvR3ZJu/3r3J2+cGTRp/b9AV/VUnut85X+VnF8B/uAJJLQP055KHWOxyN8b0RVpor@vger.kernel.org
X-Gm-Message-State: AFuF++kM2zIDq/TSH6EMyJ2R/34slesgj3svq5tX3Jrsba/SnbfWi5mO
	j/W/fx5i0LGbf0ViciwhyjNnR7Fd7pIIuAAE7oCvgEP/R/0Pr1hN4zqcrlBuvIgT9gU+MFdkYLx
	QY4y98rG6uw==
X-Received: from dlbbu39.prod.google.com ([2002:a05:7022:2227:b0:144:c6ad:5b30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dce:b0:39d:f064:3a68
 with SMTP id 98e67ed59e1d1-39e54d36e3emr16157354a91.21.1789967303007; Sun, 20
 Sep 2026 22:08:23 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:52 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <f0f213baa26426d26a0254497c140546d81542c8.1789966896.git.irogers@google.com>
Subject: [PATCH v2 34/49] perf python: Port compaction-times to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port compaction-times.py to a standalone script in tools/perf/python/
using the perf module directly to analyze mm_compaction tracepoints.

Improvements compared to the legacy script:
- Replace Python 2 constructs (such as sys.maxint and raw integer
  bitmasks) with Python 3 enum.IntEnum (Popt) and enum.IntFlag (Topt)
  types.
- Access tracepoint fields directly on perf.sample_event and add
  -i/--input CLI option support via argparse.
- Add full type annotations passing mypy and pylint without suppression
  comments.

Add a shell test (test_compaction_times_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/compaction-times.py         | 350 ++++++++++++++++++
 .../shell/test_compaction_times_python.sh     |  81 ++++
 2 files changed, 431 insertions(+)
 create mode 100755 tools/perf/python/compaction-times.py
 create mode 100755 tools/perf/tests/shell/test_compaction_times_python.sh

diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/compaction-times.py
new file mode 100755
index 000000000000..d17cd51a320b
--- /dev/null
+++ b/tools/perf/python/compaction-times.py
@@ -0,0 +1,350 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Report time spent in memory compaction.
+
+Memory compaction is a feature in the Linux kernel that defragments memory
+by moving used pages to create larger contiguous blocks of free memory. This
+is particularly useful for allocating huge pages.
+
+This script processes trace events related to memory compaction and reports:
+- Total time spent in compaction (stall time).
+- Statistics for page migration (moved vs. failed).
+- Statistics for the free scanner (scanned vs. isolated pages).
+- Statistics for the migration scanner (scanned vs. isolated pages).
+
+Definitions:
+- **Compaction**: Defragmenting memory by moving allocated pages.
+- **Migration**: Moving pages from their current location to free pages found by the free scanner.
+- **Free Scanner**: Scans memory (typically from the end of a zone) to find free pages.
+- **Migration Scanner**: Scans memory (typically from the beginning of a zone)
+  to find pages to move.
+- **Isolated Pages**: Pages that have been temporarily removed from the buddy
+  system for migration or as migration targets.
+
+Ported from tools/perf/scripts/python/compaction-times.py to the modern perf Python module.
+"""
+from __future__ import annotations
+
+import argparse
+import enum
+import re
+import sys
+from typing import Callable, Dict, List, Optional, Any
+import perf
+
+class Popt(enum.IntEnum):
+    """Process display options."""
+    DISP_DFL = 0
+    DISP_PROC = 1
+    DISP_PROC_VERBOSE = 2
+
+class Topt(enum.IntFlag):
+    """Trace display options."""
+    DISP_TIME = 0
+    DISP_MIG = 1
+    DISP_ISOLFREE = 2
+    DISP_ISOLMIG = 4
+    DISP_ALL = DISP_MIG | DISP_ISOLFREE | DISP_ISOLMIG
+
+# Globals to satisfy pylint when accessed in functions before assignment in main.
+OPT_NS = True
+opt_disp = Topt.DISP_ALL
+opt_proc = Popt.DISP_DFL
+session = None
+
+def get_comm_filter(regex: re.Pattern) -> Callable[[int, str], bool]:
+    """Returns a filter function based on command regex."""
+    def filter_func(_pid: int, comm: str) -> bool:
+        regex_match = regex.search(comm)
+        return regex_match is None or regex_match.group() == ""
+    return filter_func
+
+def get_pid_filter(low_str: str, high_str: str) -> Callable[[int, str], bool]:
+    """Returns a filter function based on PID range."""
+    low = 0 if low_str == "" else int(low_str)
+    high = None if high_str == "" else int(high_str)
+
+    def filter_func(pid: int, _comm: str) -> bool:
+        return not (pid >= low and (high is None or pid <= high))
+    return filter_func
+
+def ns_to_time(ns: int) -> str:
+    """Format nanoseconds to string based on options."""
+    return f"{ns}ns" if OPT_NS else f"{round(ns, -3) // 1000}us"
+
+class Pair:
+    """Represents a pair of related counters (e.g., scanned vs isolated, moved vs failed)."""
+    def __init__(self, aval: int, bval: int,
+                 alabel: Optional[str] = None, blabel: Optional[str] = None):
+        self.alabel = alabel
+        self.blabel = blabel
+        self.aval = aval
+        self.bval = bval
+
+    def __add__(self, rhs: 'Pair') -> 'Pair':
+        return Pair(self.aval + rhs.aval, self.bval + rhs.bval, self.alabel, self.blabel)
+
+    def __iadd__(self, rhs: 'Pair') -> 'Pair':
+        self.aval += rhs.aval
+        self.bval += rhs.bval
+        return self
+
+    def __str__(self) -> str:
+        return f"{self.alabel}={self.aval} {self.blabel}={self.bval}"
+
+class Cnode:
+    """Holds statistics for a single compaction event or an aggregated set of events."""
+    def __init__(self, ns: int):
+        self.ns = ns
+        self.migrated = Pair(0, 0, "moved", "failed")
+        self.fscan = Pair(0, 0, "scanned", "isolated")
+        self.mscan = Pair(0, 0, "scanned", "isolated")
+
+    def __add__(self, rhs: 'Cnode') -> 'Cnode':
+        res = Cnode(self.ns + rhs.ns)
+        res.migrated = self.migrated + rhs.migrated
+        res.fscan = self.fscan + rhs.fscan
+        res.mscan = self.mscan + rhs.mscan
+        return res
+
+    def __iadd__(self, rhs: 'Cnode') -> 'Cnode':
+        self.ns += rhs.ns
+        self.migrated += rhs.migrated
+        self.fscan += rhs.fscan
+        self.mscan += rhs.mscan
+        return self
+
+    def __str__(self) -> str:
+        prev = False
+        s = f"{ns_to_time(self.ns)} "
+        if opt_disp & Topt.DISP_MIG:
+            s += f"migration: {self.migrated}"
+            prev = True
+        if opt_disp & Topt.DISP_ISOLFREE:
+            s += f"{' ' if prev else ''}free_scanner: {self.fscan}"
+            prev = True
+        if opt_disp & Topt.DISP_ISOLMIG:
+            s += f"{' ' if prev else ''}migration_scanner: {self.mscan}"
+        return s
+
+    def complete(self, secs: int, nsecs: int) -> None:
+        """Complete the node with duration."""
+        self.ns = (secs * 1000000000 + nsecs) - self.ns
+
+    def increment(self, migrated: Optional[Pair], fscan: Optional[Pair],
+                  mscan: Optional[Pair]) -> None:
+        """Increment statistics."""
+        if migrated is not None:
+            self.migrated += migrated
+        if fscan is not None:
+            self.fscan += fscan
+        if mscan is not None:
+            self.mscan += mscan
+
+class Chead:
+    """Aggregates compaction statistics per process (PID) and maintains total statistics."""
+    heads: Dict[int, 'Chead'] = {}
+    val = Cnode(0)
+    fobj: Optional[Any] = None
+
+    @classmethod
+    def add_filter(cls, fobj: Any) -> None:
+        """Add a filter object."""
+        cls.fobj = fobj
+
+    @classmethod
+    def create_pending(cls, pid: int, comm: str, start_secs: int, start_nsecs: int) -> None:
+        """Create a pending node for a process."""
+        filtered = False
+        try:
+            head = cls.heads[pid]
+            filtered = head.is_filtered()
+        except KeyError:
+            if cls.fobj is not None:
+                filtered = cls.fobj(pid, comm)
+            head = cls.heads[pid] = Chead(comm, pid, filtered)
+
+        if not filtered:
+            head.mark_pending(start_secs, start_nsecs)
+
+    @classmethod
+    def increment_pending(cls, pid: int, migrated: Optional[Pair],
+                          fscan: Optional[Pair], mscan: Optional[Pair]) -> None:
+        """Increment pending stats for a process."""
+        if pid not in cls.heads:
+            return
+        head = cls.heads[pid]
+        if not head.is_filtered():
+            if head.is_pending():
+                head.do_increment(migrated, fscan, mscan)
+            else:
+                sys.stderr.write(f"missing start compaction event for pid {pid}\n")
+
+    @classmethod
+    def complete_pending(cls, pid: int, secs: int, nsecs: int) -> None:
+        """Complete pending stats for a process."""
+        if pid not in cls.heads:
+            return
+        head = cls.heads[pid]
+        if not head.is_filtered():
+            if head.is_pending():
+                head.make_complete(secs, nsecs)
+            else:
+                sys.stderr.write(f"missing start compaction event for pid {pid}\n")
+
+    @classmethod
+    def gen(cls):
+        """Generate heads for display."""
+        if opt_proc != Popt.DISP_DFL:
+            yield from cls.heads.values()
+
+    @classmethod
+    def get_total(cls) -> Cnode:
+        """Get total statistics."""
+        return cls.val
+
+    def __init__(self, comm: str, pid: int, filtered: bool):
+        self.comm = comm
+        self.pid = pid
+        self.val = Cnode(0)
+        self.pending: Optional[Cnode] = None
+        self.filtered = filtered
+        self.list: List[Cnode] = []
+
+    def mark_pending(self, secs: int, nsecs: int) -> None:
+        """Mark node as pending."""
+        self.pending = Cnode(secs * 1000000000 + nsecs)
+
+    def do_increment(self, migrated: Optional[Pair], fscan: Optional[Pair],
+                     mscan: Optional[Pair]) -> None:
+        """Increment pending stats."""
+        if self.pending is not None:
+            self.pending.increment(migrated, fscan, mscan)
+
+    def make_complete(self, secs: int, nsecs: int) -> None:
+        """Make pending stats complete."""
+        if self.pending is not None:
+            self.pending.complete(secs, nsecs)
+            Chead.val += self.pending
+
+            if opt_proc != Popt.DISP_DFL:
+                self.val += self.pending
+
+                if opt_proc == Popt.DISP_PROC_VERBOSE:
+                    self.list.append(self.pending)
+            self.pending = None
+
+    def enumerate(self) -> None:
+        """Enumerate verbose stats."""
+        if opt_proc == Popt.DISP_PROC_VERBOSE and not self.is_filtered():
+            for i, pelem in enumerate(self.list):
+                sys.stdout.write(f"{self.pid}[{self.comm}].{i+1}: {pelem}\n")
+
+    def is_pending(self) -> bool:
+        """Check if node is pending."""
+        return self.pending is not None
+
+    def is_filtered(self) -> bool:
+        """Check if node is filtered."""
+        return self.filtered
+
+    def display(self) -> None:
+        """Display stats."""
+        if not self.is_filtered():
+            sys.stdout.write(f"{self.pid}[{self.comm}]: {self.val}\n")
+
+def trace_end() -> None:
+    """Called at the end of trace processing."""
+    sys.stdout.write(f"total: {Chead.get_total()}\n")
+    for i in Chead.gen():
+        i.display()
+        i.enumerate()
+
+def process_event(sample: perf.sample_event) -> None:
+    """Callback for processing events."""
+    event_name = str(sample.evsel)
+    pid = sample.sample_tid
+    comm = "[unknown]"
+    try:
+        if session:
+            thread = session.find_thread(pid)
+            if thread:
+                comm = thread.comm() or "[unknown]"
+    except (TypeError, AttributeError):
+        pass
+    secs = sample.sample_time // 1000000000
+    nsecs = sample.sample_time % 1000000000
+
+    if "evsel(compaction:mm_compaction_begin)" in event_name:
+        Chead.create_pending(pid, comm, secs, nsecs)
+    elif "evsel(compaction:mm_compaction_end)" in event_name:
+        Chead.complete_pending(pid, secs, nsecs)
+    elif "evsel(compaction:mm_compaction_migratepages)" in event_name:
+        nr_migrated = getattr(sample, "nr_migrated", 0)
+        nr_failed = getattr(sample, "nr_failed", 0)
+        Chead.increment_pending(pid, Pair(nr_migrated, nr_failed), None, None)
+    elif "evsel(compaction:mm_compaction_isolate_freepages)" in event_name:
+        nr_scanned = getattr(sample, "nr_scanned", 0)
+        nr_taken = getattr(sample, "nr_taken", 0)
+        Chead.increment_pending(pid, None, Pair(nr_scanned, nr_taken), None)
+    elif "evsel(compaction:mm_compaction_isolate_migratepages)" in event_name:
+        nr_scanned = getattr(sample, "nr_scanned", 0)
+        nr_taken = getattr(sample, "nr_taken", 0)
+        Chead.increment_pending(pid, None, None, Pair(nr_scanned, nr_taken))
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Report time spent in compaction")
+    ap.add_argument("-p", action="store_true", help="display by process")
+    ap.add_argument("-pv", action="store_true", help="display by process (verbose)")
+    ap.add_argument("-u", action="store_true", help="display results in microseconds")
+    ap.add_argument("-t", action="store_true", help="display stall times only")
+    ap.add_argument("-m", action="store_true", help="display stats for migration")
+    ap.add_argument("-fs", action="store_true", help="display stats for free scanner")
+    ap.add_argument("-ms", action="store_true", help="display stats for migration scanner")
+    ap.add_argument("filter", nargs="?", help="pid|pid-range|comm-regex")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    opt_proc = Popt.DISP_DFL
+    if args.pv:
+        opt_proc = Popt.DISP_PROC_VERBOSE
+    elif args.p:
+        opt_proc = Popt.DISP_PROC
+
+    OPT_NS = not args.u
+
+    opt_disp = Topt.DISP_ALL
+    if args.t or args.m or args.fs or args.ms:
+        opt_disp = Topt(0)
+        if args.t:
+            opt_disp |= Topt.DISP_TIME
+        if args.m:
+            opt_disp |= Topt.DISP_MIG
+        if args.fs:
+            opt_disp |= Topt.DISP_ISOLFREE
+        if args.ms:
+            opt_disp |= Topt.DISP_ISOLMIG
+
+    if args.filter:
+        PID_PATTERN = r"^(\d*)-(\d*)$|^(\d*)$"
+        pid_re = re.compile(PID_PATTERN)
+        match = pid_re.search(args.filter)
+        filter_obj: Any = None
+        if match is not None and match.group() != "":
+            if match.group(3) is not None:
+                filter_obj = get_pid_filter(match.group(3), match.group(3))
+            else:
+                filter_obj = get_pid_filter(match.group(1), match.group(2))
+        else:
+            try:
+                comm_re = re.compile(args.filter)
+            except re.error:
+                sys.stderr.write(f"invalid regex '{args.filter}'\n")
+                sys.exit(1)
+            filter_obj = get_comm_filter(comm_re)
+        Chead.add_filter(filter_obj)
+
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    trace_end()
diff --git a/tools/perf/tests/shell/test_compaction_times_python.sh b/tools/perf/tests/shell/test_compaction_times_python.sh
new file mode 100755
index 000000000000..80df5adc5bf6
--- /dev/null
+++ b/tools/perf/tests/shell/test_compaction_times_python.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# compaction-times python test
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
+if ! perf check feature -q libtraceevent; then
+	echo "Skipping test, perf built without libtraceevent"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/compaction-times.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, compaction-times.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+
+cleanup() {
+	rm -f "${temp_data}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+
+test_file_mode() {
+	echo "Testing compaction-times.py..."
+
+	# Check for any compaction events to see if kernel supports it
+	if ! perf list | grep -q "compaction:mm_compaction_begin"; then
+		echo "Skipping test, compaction tracepoints not found"
+		exit 2
+	fi
+
+	# Generate some events
+	# We might not naturally trigger compaction in 0.5s sleep, but the script
+	# should parse the empty or sparse file correctly without crashing.
+	if ! perf record -e "compaction:*" -a -o "${temp_data}" -- sleep 0.5 >/dev/null 2>&1; then
+		echo "Skipping test, perf record failed"
+		exit 2
+	fi
+
+	# Run the script with some filters to validate filtering logic
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" >/dev/null; then
+		echo "File mode default test failed."
+		err=1
+	fi
+
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" "0-0" >/dev/null; then
+		echo "File mode strict PID filter test failed."
+		err=1
+	fi
+
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" >/dev/null; then
+		echo "File mode comm filter test failed."
+		err=1
+	fi
+
+	if [ $err -eq 0 ]; then
+		echo "File mode test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

