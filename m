Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59699443311
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187270; cv=none; b=b0ydqCacJdyw5mQ181/R+FMuOlk3v6K6iOPAFn7m02ckViIWxbhKjMPs8Qw2kXBa3S+FpejosG1fxV/lqelM5D29ECtR3bDruVy+U/puuyn5qEGPM5EeivkqpBmFAyEw5CpVQ+yCMii9bCTHLm2WU0ZpvqI7C6re4zBCUFMaHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187270; c=relaxed/simple;
	bh=PMUXgBeZOmFmtLwENLE/jUOnSorMqmmcHwDndI4HlZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLj/6Duu4mRhHUAtnYMGiwcbYN55WBMcRfFyYMNEYgGDlm+9+FNLJe0+hVKoZG9udDqSi31hGtgW5i4JGaV7vbPe21LHh0FZyiCbf0PdRN01jcYrjORP+RFKUOvq4EQc83StFZBWVE9RZu2bG9XZzOELe1teptzMsR2zvX7uUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnZ7/he1; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnZ7/he1"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33310847fcaso2105994eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187257; x=1790792057; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54Q/vwrPS+dstVxedLpwAT1et5bubHjIe8WYZCoHjZA=;
        b=fnZ7/he1WIJg94xTggzvfLQxI/osnlTfD6sJGqwGr9uBBO+l3mNwQj8gGcDWTh0trC
         FaRo8J2ihxu/CHUI7a4fcLAQz/8F2p8ltTUdodo6CFyDYMpwWXByAijccrsuXasZ9pBV
         WkPTVfgRjCCoW2nQE+mQMnUMSzRWXNs0qmrzkzV2ezjbC7oQTEFBSENKfLbwVq9rtuD7
         haQUfugLdceeF2Mm6SpG4yaR/UBjd5DkzuLrht2o9zbAzRmzzqf2ZNb5b85UJPe5DvYU
         RBxdmpeBQtxdcpNzqII7cYIw4+YrZTlLxQPf+xmm5wuOMpUjgDT/Bvp2mxNWlALHHf+1
         oO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187257; x=1790792057;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54Q/vwrPS+dstVxedLpwAT1et5bubHjIe8WYZCoHjZA=;
        b=eb9b4J8szkO22K8xTF/lCNHEcDDK2iKDPy4mwVsc0f5M8E4YtulbsNp9Q+qaZUxhuz
         rkoKxtHWD1talxfgMTYC07OcL1AjCsa01xtwMd0UZrSlq1G1cRgls281alzXMCb18qdi
         EC2buV7o7l79lyq1Fr5EaogWOLm3KOTWfFsTs3KTON80QdME683n7GozhK8wg11wD/WJ
         y7fOT+vl3/Dq1qVPL72iWtIIuyYCXM9+mjLFJnOUhrG+lWxmqULhAANYt9lJxO8C0qfr
         VP3YFhrHZbRzHhojjY6bApO/eQBLYS3LEdJl1WrwpRQ5aIaydI4WTE+Wj+gDcV4KquYz
         VxOg==
X-Forwarded-Encrypted: i=1; AKwUvByF0Ybf1plc+gmByjjjbhgc8CSaN/sszX7l8U8gWYbFEbt46P9+3S6Nd4AGREazB9QR5BikQa2j/TcTHo8Cu8dT@vger.kernel.org
X-Gm-Message-State: AFuF++nNPEMUdh1BGxJyCZIosRzPmAgXACW5m/0xzxW6v9bSFx/1Md6E
	+IE3QHnLUD17ujvJvhygZdb74EeMa37+Ifr5sSijPDMcnHbCuM6yaGFVjCcHmvS3vlkIRuKOFym
	59n6Z91IV+g==
