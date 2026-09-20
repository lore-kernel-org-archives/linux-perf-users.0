Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D83DDDD1
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881810; cv=none; b=E+rq9VN0QveKQYU9S5LEqdu3W8IoD0Rg1Ymi44A6TuxsGNr3/uqz/it1yz5PfZbiN9+xf5zI/IK7a/bm2udMrJ9Tfk7eQX5VbwnYrcsvXRJ/9vET7uJHTG+69VsusHwqtgsqJ1+f+8/ydrv6hmXTl1adQZDMloVYmTlk26w/mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881810; c=relaxed/simple;
	bh=12q29hyt645CoQkMbJPV/qwaaFScX2HVZR81tIwL4Cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WAdECS55/8FzYqdOPqOjyBawzlm6x+ynS10zqZPv3wh41hlzd6a4hTpxSdPQcOKxNb/6gGizZLYSqBnPuP/ub2zaaZKblqFYGWsmwcAzmGrJicLxYCIKNMGIPU7KefgDJ8ccl03YSMWs9euUy7D/19V6XjjXm1xTrXDvWXv1nGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4N8yeK9; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4N8yeK9"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-85f1f3620bcso2910649b3a.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881808; x=1790486608; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pqpodkDgYYaLAYk3cYCRqedxFXr01z3y6etYM3LEeI=;
        b=S4N8yeK9wxqi9owHNvjQBvGJfuPeHjg7Iem+DGmyYu/oOIHmPzWaq65ugAGiNXQmHd
         GeP/JCm0clA4++tWguLSS8WrIhcFqKaxxjZQ+yKpc2GoY63V3ZQHQnN1j+f/zJ1m7nd7
         jHxfTdcuekEWO6v+6Ca+RmvJSfNdkFuDJDXaPNiVq+89/iolp8nSvS1ALLBb/A0uvtER
         T8Xq6YxsgIemlEVQZmLTUpqbhJpm5BqJXwAoKUPOCGuItPohMF1H5kbb1/CPUAgMSmvB
         Q9obep09PXjx23eonja54uBcI4WHe8TsiMVutA91gEgj+WFQ38FUF5zUiK08lDEUhyif
         zguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881808; x=1790486608;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pqpodkDgYYaLAYk3cYCRqedxFXr01z3y6etYM3LEeI=;
        b=DrbbVqxdiePjy2XkpQyLiVPGj8AYnOYwi0fWfhm3D/nGpPVvtuiuiATOZrCd5AGS7E
         ZApvb6CBtEDAtUHZymONPboelt6PSDhzJhlTO9BRwSBwCfnhjyFIe7NG3YfDSZQmSIQI
         FAccf7Ls+LUfELb7hQ9qwxekJsojwCrfWEH7uo7sorMEOI1qCrpsgRWfV16CNIduneZ5
         f4D9C4nSizHk1qbo5Smde++FjLMj9qO0qARxRdsrSqDgVCvm06mzBLAoVh/sem89OgBr
         bizNziYxmTHdIhMCYF4ro7dPLI6fdg9ccTDdSUf9Xv02rI8u4AdSEQ03uuNfr4LnB2md
         Qmeg==
X-Forwarded-Encrypted: i=1; AKwUvBykCj2mZuvBHk68PY2EfjL3HR34MpuoAnHgnBlYHPkKOUWmQ5AKnjtF6pZn7TAZekZGktc1A8rhdnOPi2HNpTCC@vger.kernel.org
X-Gm-Message-State: AFuF++lhQkBBeRDpV0k0t/nUO5CpuNkcqHeLSAxK6FQyNLglCMURX2Bh
	doqFB+L5WV6OFw0RotfH/3+8vK5tqitar1JL8U+oQ9m74OAsP4L7V3iLgWo66JaiN5VxJHvFQLe
	Yj8kfmFDcGw==
X-Received: from dycme19.prod.google.com ([2002:a05:693c:2413:b0:337:2020:1b1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7489:b0:3dd:a9a9:396c
 with SMTP id adf61e73a8af0-3dda9a93ba4mr3086975637.48.1789881807644; Sat, 19
 Sep 2026 22:23:27 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:20 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <87dc74b960e57651635d1120d465cd37b8d7ac9f.1789880842.git.irogers@google.com>
Subject: [PATCH v1 28/49] perf python: Port rw-by-pid from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
 tools/perf/python/rw-by-pid.py                | 189 ++++++++++++++++++
 .../perf/tests/shell/test_rw_by_pid_python.sh |  77 +++++++
 2 files changed, 266 insertions(+)
 create mode 100755 tools/perf/python/rw-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_rw_by_pid_python.sh

diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid.py
new file mode 100755
index 000000000000..6d174c0f1bea
--- /dev/null
+++ b/tools/perf/python/rw-by-pid.py
@@ -0,0 +1,189 @@
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
+    def _handle_sys_exit_read(self, pid: int, sample: perf.sample_event) -> None:
+        try:
+            ret = sample.ret
+            if ret >= 0x8000000000000000:
+                ret -= 0x10000000000000000
+            elif 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            if ret > 0:
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
+    def _handle_sys_exit_write(self, pid: int, sample: perf.sample_event) -> None:
+        try:
+            ret = sample.ret
+            if ret >= 0x8000000000000000:
+                ret -= 0x10000000000000000
+            elif 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            if ret > 0:
+                self.writes[pid]["bytes_written"] += ret
+            else:
+                self.writes[pid]["errors"][ret] += 1
+        except AttributeError:
+            self.unhandled["sys_exit_write_attr_err"] += 1
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)[6:-1]
+        pid = sample.sample_pid
+
+        assert self.session is not None
+        try:
+            thread = self.session.find_thread(pid)
+            comm = (thread.comm() if thread else None) or "unknown"
+        except (TypeError, AttributeError):
+            comm = "unknown"
+
+        if event_name == "syscalls:sys_enter_read":
+            self._handle_sys_enter_read(pid, comm, sample)
+        elif event_name == "syscalls:sys_exit_read":
+            self._handle_sys_exit_read(pid, sample)
+        elif event_name == "syscalls:sys_enter_write":
+            self._handle_sys_enter_write(pid, comm, sample)
+        elif event_name == "syscalls:sys_exit_write":
+            self._handle_sys_exit_write(pid, sample)
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
+        try:
+            self.session.process_events()
+        finally:
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
index 000000000000..6ce3e2355c11
--- /dev/null
+++ b/tools/perf/tests/shell/test_rw_by_pid_python.sh
@@ -0,0 +1,77 @@
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
2.55.0.1082.g2b9226bbc0-goog

