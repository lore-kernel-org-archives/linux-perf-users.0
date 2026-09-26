Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F9375F65
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403717; cv=none; b=YvSzcuCpCj9BJhvnDmBjFxR7g80iO8GnWH+LsW7/2GAAgN53nZwWwAXUW98xm4IUosbRso59erq9rWat/ARain3GxH2vxK+1xaTpf2e2tqa/w4NwI+A5dDGfSfx7IhwQ8a9txfVnJ5e37+EIWSms3qLs3oHorGGjzz6LHvSi9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403717; c=relaxed/simple;
	bh=twa2t5NDF8B2ebIdy+CAqAQm0eyQVti2RL1gCRQSLBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XSbqd6Zk34trfKgr/TBGzHJPtITuRlI1eSKKRB9axl0ronDVtnyQ/gV891rjaBVyTVeVhAv65AvkcN3Ys00hSOygTYHj28dqsQyi37sFanmJatK2FN6IC1g3NG9JFsJrhQblJSYWirJA8lOmdGAoCNOXmFS3BnsPg3PtARY9EXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfOjqACk; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfOjqACk"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so6202075c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403714; x=1791008514; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBS2LCJ+fW8FuU5Xc7G48myLtCT2mEhsbIcl8X/SXcc=;
        b=MfOjqACkfSRhxwoY3wVeAPREEHSEKAsXATFDw9jOAlYzK70XK1UhNMou5nlQzvn3/S
         4QuiHl7hqldVfD5P64q/jbLfSin04+PfT5uH66vjCUj1JF/Kj+YnCaUi+2yvwzKNnuIC
         XSXI5j3bib2FWqZ0eSY34QRyHIE+U6/ygpSNkLD8ZTyyh3sxxwSszQmptv2yAgyTQ2OW
         mOjpkz4TvLMclflZa6ZRbs+t9VsQSddSwnbQjlyi/QMqMpcLIAY1BovwZn6yHsQaj6ai
         QBYMOB+YgyHFab4FqryiBFF++4ZVjhS217HnhFGs5IDBA1fx5tHYD76Hn6F3cjgklAIs
         rdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403714; x=1791008514;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBS2LCJ+fW8FuU5Xc7G48myLtCT2mEhsbIcl8X/SXcc=;
        b=EHHWuPZrcELg0oviD5hOC6ENGEwHjbotpcIwkC+IfB6yrqhlxYd1kGDLzniu028iC/
         N+Hr2lknP2FQA4ga1M2wBdcaj55kPtkffIuw3DNZCmR03wQT62luwp2Z172uh7H1tQK0
         xUDMiFEdxwpurxD9IPFPRGNkswhw+FnYGzzKGPD2AeL+0G+kbSWmQfS3OBJ3a0VV+LF/
         cb9C9S+rPcLw4cua5PjTGCBXjo2XeoElMPCTKFE0eGoQiBk9X869L6O5eCapnWrvNZiG
         r+t8xap9pA7n+DfQBD9TQlpGOO33mmLFDKnP8YlG5iGF7MC6JYQu+612xlMwzpzBZt5o
         DzeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt0cojBKTfM9EsYKVAUNtYet85Vh1BTHIJ55W24Xyj7gdPPqkHArUlompBiiMRpcwMylflcj8oNAl/wR2OEt4J@vger.kernel.org
X-Gm-Message-State: AFuF++mLBxJDBw4oBbaz4TwzCfLXzdsy0lA5ZNH64Fl3N+3a8V7K42eI
	DwW1kJZ8P9n5JdV9LvdgyKj1IK3AU4maYKgkoxW20uXyzviNR6cLL2ym7np1pYYrwk25QhzWZvJ
	lTXySdOCehA==
X-Received: from dlbrf7.prod.google.com ([2002:a05:7022:f207:b0:144:c0e8:a153])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1703:b0:143:33de:97ae
 with SMTP id a92af1059eb24-146ce776c64mr2265860c88.20.1790403713842; Fri, 25
 Sep 2026 23:21:53 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:55 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-29-irogers@google.com>
Subject: [PATCH v4 28/49] perf python: Port rw-by-pid from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
2.56.0.rc1.315.gc6ed9934b7-goog

