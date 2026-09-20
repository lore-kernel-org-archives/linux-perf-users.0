Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776D3DB625
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881805; cv=none; b=YGlUffUh9oa0jiaZKYF4a9sjtBvRHcWRqbj31HvUswsSNym1JTPXC9/PcTHPBS163K6OnAm5X5onOxKtPXhP8L65mRN0cc/bYZ+VMdKkH9oQWzxZXicUTpFpjxdGyT1iNq3sWxKHuU7RkHJmUmgtVUcesdAzNRbrtykeg3sO3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881805; c=relaxed/simple;
	bh=B/hM4tlZjvZDpu9nDX17Q51jeBATLZV3v0o5bAU0Z+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJD2x6kAerRhe4EVFOV5u/I/P5J87+4GWrnIw9ectggpFMR05bibboXlPDTQqxZZe59dx4D0v/jvu0s4vIOmHpH2V++YNTsNcPonLT6IDPaT/BxS4e4E+PmhpHBwHHIqMML8SCw/fPtnLfwgEw/S4f3I06W52pmOhft+63GRhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8Gb9RIb; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8Gb9RIb"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so675527a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881803; x=1790486603; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTR/BtnRdgHInj0LcmAaMp6WD10lbn0vAW55yU/mp8g=;
        b=W8Gb9RIbSBsgnxGI12xj8gVPwE92hZmLTVmUxSA/IgIkYBAweAkb7rjYNSb0YRx1iQ
         BI+5FqhKtlZA8yObturmuB05ptLfh9fTqmV0mppy2j45vNvWbxJcozHohNYbmsh73Ge2
         S1zNcXHTSBKwcfjy2UCu6/umsw8L+BSIenlwFRVNDLGrvoTrdDdKjoJn9orFajcbSZk5
         9U+6YHzXAjTxzPxrhoSc7FUWE3Nc96Sh8iuAAlegrxtnQzB6L/zU0AHLrwruenyxyAia
         D0GebTFn4NG3+QoiEhR3O+5ywsSS+FYN/TF0rodyrPrv+fRCbpOkQ+Sr1NzHOlEv5u8y
         NHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881803; x=1790486603;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTR/BtnRdgHInj0LcmAaMp6WD10lbn0vAW55yU/mp8g=;
        b=mpblyPo1jSLRJN/8CxfYZGthCYo/vxVc9yV+7KTnyBhdEOKUfKzP+GYWIei2Q0mhlS
         3Ys76PGONlo4hEVPmNmH1ln+2gbnUf7GbI2c0Z6CvniTjeTLWDnK2nmaRHMjdV+/JVHJ
         jL72uXkb8+soWeaiUclcuUjpCRFoLmyh8XJG6gonJ+L1Q9W6lswMSUJxznF5OOLkW2ay
         TO3JXPeUvKeEL2G7LkhTHPOCs0AEoJYn2nWePxruvqReIF7tGZM+lqa7Gj/9QUzIx3QP
         A2dgXYEWkPdVHyBJMJNuZ164E22VQmGwHkwB8VnbCW0yxj3xW7fgWn08X5V8yKJ4MbnR
         8V6A==
X-Forwarded-Encrypted: i=1; AKwUvBw84IFd4z0/oPUvFlm5jina3YtVLnYZ70ZIeU8REncP0yxCLRGMUCcBC2pg0KIpHWAlar2uIIvEZGWDYOZ3BgMC@vger.kernel.org
X-Gm-Message-State: AFuF++nMxdFkEr4e6pSg1ZxcpEylzhQuE3UiS9VCCk5QDNh/4P988dXK
	OFbDo5ekH1TiVjJCQys7N+mrz2yLcl0AbtUMMpovP/GCA75JJIA1X6YBmxAeF8cZNGRfiML1z7P
	F6uII94gl5A==
