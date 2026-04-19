Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421916DC28
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643242; cv=none; b=E7vOK+18acFoyY8epPvU3mCxbR9a4011xNMUsqwBeIH/wCP76JThQxzWoCPbcfgQ6x7dKJ7g6VXvShhIgf9yxO0Vz23EDJYd46dXS5T1l8BETVvw/6i5Evce4Sr38j40VMauS3zo3IkjrOmPejxE12zyAgqZthgQahO84h0HMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643242; c=relaxed/simple;
	bh=QOfaP93IMwUaPhqJu4UK8C3tsEfbNvw7xgiL+IxAMTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6kcq8B9radTVfrxLGcMh6Gdq1/YuiaGXMle/ZNBcQz6Cc7n+adEFRbrNdQw0zxM9uudLh0XTFp/qmnpXcc8YMamKeyy0XeT5Sl6ZSN3zEzk9ElQqnPsKtnS0gnRwTBibywKc/v6HHvaOx7CnPkZlWHp0tqQJGr9R0EngGdOGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCIpzL67; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCIpzL67"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8de02a4dso1156449c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643240; x=1777248040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn7P0ZCcInC8XQlKfA/2nX/qFreCR1PCR/uccepCSos=;
        b=bCIpzL67Ksbgbw/PH+Csqk4anQNNO/YxllXXMwMUkw6Ci/Yp6NkPsSd9wFoRiynsaO
         vL4A4NJPMItVYEfUGlkJv9uWweOsUqN0udxs9bZqghFY2CwuZxZXZd9J5PlGDumphu8i
         xEPj6UvIzIP8F7pwZgupmeqBam4FIqGeTJbznx5z7eKia3rRbyrupJaY1aPF4OrakdrU
         5qa1/TqPGBqpOpMHe4GcCeEZ48pbyLuZT+Es4SI5TSJ6r9NPWBuAibD3lLJcy9/oRFRb
         4XcZ8eN8tLwsPsVv9ABfc6OfV+v1pvrfqn8y8LfAkN5Vrp6uV52pGQwYSUMk8UV8swYA
         Ui9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643240; x=1777248040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn7P0ZCcInC8XQlKfA/2nX/qFreCR1PCR/uccepCSos=;
        b=D15fS2l4bdZcOT43X4oZzfxhDlvex2+QOuMu9r3GwjQ4/whHdhXEfU3oZmeCfpiaSe
         EucrSThnQIgEJu6sw9sYbj3I4MpoeUax17334kCAY4LlqWjFmu1hglsS/9twz8Rjrcm8
         AZLb3BksBV7iaE9uCa2xba19lPXfe5oRBtHrqk/b6xePRdpSEOGLu2n35tZPXpvRxso8
         422PKpEs8uYzuZAVdzHYDwtuii3Zj5RRugG2R09vEwGWgC/Az1mORohPXGM2aOGGAvN+
         1sHaQRwCAvYkXQglzLq/YxFMQZG12SLFeQ78Aqf1Pvsg6w9CtSs88qsYPZ1lK9lXTmYs
         mTiw==
X-Forwarded-Encrypted: i=1; AFNElJ+VpQuie7MHzVoE2ypp2GA4q8pT1KiwSlweqhK2Vvr8i7XrpxU0XzCJK2XKKBm8aWmFhQdN1mHC9ma4IvRNcrqt@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn+M2V4G+P1ozklcGDj1A/jRRIBDLHHizR5m+1cf9sFuN1VwZ
	qxcDwUHxARsTHV9mRah7wqV71uJMp68Ua5Q9mEmtRJaZv0OGZ6P7Tk/621ZcYWHl5ZGRgpeke+b
	K7aRKaXfWCw==
X-Received: from dlbto10.prod.google.com ([2002:a05:7022:3b0a:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41aa:b0:128:d34a:320f
 with SMTP id a92af1059eb24-12c73f6fcbcmr6403538c88.12.1776643239488; Sun, 19
 Apr 2026 17:00:39 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:46 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-35-irogers@google.com>
Subject: [PATCH v1 34/58] perf compaction-times: Port compaction-times to use
 python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a port of the compaction-times script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/compaction-times.py | 325 ++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100755 tools/perf/python/compaction-times.py

diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/compaction-times.py
new file mode 100755
index 000000000000..352e15ddd5f9
--- /dev/null
+++ b/tools/perf/python/compaction-times.py
@@ -0,0 +1,325 @@
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
+                filtered = cls.fobj.filter(pid, comm)
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
+    comm = sample.sample_comm
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
2.54.0.rc1.513.gad8abe7a5a-goog

