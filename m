Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A543D9DC0
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916642; cv=none; b=DhbZYj7FPFsZ3wrJ0evuVZn0cbIwAaRwdikUXstKFeNmjUxJwNkUqmTOE70sdwtGOZL0mzvVqjQX+V3hTZ27pXE9vp0mBGyyjDEbXi9/yPVl3cHex6VVpNerSLZJOgqDBw59XQdSmSP11Mdu+SMrGRbJadbqL0zy8eclmfjHKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916642; c=relaxed/simple;
	bh=sjGxjPIV53S0ogGdq6q4zr0NjFi3jsm+UT6Co0BIxCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3Z6TreKWMRmNb6Osa75hRL7Y8Ui2hHhBeAzuu30THMZUvarkKmk+vGArEyL9tR4hPT0IQuBHUfyVCPgiHi2QlaUZB6wSBYSLlRxFYZ10+OC6AiTBZPKsvQHxIULtfaNnK0MjbFqMteNcwA+DYrDFHFieAs5GxnRaNMNxGAxtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=in4B5ffp; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="in4B5ffp"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2da19227bc1so10393171eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916640; x=1777521440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hp8c+t78TuKjB+7x55spmRMxgPm6ZyTAaKZH31sSXw=;
        b=in4B5ffpZ77Tla/L1vi2ET7uLoC1wlwInzQWe+AJKa9sHNQcPqwE64EC5KXAKNe9/y
         ypPC+yu2YTYEx23RP+SSZ57URhbavHP09fCjuNdf8TEfOo2jdCOUPzekLyMwdaBHbK3j
         TpG8Vkrf5Ve5yshreB7J8buFSbPYVJumLyhYhn88UL/9hwitGuiBlLA2iiYDTMotqhmi
         JtZCKDuU/M1Z8D3HXvwdBDzO6DeshtXDJLta24C7GxLFtQht3qEPtbLpq4QNS6OpuNjn
         3lvlDo8MQpTWfz3cONqwjUuROsHdXPlC2B5OreaBuKRslBAlY1agorM3GzQHUL5fRurl
         TZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916640; x=1777521440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hp8c+t78TuKjB+7x55spmRMxgPm6ZyTAaKZH31sSXw=;
        b=Vz0bnDxnDD0vRR9DncCf61cNxOk3zAT4uKRBq/aWYIxR2LvMY1JLFB6HVUUtfsngqT
         vbswIj2gi7dMObhU9GUxOYscR5hMEjIPDbrMvXT+9l/cSPL3YJJAK58o4/4mJbyQUekE
         ylqtJHacQil23XlJNe9qnXEpwWMqsn99lNuH1ZcOwvbYlPVaLH0etDHkkRywg0A+wbWc
         uWmMSDQEex7hqLunGXq7jZpd447WjozAU6I5CcJTec+LLwidpY9Ct2NUQW6F41HM2Xa4
         E8Wq7nB3iQNWfmPR7AsInEPdF/OCaccS2aio7xEVS5tOMpoi5aZJZXN8FoQR69gvMOn2
         68iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ROBL+h9r6Gw/8SuG4FxoIqKdnXKW0Nq47RUNSfLx/1Fu2EcE5+R9zGhVlYW4KxsxB5cyMX1rjUHXT0+h0Yrul@vger.kernel.org
X-Gm-Message-State: AOJu0YxToGfDr8EkWm8GEPg5Aa9OMTE3bX04wpk/UGWHvoB7mI8T8kha
	YBj9MOQEOMGNpckI0JbxfbjLFKkY65jOgLprAqmg7joPimlMRCGJIPEfqVYkmuzoAGDNftqHbh9
	R9xkyuTv8CA==
X-Received: from dybmc15.prod.google.com ([2002:a05:7301:198f:b0:2d7:e13b:ef99])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3f9f:b0:2e6:e7da:7c30
 with SMTP id 5a478bee46e88-2e6e7da7cd6mr8909339eec.17.1776916640226; Wed, 22
 Apr 2026 20:57:20 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:15 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-49-irogers@google.com>
Subject: [PATCH v2 48/58] perf rw-by-file: Port rw-by-file to use python module
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

Port the legacy Perl script rw-by-file.pl to a python script using the
perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It tracks read and write activity by file descriptor for a given
program name, aggregating bytes requested/written and total counts.

Complications:
- Had to split long lines in __init__ to satisfy pylint.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed Substring Matching: Replaced if "sys_enter_read" in
   event_name: with an exact match against syscalls:sys_enter_read and
   raw_syscalls:sys_enter_read using sample.evsel.name . This prevents
   variants like readv or readlink from incorrectly triggering the
   read logic. Similar fixes were applied for write events.

 - Fixed Silent Error Dropping: Instead of silently returning when
   expected fields are missing (causing AttributeError ), the script
   now increments the self.unhandled counter for that event. This
   ensures that missing data or unexpected event variants are reported
   to the user instead of quietly skewing the results.
---
 tools/perf/python/rw-by-file.py | 103 ++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 tools/perf/python/rw-by-file.py

diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-file.py
new file mode 100755
index 000000000000..f71e0b21f64e
--- /dev/null
+++ b/tools/perf/python/rw-by-file.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for files read/written to for a given program."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class RwByFile:
+    """Tracks and displays read/write activity by file descriptor."""
+    def __init__(self, comm: str) -> None:
+        self.for_comm = comm
+        self.reads: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_requested": 0, "total_reads": 0}
+        )
+        self.writes: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_written": 0, "total_writes": 0}
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = sample.evsel.name  # type: ignore
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.process(pid).comm()
+        except Exception: # pylint: disable=broad-except
+            comm = "unknown"
+
+        if comm != self.for_comm:
+            return
+
+        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_enter_read"):
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.reads[fd]["bytes_requested"] += count
+                self.reads[fd]["total_reads"] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sys_enter_write"):
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.writes[fd]["bytes_written"] += count
+                self.writes[fd]["total_writes"] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        print(f"file read counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# reads':>10s}  {'bytes_requested':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.reads.items(),
+                               key=lambda kv: kv[1]["bytes_requested"], reverse=True):
+            print(f"{fd:6d}  {data['total_reads']:10d}  {data['bytes_requested']:15d}")
+
+        print(f"\nfile write counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# writes':>10s}  {'bytes_written':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.writes.items(),
+                               key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(f"{fd:6d}  {data['total_writes']:10d}  {data['bytes_written']:15d}")
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace r/w activity by file")
+    parser.add_argument("comm", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwByFile(args.comm)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.rc2.533.g4f5dca5207-goog

