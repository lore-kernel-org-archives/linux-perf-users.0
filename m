Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEC3E1CE2
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049372; cv=none; b=jL6th0PPptgCBvXy3BX5oQ5EOvMsIkXVQph4KCwFgE7DjxKIgEHaeaU10X1ZUagY3w5qnHiLj8OVBZMdGvbupPLSsAefBoBU8gSNJEnP3FGkvLbVJYy+pHIKyKmcEbY98KCCMn5HMo2sxwLH5AhlJ5keyZqrcBWj0zNbOvRGCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049372; c=relaxed/simple;
	bh=bLVNpLi8urjvclamDOuNIS+Nsu9v6LV6hvcHr42wF74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FlfHINlfToOjs1O7WRghcJP6x0Bl/q3p+gSfVo/TC0gsRo52iTgSDZZK8rX2wBUdS9/F5rQkk60G+BbLUgs4BUsRHz+Hyvlo1NCFBRNGaepsf6D1ucAbvg4UFpR/tEvFd6oLxMwda/t4lS8SblvVSxlsxb7RF0HNuN9eCK25fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7JCqjDi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7JCqjDi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so20877457eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049369; x=1777654169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdsIaZxORPBtHlF7NDydqw84ClDmIcXPteqzDGLLDeY=;
        b=c7JCqjDig4ihuvlAE3v2Ke2n3UbP5SjtGRIxaVAcwswKu9BFEOXMR5WVjfki15zNAQ
         bw/Egz2TEksw9N6YBpLAhLnx419YbhDQji5Fj1nBP8/EAPSacIOJHp8c19zDSx7ukYRK
         wW479TySjY1D26tafc+w1sCw+fYPHuPpjXu+5Jn8pBJAO/i7QPyoc23Us4/+QjCp0OCt
         uOR1s6ANfZXFgmGjr+mcFk66T1NO3mH7/HdUHKfA6Ft5ipS2gVbw8YdnJWZWg+PIhlg0
         BXT0vhupZgd7p6YK8WzCBWjJ61U3V16nBnPdQW/cDsXLZ8Oj2LByYOQKjMp97EVTp85E
         K4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049369; x=1777654169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdsIaZxORPBtHlF7NDydqw84ClDmIcXPteqzDGLLDeY=;
        b=RpmS4Q/Pk+f4aD1XlEp6qTJhEhd72TdK/Ufnf7WcHfYeeVa5NAqU8b10cyWhrIcn1o
         0CHQV37FMpin1EmlFIUMIeB+5w6r4SltqjoAjiGYHP/Nuije0uIVCBUkuWnIENNEFbT7
         nrTD4tQoJMmnAKuLO4WxJE5T7p7dWpAJhD/j6Ui2BQo25eEQQjfj6PMHz2C5+RkvxhPV
         vcTCFFWTn9YR1l1dA5dO8zah2QvOzPhw8yi0ZSOa8X6cnjUXeCgqIzsJ2h2ONrdIcg1V
         jdoGty2mJgG1lx/yitPScVIvewbaOEDYRCLN6qvOGsXNYqBY4tBkRAM+dEYdBWWHu/Eu
         vZAg==
X-Forwarded-Encrypted: i=1; AFNElJ8srk48cWPBPR6OGRGCax+NLcgeq35iLSzlSGKPQaQt55ieRy+SJLJJNwUvjM4BEFEH7Y0kBgy1DWYO5/sjZvin@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZ7mZxmnA9QhrWrqk8KxX/pjQblbrx5MRrzOFFhaYc3OmTxyK
	Me+yMz2ePrJYnP6j5JckzQ/etQmqEM1qPY6X6Odx7YxQGkpP61FrTHC9L1+BcErW2mbn0tNmnwi
	D3R/7hPPIBg==