X-Received: from dycnl8.prod.google.com ([2002:a05:7300:d108:b0:33b:f23f:e95e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1803:b0:33b:fa13:61bd
 with SMTP id 5a478bee46e88-33e8e1b00f8mr3237864eec.31.1790187255959; Wed, 23
 Sep 2026 11:14:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:51 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-29-irogers@google.com>
Subject: [PATCH v3 28/49] perf python: Port rw-by-pid from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the legacy Perl script rw-by-pid.pl with a standalone Python
script in tools/perf/python/rw-by-pid.py using the perf Python module.

Improvements compared to the legacy Perl script:
- Remove the dependency on libperl and Perf::Trace::Util.
- Convert unsigned 32-bit and 64-bit error return values
  (0xfffff000..0xffffffff and >= 0x8000000000000000) to negative errnos
  so failed read/write syscalls are recorded in the error table rather
  than inflating bytes_read / bytes_written.
- Add argparse CLI support (-i/--input) and full type annotations.

Add a shell test
(test_rw_by_pid_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/rw-by-pid.py                | 205 ++++++++++++++++++
 .../perf/tests/shell/test_rw_by_pid_python.sh |  75 +++++++
 2 files changed, 280 insertions(+)
 create mode 100755 tools/perf/python/rw-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_rw_by_pid_python.sh

diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid.py
new file mode 100755
index 000000000000..8e2d1dbd9a08
--- /dev/null
+++ b/tools/perf/python/rw-by-pid.py
@@ -0,0 +1,205 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for all processes."""
+from __future__ import annotations
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
+                "bytes_requested": 0,
+                "bytes_written": 0,
+                "total_writes": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def _handle_sys_enter_read(self, pid: int, comm: str, sample: perf.sample_event) -> None:
+        try:
+            count = sample.count
+            self.reads[pid]["bytes_requested"] += count
+            self.reads[pid]["total_reads"] += 1
+            self.reads[pid]["comm"] = comm
+        except AttributeError:
+            self.unhandled["sys_enter_read_attr_err"] += 1
+
+    def _handle_sys_exit_read(self, pid: int, sample: perf.sample_event, comm: str = "") -> None:
+        try:
+            ret = sample.ret
+            # Convert unsigned 64-bit or 32-bit tracepoint return values to signed integers.
+            # Because kernel read/write transfers are bounded by MAX_RW_COUNT (0x7ffff000 < 2 GiB),
+            # 0xfffff000..0xffffffff is always a 32-bit negative errno even on 64-bit hosts.
+            if ret >= 0x8000000000000000:
+                ret -= 0x10000000000000000
+            elif 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            if not self.reads[pid]["comm"] and comm:
+                self.reads[pid]["comm"] = comm
+            if ret >= 0:
+                self.reads[pid]["bytes_read"] += ret
+            else:
+                self.reads[pid]["errors"][ret] += 1
+        except AttributeError:
+            self.unhandled["sys_exit_read_attr_err"] += 1
+
+    def _handle_sys_enter_write(self, pid: int, comm: str, sample: perf.sample_event) -> None:
+        try:
+            count = sample.count
+            self.writes[pid]["bytes_requested"] += count
+            self.writes[pid]["total_writes"] += 1
+            self.writes[pid]["comm"] = comm
+        except AttributeError:
+            self.unhandled["sys_enter_write_attr_err"] += 1
+
+    def _handle_sys_exit_write(self, pid: int, sample: perf.sample_event, comm: str = "") -> None:
+        try:
+            ret = sample.ret
+            # Convert unsigned 64-bit or 32-bit tracepoint return values to signed integers.
+            # Because kernel read/write transfers are bounded by MAX_RW_COUNT (0x7ffff000 < 2 GiB),
+            # 0xfffff000..0xffffffff is always a 32-bit negative errno even on 64-bit hosts.
+            if ret >= 0x8000000000000000:
+                ret -= 0x10000000000000000
+            elif 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            if not self.writes[pid]["comm"] and comm:
+                self.writes[pid]["comm"] = comm
+            if ret >= 0:
+                self.writes[pid]["bytes_written"] += ret
+            else:
+                self.writes[pid]["errors"][ret] += 1
+        except AttributeError:
+            self.unhandled["sys_exit_write_attr_err"] += 1
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        if event_name.startswith("evsel(") and event_name.endswith(")"):
+            event_name = event_name[6:-1]
+        event_name = "".join(c if c.isprintable() else "?" for c in event_name)
+        pid = sample.sample_pid
+
+        assert self.session is not None
+        try:
+            thread = self.session.find_thread(pid, sample.sample_tid)
+            comm = (thread.comm() if thread else None) or "unknown"
+        except (TypeError, AttributeError):
+            comm = "unknown"
+        comm = "".join(c if c.isprintable() else "?" for c in comm)
+
+        if event_name == "syscalls:sys_enter_read":
+            self._handle_sys_enter_read(pid, comm, sample)
+        elif event_name == "syscalls:sys_exit_read":
+            self._handle_sys_exit_read(pid, sample, comm)
+        elif event_name == "syscalls:sys_enter_write":
+            self._handle_sys_enter_write(pid, comm, sample)
+        elif event_name == "syscalls:sys_exit_write":
+            self._handle_sys_exit_write(pid, sample, comm)
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
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>7s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*7}  {'-'*10}")
+
+        errcounts: List[Tuple[int, str, int, int]] = []
+        for pid, data in self.reads.items():
+            for error, count in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, count))
+
+        for pid, comm, error, count in sorted(errcounts, key=lambda x: x[3], reverse=True):
+            print(f"{pid:6d}  {comm:<20s}  {error:7d}  {count:10d}")
+
+        print("\nwrite counts by pid:\n")
+        print(
+            f"{'pid':>6s}  {'comm':<20s}  {'# writes':>10s}  "
+            f"{'bytes_requested':>15s}  {'bytes_written':>15s}"
+        )
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*15}  {'-'*15}")
+
+        for pid, data in sorted(self.writes.items(),
+                                key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  {data['total_writes']:10d}  "
+                f"{data['bytes_requested']:15d}  {data['bytes_written']:15d}"
+            )
+
+        print("\nfailed writes by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>7s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*7}  {'-'*10}")
+
+        errcounts = []
+        for pid, data in self.writes.items():
+            for error, count in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, count))
+
+        for pid, comm, error, count in sorted(errcounts, key=lambda x: x[3], reverse=True):
+            print(f"{pid:6d}  {comm:<20s}  {error:7d}  {count:10d}")
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
+        try:
+            self.session.process_events()
+        finally:
+            # Break the reference cycle between perf.session and self.process_event
+            # because perf.session lacks cyclic GC support (tp_traverse).
+            self.session = None
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
diff --git a/tools/perf/tests/shell/test_rw_by_pid_python.sh b/tools/perf/tests/shell/test_rw_by_pid_python.sh
new file mode 100755
index 000000000000..da8b065d43de
--- /dev/null
+++ b/tools/perf/tests/shell/test_rw_by_pid_python.sh
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# rw-by-pid python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/rw-by-pid.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, rw-by-pid.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+echo "Testing rw-by-pid.py..."
+
+# Create a perf.data file. Try to get tracepoint data.
+if perf list | grep -q "syscalls:sys_enter_read"; then
+	ev="syscalls:sys_enter_read,syscalls:sys_exit_read"
+	ev="${ev},syscalls:sys_enter_write,syscalls:sys_exit_write"
+	perf record -e "$ev" -a -o "${temp_data}" \
+		-- dd if=/dev/urandom of=/dev/null bs=1M count=10 >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+else
+	echo "Skipping test, no syscalls:sys_enter_read event"
+	exit 2
+fi
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "rw-by-pid.py test failed"
+	err=1
+else
+	if ! grep -E -q "^ *[0-9]+" "${temp_out}"; then
+		echo "Failed to find metric data rows in output"
+		cat "${temp_out}"
+		err=1
+	else
+		echo "rw-by-pid test passed."
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.56.0.rc1.310.g51773c2048-goog

