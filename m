Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7E3AD51A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960682; cv=none; b=pJzt3T7uLCERQ/14T9Meys7lFn9xSBCbV8n1b2BUEerEBsK7qkYO1fY1t3Zm5pMIoqZURJzxaZIlp5BGLzQR9cVih/S3m0hWLR6h3MXWsZTZ7YCjP4q5TSuM7sHsNtI43ApFnnp7mhTqwnm31EXjbGE03Cc9Xh8H/lQP3RPjYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960682; c=relaxed/simple;
	bh=rgCtTOdXZVYAPF9tkd0JdLzgPtZJOxjCBPdq8Gqs+jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTmKRjbw035B5fDmMspGvz5RLAd56AuxqQTdK619/ys4zRuEXaJQ8Q98S5rMP9pYk3eLBeCR7zwKln0J0Qriskt0lqRdqOfoP2jBS12RtBR+GdPAHsUDjNfG2r8/9cIt8OeYwmt7Yyf6MSlfOOBAB+geRlTphJJ1LQrem/qQfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wf6BtR++; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wf6BtR++"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so9337937eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960679; x=1777565479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0vYcuIPaUT62grwux2K/MvuTZWtTmTnEtepKAjSqVQ=;
        b=Wf6BtR++okqpgsRdrD0F9PPIhtSCHeQCpM+gMakkU48Cw6AI1IZlRRpmA1g+bSakHx
         tUdhjJsAfuRrJCHQLa4jyLXpPwHQaJ05wc5tZvkjFrK+nKkmWmem+4vAsLiva/5VujqC
         ommOsKuDryz9i1z1hMICRErnGlosqvT6jF6kVIv81lIhl9djgkdRUnBqcrTK0SUq5bKv
         8xW6TZIKbjFDJv5Mii3qrEA5rq8WC8COptSkowwZgMiyX1vswjNEqWRLwneHC08qFOSE
         p22wmsydPMk9+gphl9k0EC3n+jC375ebbXC/xzIUcVnNWZjfB441uwd0mgPJDIvUmkr7
         p3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960679; x=1777565479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0vYcuIPaUT62grwux2K/MvuTZWtTmTnEtepKAjSqVQ=;
        b=YOILaeyjf40jVD2Biww3xSpTptpz78Izk5opHFdgTAexzKO4VpeuunXVODnD4MjgGb
         fcjBWvYRv9YIuu4MGUsEWyC2M1Wc6q0Ps7YbXOQ+0sbL+uvSZirLNILwu4q+YXjpj62R
         i4HJ8E+mdvnx4uxnkvYO6rO5bza/UrfTuG+wF6AR6+3TApd4LKSHNV8fq01Jkm0g8uxd
         h9dhqEDqcgRaUwdPpFtTOTDAUOSzDpITNRsU6dJSSaLZZJhfujVHOud3kb9zjB+7uf6P
         NGjQqy+6s4atEaJb+M88efpi3K91gAxwVZs+fmoj3pGs5sB1JoB4TMsK7wWyxZQcqbu2
         UkjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/S1bFgW+B2n3pKAvLeMlr+bIMFrRyuTHCb+pKpz3uvJy6uVOH1D478+rVq9h2P/i7JTueMXBc+vLO3+b2wa6X/@vger.kernel.org
X-Gm-Message-State: AOJu0YztmWi/f1zMvsRx9V1I2AEDvRPZxP8UPAul/3eBnEs/2gKIHf/k
	hphyrHB5ziuApkldKaCqy1XFkjz4+NJb+0rHPzGGZKQi3bkJCsT1c1J+vl0KdUEYOZj+9eLfoXT
	bh4C692CkZw==
X-Received: from dlbpv4.prod.google.com ([2002:a05:7023:904:b0:12d:b3cc:a807])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f016:b0:128:d7a7:5271
 with SMTP id a92af1059eb24-12c73fa91f0mr13403533c88.28.1776960678745; Thu, 23
 Apr 2026 09:11:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:40 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-34-irogers@google.com>
Subject: [PATCH v3 33/58] perf compaction-times: Port compaction-times to use
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

Add a port of the compaction-times script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Fixed Closure Call: Changed cls.fobj.filter(pid, comm) to
    cls.fobj(pid, comm) . Since fobj is a function (closure) and not a
    class instance, calling .filter() on it would raise an
    AttributeError .
---
 tools/perf/python/compaction-times.py | 326 ++++++++++++++++++++++++++
 1 file changed, 326 insertions(+)
 create mode 100755 tools/perf/python/compaction-times.py

diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/compaction-times.py
new file mode 100755
index 000000000000..153b47930e3c
--- /dev/null
+++ b/tools/perf/python/compaction-times.py
@@ -0,0 +1,326 @@
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
+    high = 0 if high_str == "" else int(high_str)
+
+    def filter_func(pid: int, _comm: str) -> bool:
+        return not (pid >= low and (high == 0 or pid <= high))
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
+    pid = sample.sample_pid
+    comm = session.process(pid).comm() if session else "[unknown]"
+    secs = sample.sample_time // 1000000000
+    nsecs = sample.sample_time % 1000000000
+
+    if "evsel(compaction:mm_compaction_begin)" in event_name:
+        Chead.create_pending(pid, comm, secs, nsecs)
+    elif "evsel(compaction:mm_compaction_end)" in event_name:
+        Chead.complete_pending(pid, secs, nsecs)
+    elif "evsel(compaction:mm_compaction_migratepages)" in event_name:
+        Chead.increment_pending(pid, Pair(sample.nr_migrated, sample.nr_failed), None, None)
+    elif "evsel(compaction:mm_compaction_isolate_freepages)" in event_name:
+        Chead.increment_pending(pid, None, Pair(sample.nr_scanned, sample.nr_taken), None)
+    elif "evsel(compaction:mm_compaction_isolate_migratepages)" in event_name:
+        Chead.increment_pending(pid, None, None, Pair(sample.nr_scanned, sample.nr_taken))
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
-- 
2.54.0.rc2.533.g4f5dca5207-goog