X-Received: from dycao4.prod.google.com ([2002:a05:7301:7d04:b0:2da:3d44:ddce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9f12:b0:2e1:e3e6:2910
 with SMTP id 5a478bee46e88-2e46577039dmr20625261eec.9.1777049368506; Fri, 24
 Apr 2026 09:49:28 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:11 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-50-irogers@google.com>
Subject: [PATCH v5 49/58] perf rw-by-pid: Port rw-by-pid to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the legacy Perl script rw-by-pid.pl to a python script using the
perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It tracks read and write activity by PID for all processes,
aggregating bytes requested, bytes read, total reads, and errors.

Complications:
- Refactored process_event to extract helper methods
  (_handle_sys_enter_read, etc.) to reduce the number of branches and
  satisfy pylint.
- Split long lines to comply with line length limits.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed Substring Matching: Replaced loose substring checks like if
   "sys_enter_read" in event_name: with exact matches against
   syscalls:sys_enter_read and raw_syscalls:sys_enter_read using
   sample.evsel.name . This prevents unrelated syscalls with similar
   names (like readahead ) from being incorrectly aggregated. Similar
   fixes were applied for exit events and write events.

 - Inlined Handlers and Tracked Errors: Inlined the _handle_sys_*
   helper methods into process_event() to make error handling
   easier. Now, if a sample lacks expected fields (raising
   AttributeError ), it is added to the self.unhandled tracker instead
   of being silently dropped, providing better visibility to the user.

 - Code Cleanup: Fixed trailing whitespace and added a pylint disable
   comment for too-many-branches caused by the inlining.
---
 tools/perf/python/rw-by-pid.py | 158 +++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 tools/perf/python/rw-by-pid.py

diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid.py
new file mode 100755
index 000000000000..53e16b373111
--- /dev/null
+++ b/tools/perf/python/rw-by-pid.py
@@ -0,0 +1,158 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for all processes."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict, List, Tuple, Any
+import perf
+
+class RwByPid:
+    """Tracks and displays read/write activity by PID."""
+    def __init__(self) -> None:
+        self.reads: Dict[int, Dict[str, Any]] = defaultdict(
+            lambda: {
+                "bytes_requested": 0,
+                "bytes_read": 0,
+                "total_reads": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.writes: Dict[int, Dict[str, Any]] = defaultdict(
+            lambda: {
+                "bytes_written": 0,
+                "total_writes": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:  # pylint: disable=too-many-branches
+        """Process events."""
+        event_name = sample.evsel.name  # type: ignore
+        pid = sample.sample_pid
+
+        assert self.session is not None
+        try:
+            comm = self.session.process(pid).comm()
+        except Exception:  # pylint: disable=broad-except
+            comm = "unknown"
+
+        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_enter_read"):
+            try:
+                count = sample.count
+                self.reads[pid]["bytes_requested"] += count
+                self.reads[pid]["total_reads"] += 1
+                self.reads[pid]["comm"] = comm
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("syscalls:sys_exit_read", "raw_syscalls:sys_exit_read"):
+            try:
+                ret = sample.ret
+                if ret > 0:
+                    self.reads[pid]["bytes_read"] += ret
+                else:
+                    self.reads[pid]["errors"][ret] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sys_enter_write"):
+            try:
+                count = sample.count
+                self.writes[pid]["bytes_written"] += count
+                self.writes[pid]["total_writes"] += 1
+                self.writes[pid]["comm"] = comm
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("syscalls:sys_exit_write", "raw_syscalls:sys_exit_write"):
+            try:
+                ret = sample.ret
+                if ret <= 0:
+                    self.writes[pid]["errors"][ret] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        print("read counts by pid:\n")
+        print(
+            f"{'pid':>6s}  {'comm':<20s}  {'# reads':>10s}  "
+            f"{'bytes_requested':>15s}  {'bytes_read':>10s}"
+        )
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*15}  {'-'*10}")
+
+        for pid, data in sorted(self.reads.items(),
+                                key=lambda kv: kv[1]["bytes_read"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  {data['total_reads']:10d}  "
+                f"{data['bytes_requested']:15d}  {data['bytes_read']:10d}"
+            )
+
+        print("\nfailed reads by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>6s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*6}  {'-'*10}")
+
+        errcounts: List[Tuple[int, str, int, int]] = []
+        for pid, data in self.reads.items():
+            for error, count in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, count))
+
+        for pid, comm, error, count in sorted(errcounts, key=lambda x: x[3], reverse=True):
+            print(f"{pid:6d}  {comm:<20s}  {error:6d}  {count:10d}")
+
+        print("\nwrite counts by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'# writes':>10s}  {'bytes_written':>15s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*15}")
+
+        for pid, data in sorted(self.writes.items(),
+                                key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  "
+                f"{data['total_writes']:10d}  {data['bytes_written']:15d}"
+            )
+
+        print("\nfailed writes by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>6s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*6}  {'-'*10}")
+
+        errcounts = []
+        for pid, data in self.writes.items():
+            for error, count in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, count))
+
+        for pid, comm, error, count in sorted(errcounts, key=lambda x: x[3], reverse=True):
+            print(f"{pid:6d}  {comm:<20s}  {error:6d}  {count:10d}")
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
+    parser = argparse.ArgumentParser(description="Trace r/w activity by PID")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwByPid()
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