X-Received: from dlbek20.prod.google.com ([2002:a05:7022:c94:b0:143:7b2d:7e10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf86:b0:3dd:a006:ed97
 with SMTP id adf61e73a8af0-3dda006edd9mr6500085637.45.1789881802544; Sat, 19
 Sep 2026 22:23:22 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:17 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <5bf86935636daa6939a43ceeca772ec8f053381a.1789880842.git.irogers@google.com>
Subject: [PATCH v1 25/49] perf python: Port failed-syscalls from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the legacy Perl script failed-syscalls.pl with a standalone
Python script in tools/perf/python/failed-syscalls.py using the perf
Python module.

Improvements compared to the legacy Perl script:
- Remove the dependency on libperl and Perf::Trace::Util.
- Support both syscalls:sys_exit_* and raw_syscalls:sys_exit events (the
  legacy script only handled raw_syscalls::sys_exit).
- Use session.is_64_bit to distinguish 32-bit vs 64-bit unsigned error
  return ranges (0xfffff000..0xffffffff vs >= 0xfffffffffffff000) so
  valid 64-bit syscalls returning ~4GB values are not misclassified as
  32-bit negative errors.
- Add argparse CLI support (-i/--input and optional comm filter) and
  full type annotations.

Add a shell test
(test_failed_syscalls_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls.py          | 88 +++++++++++++++++++
 .../shell/test_failed_syscalls_python.sh      | 81 +++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_python.sh

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..99c3432b2e31
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Failed system call counts."""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional
+import perf
+
+class FailedSyscalls:
+    """Tracks and displays failed system call totals."""
+    def __init__(self, comm: Optional[str] = None) -> None:
+        self.failed_syscalls: dict[str, int] = defaultdict(int)
+        self.for_comm = comm
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process sys_exit events."""
+        event_name = str(sample.evsel)
+        if not event_name.startswith("evsel(syscalls:sys_exit") and \
+           not event_name.startswith("evsel(raw_syscalls:sys_exit"):
+            return
+
+        try:
+            ret = sample.ret
+        except AttributeError:
+            print("ERROR: tracepoint fields missed", file=sys.stderr)
+            sys.exit(1)
+
+        if ret > 0:
+            if ret >= 0xfffffffffffff000:  # 64-bit negative errors
+                ret -= 0x10000000000000000
+            elif 0xfffff000 <= ret <= 0xffffffff:  # 32-bit negative errors
+                assert self.session is not None
+                if not self.session.is_64_bit:
+                    ret -= 0x100000000
+
+        if ret >= 0:
+            return
+
+        tid = sample.sample_tid
+        assert self.session is not None
+        try:
+            thread = self.session.find_thread(tid)
+            comm = (thread.comm() if thread else None) or "unknown"
+        except (TypeError, AttributeError):
+            # find_thread returns None when the thread isn't known.
+            comm = "unknown"
+
+        if self.for_comm and comm != self.for_comm:
+            return
+
+        self.failed_syscalls[comm] += 1
+
+    def print_totals(self) -> None:
+        """Print summary table."""
+        print("\nfailed syscalls by comm:\n")
+        print(f"{'comm':<20s}  {'# errors':>10s}")
+        print(f"{'-'*20}  {'-'*10}")
+
+        for comm, val in sorted(self.failed_syscalls.items(),
+                                key=lambda kv: (kv[1], kv[0]), reverse=True):
+            print(f"{comm:<20s}  {val:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace failed syscalls")
+    parser.add_argument("comm", nargs="?", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = FailedSyscalls(args.comm)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_failed_syscalls_python.sh b/tools/perf/tests/shell/test_failed_syscalls_python.sh
new file mode 100755
index 000000000000..7ab1f50b4260
--- /dev/null
+++ b/tools/perf/tests/shell/test_failed_syscalls_python.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# failed-syscalls python test
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
+script_path="${script_dir}/failed-syscalls.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, failed-syscalls.py not found at $script_path"
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
+echo "Testing failed-syscalls.py..."
+
+# Check if sys_exit event can be recorded
+if ! perf record -e raw_syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
+	if ! perf record -e syscalls:sys_exit -o /dev/null -- true >/dev/null 2>&1; then
+		echo "Skipping test, no permission or support for sys_exit event"
+		exit 2
+	else
+		EVENT="syscalls:sys_exit"
+	fi
+else
+	EVENT="raw_syscalls:sys_exit"
+fi
+
+# Run perf record with a command that fails a syscall (ls non-existent file).
+# ls exits with non-zero, so perf record returns non-zero exit code of the workload.
+perf record -e "${EVENT}" -o "${temp_data}" \
+	-- ls /nonexistent_file_for_test >/dev/null 2>&1 || true
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "failed-syscalls.py test failed"
+	err=1
+else
+	if ! grep -q "failed syscalls by comm" "${temp_out}" || \
+		! grep -q "ls" "${temp_out}"; then
+		echo "Failed to find the metrics table header or expected error"
+		err=1
+	else
+		echo "failed-syscalls test passed."
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

