Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B83793BC
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967294; cv=none; b=i6IiB3jOEXGDZfQXS2FZu6LRSQMtWfgFaNcQ7AW/+SHaO012B7GnDIXhGUUkmEE1OT4dEaFphBSiAQyROnBBg2pTJuyXBwu6e1+H/fCu9KnTKUXD/wpbdgTEudQcoQJg6i4vnZsU6Hj9+/uQtA/pED1B0zY1rk6JBI8zfbxwVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967294; c=relaxed/simple;
	bh=rHUop6F/HOL9pf+BcWXmZN8GgAd0nsZxXViWw5fALmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4ZKDG7sE6Msg4WGkYIJbk/IJDNocye8SPnAZZuApeCfdtxeDm5DdbrEnQ7iQpJbSHfXCTMo7WAlifDRU02HAcv4zI8woZtn3Z6s8MhbZdF5S3sGhBtTngU8MX+7X2ZtU6pn87pgZ4+Y4KUb7z9bmT9iBoC3hDYGPoVpa/54A9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0Qj90Vb; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0Qj90Vb"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso4837950a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967292; x=1790572092; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPLu6nE2+oWboQQHEzebz6APnOOaXA/rRaOlpzizglU=;
        b=n0Qj90Vb0mnNyqh5e6Cyi3ksGOF30O9dhiauWZXedAg4hMKYL2/Tck6ls7uWrThB4j
         /2P2ugZXeVM6fwxZTRVe5KXZfkCsLynBZpUQjQN4MzpJX7Lrk3tJG+R9SZ1qKL6REeb+
         UqfYSTNoL6rUfIYeDPV8ofjR/zTz5nOZWwm67ORtaj6NKgnjUmnqprK0VefrS9F6eZwv
         vCtlAUSDieFJCoY2ynYIIu/f1P+s+RMDTvbgzeEr7zaQq2BN7wnkYEs/8Sw3GxhrW3u+
         GoXkr21qVNGHypsRqxEeAljo97f/lEP7H3FZJwIdPuQmUdjb6VMzLh7HaRVS298VQ81m
         Fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967292; x=1790572092;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPLu6nE2+oWboQQHEzebz6APnOOaXA/rRaOlpzizglU=;
        b=dw+1bgjbkJ+dmUXfzcWnSzzpg7eqm0hZq8BtDy2YbiZ1NmNOVyQ69ZZMU1FlIsCz9b
         ffWU76lHluv9gMCiGawmi//I98kOkJ7FnDse0Rn6DLlSc80eNVzr5uRyw2qJRdqwYnpC
         KzJ407JB2PcmYjm4voHYjZ4LND+ZibL21WMC1G9cG9H9DRJ+VCGkuqMmDk4ibcJVMiY4
         +A9hu1YukgBsJ1a/0hwPtgs0/mJ7fyrPGO6A4Uh3GE/m15/gxEBnTcURKx3beqmZhk7V
         +eH65sSA5O04LJ+eF24QeHEkO51bpVoELldBTXG9tXQY9vbzCaMqrD2T1mJ6VWqrgQVB
         IrYw==
X-Forwarded-Encrypted: i=1; AKwUvBzlPDnm4YBaNFoUhpcVqJc6k76M/6llOF6g9uCoji14WQCxGI45LrpTS5h5BeqOlk2JcWJsYWEeRqPYx5bMllxI@vger.kernel.org
X-Gm-Message-State: AFuF++kVl8M9WPpUxQ5pc/gbqRDCcYTvOL6lrau+lZ2KqxOKKEnRyJ/B
	o92s5V2eP4xFePLEPBZ+7JvB/4UYsLuBHfPS9hRxYdoiEFiILCtJwyxmgYPirZ5pSKPM0R90tIg
	MgBf3kolcMQ==
X-Received: from dldnz4.prod.google.com ([2002:a05:701a:ca04:b0:143:75c2:6d21])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da83:b0:39e:6c6a:6570
 with SMTP id 98e67ed59e1d1-39e6c6a6792mr8664493a91.51.1789967291693; Sun, 20
 Sep 2026 22:08:11 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:46 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <edd0103cb3e315e6cba47113c0196ca569e3acf5.1789966896.git.irogers@google.com>
Subject: [PATCH v2 28/49] perf python: Port rw-by-pid from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
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
 tools/perf/python/rw-by-pid.py                | 189 ++++++++++++++++++
 .../perf/tests/shell/test_rw_by_pid_python.sh |  77 +++++++
 2 files changed, 266 insertions(+)
 create mode 100755 tools/perf/python/rw-by-pid.py
 create mode 100755 tools/perf/tests/shell/test_rw_by_pid_python.sh

diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid.py
new file mode 100755
index 000000000000..fcfb0cc4631a
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
+    def _handle_sys_exit_write(self, pid: int, sample: perf.sample_event) -> None:
+        try:
+            ret = sample.ret
+            if ret >= 0x8000000000000000:
+                ret -= 0x10000000000000000
+            elif 0xfffff000 <= ret <= 0xffffffff:
+                ret -= 0x100000000
+            if ret >= 0:
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

