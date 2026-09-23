Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8253B352
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187254; cv=none; b=Q3JNIKD8vtoiH5iBY0I9ZLh2cVxMBeTjR3FELWpbBOohO9JTFnBx3lSTzNz4WGzdOq99s1GMzWUz7vMbc/2Aiy00pVM/tEEDPxX9cz6vHGnBgzYXKUQFCSlBwvrwU8qM+P3ugSxhx8jufsQKPUO8TpWMhlTZY+CokBL1AITyx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187254; c=relaxed/simple;
	bh=k6Lq0mjLpPs8bkUQU56JfbsoxyjRYR71H+Odv7TsItg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yapbg/5dg9r4OKx8sAWIC3hBNYcPIZhmwuDsAu0OhaT1i262UhbNkY4E/tiLqYUdDBby62SMLGr7/qFiQXu/09fBckceUzZHS+mJ8pVTIhBBjVoVjjsHklGU82mPZ+UBbT5Zv5Ozj0/BaKtmSI3K2KEsOOd0qCnnzz77pdsVkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOKDJAgc; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOKDJAgc"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-32850005b6bso1448583eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187244; x=1790792044; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqQJ31f6XsUcLvcdf8SgdR7hC8Tr53f+0TKVQ5bJtys=;
        b=SOKDJAgca0Uf84epw/E99CuJKQ8UA3XM27xCEGHpnnArHqdLB7Ckmzs4PmkuXWCy7e
         cDN+/zuutYiAv4yr+RjaZYr6rS+mXv1MEnrJNnn1f6yEh6aKkRWUhIIIlbT07+PeKRRn
         wWZpl6wQHsDZRh+hnvlNzqaczvJ/MYfhXjGKe6hU2yhnpBRNU7XP3/PlS3WidbjWITUk
         OC4CROBESKvmY3hfp1n/8Ng28btTjDBzUrdksa/7E2r1MzkEgyCpziNF5PNydGNOi/+n
         IprrjgljgUSYnfovMBxGfoHJfSKUzhJ++v6B/SX9fh7fRRL8kHemvcGqBFxds9PqEuw7
         N3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187244; x=1790792044;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqQJ31f6XsUcLvcdf8SgdR7hC8Tr53f+0TKVQ5bJtys=;
        b=rkmezbFAf6XnbwnfBNZ/LbJD5TYdbS6ygE9ikT+BSGWVk9yVaDUQGVvanYTJeWfmcT
         CIqwF3xKAE3KgHidojtScOtoFqfSbs+4RU+fc+/wPKgtyVPLADtY5tZELIC36w7+HxmY
         Pr4xEiIKktjL66osHvswlJlOluyYvvj8tO003Bxmv0xf5LuFqlx+CTjadHwa3VpkEFM8
         rrFKdIKpUqJ0yj+HujCAxmTLWWgIyHwNuAYgR7auqGigBssSBr+jK6m3OyEr3s5/RYVi
         6QT1NsBMM52GDhfCPM3FFTCnoeGPgR5rXGCxvo/18X2CKLCjjGPvDGFmlbVHYHZhuOsK
         A7qQ==
X-Forwarded-Encrypted: i=1; AKwUvBwC12SF+Lu2FtNcQ+9dzfMKHSxosUWKod81t1EK66vlzl2lzEescm8ByTAzqGVGznsL3Qlq4+BB29cncpi0Fe1a@vger.kernel.org
X-Gm-Message-State: AFuF++kJyglt9DKFvr37K4ZTtLoU6pTM4aiNdjJOKUDofZy+gcqYthEZ
	+U2Io0hwhsogBnoCifjT2zupDXRJXAjNXeGPQwr03F42LKV6zbd9TeVm03sZTcElaFoAFvObXya
	nghgoCHL0Kg==
X-Received: from dyay17.prod.google.com ([2002:a05:693c:62d1:b0:33e:55a2:f3c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:19a:b0:336:19c8:11e2
 with SMTP id 5a478bee46e88-33e8ddc783dmr3188491eec.28.1790187242980; Wed, 23
 Sep 2026 11:14:02 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:48 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-26-irogers@google.com>
Subject: [PATCH v3 25/49] perf python: Port failed-syscalls from Perl to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
 tools/perf/python/failed-syscalls.py          | 94 +++++++++++++++++++
 .../shell/test_failed_syscalls_python.sh      | 80 ++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_python.sh

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..6d1fa4e5ef89
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,94 @@
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
+        # Linux kernel syscalls only return error codes in the [-4095, -1] (-MAX_ERRNO)
+        # range; other negative signed values are valid unsigned user-space addresses.
+        if not -4095 <= ret < 0:
+            return
+
+        assert self.session is not None
+        try:
+            thread = self.session.find_thread(sample.sample_pid, sample.sample_tid)
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
+                                key=lambda kv: (-kv[1], kv[0])):
+            print(f"{comm:<20s}  {val:10d}")
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
index 000000000000..0cabb127d7e9
--- /dev/null
+++ b/tools/perf/tests/shell/test_failed_syscalls_python.sh
@@ -0,0 +1,80 @@
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
+		! grep -Eq '^ls[[:space:]]+[0-9]+' "${temp_out}"; then
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
2.56.0.rc1.310.g51773c2048-goog

