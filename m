Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39113352009
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967289; cv=none; b=kn+PdC0pOZY99ZH4QyPN/e1ve/rI5O44tYgOPM0HJ5W4rw5eaOMcWunemQclSEFgqadwxD2IlkQxhk51tpsAyk7g1u3MxpBr/VnJ4O7rf4AVwuwyxK8qhCueSNt2FEssY/ZAL0jqKeAIdmajsqPAFAG7+yVNxc4Pe+FY/xwJ0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967289; c=relaxed/simple;
	bh=urCQ0Y/CS5Ujx9SXnMY6Kcb0yfRQ2ktCLn08Whu/ssg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZi7PmKDtyRJyv+SqWqHGSpESWJUYk+CRdH9NdVYE5Fmymx+EBGtKk3RX0u9aGs+Ez0nIZpZpqhFUDXkp8J3RW7TIKepqmtEQZUh/CsPZK3raeWWirCHAei+F2D75bnarAHixQDLs9drEgVIDKdewplbTD2H/q0IXIg0Kx6mdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuI0QIKY; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuI0QIKY"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so37817595ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967286; x=1790572086; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryNGvI5H3VUWT8AwBGeI6tnEPTEDWwd/rTIHctXoYws=;
        b=BuI0QIKYBZqdfHiu71seYOH4lLzQ4Rrqsz9StJxdoj99/YUEQzAQkIifewmNzfDtss
         QHEc+prlWU5sSiEPHKmEPhsS+lYgT4XbDwHjL8rv+qt3xrJ2971u6LD/QCSPYNC86FIy
         iEU5Mu3uN78QLDNSXr5hfHHWXzV9BPu9Ko9SSK/B6QVIes7S1sfrSC0nZM3YNEWLOnFa
         CA42y6FC1SqqJiSruTBln9q4jEupVbiaawh3YsYRzoTMAd4PlMdzor3XpE89e4EUiRiy
         1iQDSvntR2IVtxCx3I9sYAKYhXv+btY5sL5Jyj1FcY2H5yJku1vRRoUkVP9dsgmjqw3m
         w8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967286; x=1790572086;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryNGvI5H3VUWT8AwBGeI6tnEPTEDWwd/rTIHctXoYws=;
        b=Ena5ZHtr2wCkkwKUMIoecOYbb9qRSaNsO6d38b88Qr2g91NE9hRNw52W3tyebsYXPd
         6FUXu8QKe4XnFF7MHkJQ/SmoD7Pk891MtsYyW/vbbAa5PbhGE5oiNr9lk0+x6knoeLBH
         4leVwOfKCplXgE6PISJ2tL4zuC51yKJjz5rYWKOMTi2f5QYa+pH61ZZruaQAGacv1/gh
         66rgKJUSKcSLKv3RvPazeTa/ovfhiZqK3e1d+3dphVyzDRhggeDcArg4QIB83Am3YY6b
         sn7Qa4Kr8/oq0PTXV6tgici6/mdv5Indh7aZJZ7WQky39n1GTV4qCXRQGjG6JO0Q9g0n
         FJgg==
X-Forwarded-Encrypted: i=1; AKwUvBz6cmL020igAE117SwRK5hiKJmYlf/QMRkvUkuU23TQrpEdFZh4WWTVlWgv+LQ6Wv+0yfZERVfOHBx8xGKHvDnA@vger.kernel.org
X-Gm-Message-State: AFuF++ksIWCrvQR0lgsxUxj770OMNuarnD2Sic7HCfbp1zrtitRtbl0b
	NgYri5S0Gdsg1NnX7371mdEeFEycEjX4jNAHuhkMBxNe/0yR8zoZnSB3PBYRFASlFfuW82bnvL5
	9c96rkiKU6g==
X-Received: from dlbsn12.prod.google.com ([2002:a05:7022:b90c:b0:144:e376:2668])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5804:b0:39e:6a7e:ee1a
 with SMTP id 98e67ed59e1d1-39e6a7eef7fmr9312264a91.38.1789967286386; Sun, 20
 Sep 2026 22:08:06 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:43 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <9d719971e25d7452b00b3d669d56a096f50353f8.1789966896.git.irogers@google.com>
Subject: [PATCH v2 25/49] perf python: Port failed-syscalls from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/python/failed-syscalls.py          | 91 +++++++++++++++++++
 .../shell/test_failed_syscalls_python.sh      | 81 +++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_python.sh

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..aec1dfbff551
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,91 @@
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
+        try:
+            self.session.process_events()
+        finally:
+            self.session = None
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

