Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F54334AA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187232; cv=none; b=ajqSnJ7c72pVvLvD6JM24F79h4gnnevCYJytkE9Hg8tsNUn/3LuM/MZhvzeyBnkGOQhQZjQNLMjMFgKmFjO27n4ZJPRdpC9bAseHPetWkujZud10ZppJfi8qUp6D8ucOvwQj5dQlzcIWYqpLBbHLZ4AnfkOa1keWwW0IEhlpNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187232; c=relaxed/simple;
	bh=g12EZvZekt6R/6wyFoyXy44IWH+l5NQMFBBy3pRxGyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o+DTM6PwzV3bJfkVK/qEzD3AI3ubr4l2Yiv2aozHp9EdM3f8pJAPLNDy6jVNfIYwxmztFH2wCtcQR3lUrcDmdBzYmuTi5wD4WehCYG/lb/w9Gsc0EaTaPyXRlMxSOaqBKpZsz5woCCXCv+R0bTaUJbotWu17x+rpPHegGxGGwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vf3tPsXP; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vf3tPsXP"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1740923eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187222; x=1790792022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKre0Si3CV+o1WG/2WLKOz8R0ZGc2BI5qcqtES/NRKo=;
        b=vf3tPsXPSniWsRyBBhDE+I2RPnc0SfdOpXqCDdbXAIRvdpNiIXMGbijU3Y2HO/qw51
         /qe01YQvidWeC/tZ3Lm9S/52FSJmk4uLo3xbWu9rZcyHsv6s8ylSJsgUfHeqq3e+mqcB
         XtFfMUK3YGAkRVRIdD3gZINHkF6mynpTXuu9UexpE1kv5yODyA/WIcG4U3dTET/GWrT6
         a9sUKcTj0H8ryCr0GcXwK3TUQHofkp9WHNTtsr25QPOd90Blow7zANshWelIQi6o11xP
         wafUYEqoZwgDPbYsbS/8AYi4tl3DGIKn/KvLppmHffZvjQfU5XUptU1eg9MnuZLfnujP
         HKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187222; x=1790792022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKre0Si3CV+o1WG/2WLKOz8R0ZGc2BI5qcqtES/NRKo=;
        b=ZRcpuTmfbuJSujCe2AJpqf8IGDeOf6gi7l0ROSeHmqAJxFj7YkxFk6bRHByRdWPsrD
         G3CxxdDaFyoiHvKW7MpOvsTMjSCEzScSv3qApoG/vNlXR1XPOv53LfO3p8SC3SKBRFbr
         V6bSjhQ6JjxCqmU8u5bmIgKTQStE2cSOHBBB6DRv4T1Spm8mvog8MAC2D3bJnE9tpTko
         ec3ueLavf1lCI56rmUN0fUJYM6o+wQ2AJbZ2a6PyUnHfThoQVovt1jGcD5r2lsMPyppu
         hXYIrcky825ji9jAQ++ObVFguJHPaVi++rcChE+WQDH8GolAa2lvRhSX3+o0pS0P1HTU
         JS+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZW/nRPSvJqa5lNgaRUZ+n7ECNlfOzGyzzGw3xroczAqld8cnPrNJ4+F+HvQoVLBNrobB+nMapEyw3Nkmy6bb2@vger.kernel.org
X-Gm-Message-State: AFuF++l5anDDJ45+xtYDyAQ9gtHbcyRkY63XOGYNISFy3/4oJXVvUd39
	NifQugl7amZqeg+jZDKl517Uac6khQxFxzTgyIYvHGyDpOhoSmBxAq4gpXXPfZwuFNe1lmciBhj
	8TW8pRrEYSA==
X-Received: from dlbts8-n2.prod.google.com ([2002:a05:7022:b048:20b0:144:d7ab:e21b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1402:b0:143:2719:566c
 with SMTP id a92af1059eb24-144f9198b49mr3512891c88.40.1790187221594; Wed, 23
 Sep 2026 11:13:41 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:41 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-19-irogers@google.com>
Subject: [PATCH v3 18/49] perf python: Port stackcollapse to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port stackcollapse.py from tools/perf/scripts/python/ to a standalone
script in tools/perf/python/ refactored into a StackCollapseAnalyzer
class.

Improvements compared to the legacy script:
- Traverse sample.callchain directly from perf.session without
  allocating per-event dictionaries, and fall back to sample.symbol when
  a sample has no callchain.
- Replace deprecated optparse with argparse, adding -i/--input alongside
  --include-tid, --include-pid, --no-comm, --tidy-java, and --kernel.
- Handle BrokenPipeError cleanly when output is piped into downstream
  tools (such as head or flamegraph.pl).

Add a shell test (test_stackcollapse_python.sh) using a CPU workload
(perf test -w noploop) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/stackcollapse.py            | 145 ++++++++++++++++++
 .../tests/shell/test_stackcollapse_python.sh  |  78 ++++++++++
 2 files changed, 223 insertions(+)
 create mode 100755 tools/perf/python/stackcollapse.py
 create mode 100755 tools/perf/tests/shell/test_stackcollapse_python.sh

diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stackcollapse.py
new file mode 100755
index 000000000000..0e8a65969db3
--- /dev/null
+++ b/tools/perf/python/stackcollapse.py
@@ -0,0 +1,145 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+stackcollapse.py - format perf samples with one line per distinct call stack
+
+This script's output has two space-separated fields.  The first is a semicolon
+separated stack including the program name (from the "comm" field) and the
+function names from the call stack.  The second is a count:
+
+ swapper;start_kernel;rest_init;cpu_idle;default_idle;native_safe_halt 2
+
+The file is sorted according to the first field.
+
+Ported from tools/perf/scripts/python/stackcollapse.py
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import os
+import sys
+import perf
+
+
+class StackCollapseAnalyzer:
+    """Accumulates call stacks and prints them collapsed."""
+
+    def __init__(self, args: argparse.Namespace) -> None:
+        self.args = args
+        self.lines: dict[str, int] = defaultdict(int)
+        self.session: perf.session | None = None
+
+    def tidy_function_name(self, sym: str, dso: str) -> str:
+        """Beautify function names based on options."""
+        if sym is None:
+            sym = "[unknown]"
+
+        sym = sym.replace(";", ":")
+        if self.args.tidy_java:
+            # Beautify Java signatures
+            sym = sym.replace("<", "")
+            sym = sym.replace(">", "")
+            if sym.startswith("L") and "/" in sym:
+                sym = sym[1:]
+            try:
+                sym = sym[:sym.index("(")]
+            except ValueError:
+                pass
+
+        if self.args.annotate_kernel and dso == "[kernel.kallsyms]":
+            return sym + "_[k]"
+        return sym
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Collect call stack for each sample."""
+        stack = []
+        callchain = sample.callchain
+        if callchain is not None:
+            for node in callchain:
+                stack.append(self.tidy_function_name(node.symbol, node.dso))
+        else:
+            # Fallback if no callchain
+            sym = (sample.symbol or '[unknown]')
+            dso = (sample.dso or '[unknown]')
+            stack.append(self.tidy_function_name(sym, dso))
+
+        if self.args.include_comm:
+            comm = "Unknown"
+            if self.session is not None:
+                try:
+                    proc = self.session.find_thread(
+                        sample.sample_pid, sample.sample_tid
+                    )
+                    if proc:
+                        proc_comm = proc.comm()
+                        if proc_comm is not None:
+                            comm = proc_comm
+                except TypeError:
+                    pass
+            comm = str(comm).replace(" ", "_")
+            sep = "-"
+            if self.args.include_pid:
+                comm = f"{comm}{sep}{(sample.sample_pid or 0)}"
+                sep = "/"
+            if self.args.include_tid:
+                comm = f"{comm}{sep}{(sample.sample_tid or 0)}"
+            stack.append(comm)
+
+        stack_string = ";".join(reversed(stack))
+        self.lines[stack_string] += 1
+
+    def print_totals(self) -> None:
+        """Print sorted collapsed stacks."""
+        try:
+            for stack in sorted(self.lines):
+                print(f"{stack} {self.lines[stack]}")
+            sys.stdout.flush()
+        except BrokenPipeError:
+            devnull = os.open(os.devnull, os.O_WRONLY)
+            os.dup2(devnull, sys.stdout.fileno())
+            os.close(devnull)
+
+
+def main():
+    """Main function."""
+    ap = argparse.ArgumentParser(
+        description="Format perf samples with one line per distinct call stack"
+    )
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("--include-tid", action="store_true", help="include thread id in stack")
+    ap.add_argument("--include-pid", action="store_true", help="include process id in stack")
+    ap.add_argument("--no-comm", dest="include_comm", action="store_false", default=True,
+                    help="do not separate stacks according to comm")
+    ap.add_argument("--tidy-java", action="store_true", help="beautify Java signatures")
+    ap.add_argument("--kernel", dest="annotate_kernel", action="store_true",
+                    help="annotate kernel functions with _[k]")
+
+    args = ap.parse_args()
+
+    if args.include_tid and not args.include_comm:
+        print("requesting tid but not comm is invalid", file=sys.stderr)
+        sys.exit(1)
+    if args.include_pid and not args.include_comm:
+        print("requesting pid but not comm is invalid", file=sys.stderr)
+        sys.exit(1)
+
+    analyzer = StackCollapseAnalyzer(args)
+
+    try:
+        session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+        analyzer.session = session
+        session.process_events()
+    except IOError as e:
+        print(f"Error: {e}", file=sys.stderr)
+        sys.exit(1)
+    except KeyboardInterrupt:
+        pass
+    finally:
+        analyzer.session = None
+
+    analyzer.print_totals()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_stackcollapse_python.sh b/tools/perf/tests/shell/test_stackcollapse_python.sh
new file mode 100755
index 000000000000..a3b6c917e842
--- /dev/null
+++ b/tools/perf/tests/shell/test_stackcollapse_python.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# stackcollapse python test
+
+set -e -o pipefail
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
+script_path="${script_dir}/stackcollapse.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, stackcollapse.py not found at $script_path"
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
+echo "Testing stackcollapse.py..."
+
+# Create a perf.data file with callchains. Use a busy workload rather than
+# sleep, as an idle system may not generate any samples at all.
+perf record -g -o "${temp_data}" \
+		-- perf test -w noploop >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes with default options
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "stackcollapse.py test failed"
+	err=1
+else
+	# It outputs stacks like: swapper;...;... 2
+	if [ ! -s "${temp_out}" ]; then
+		echo "Expected stack traces in output, but output is empty."
+		err=1
+	else
+		echo "stackcollapse default test passed."
+	fi
+fi
+
+# Test CLI flags (--include-pid, --include-tid, --tidy-java, --kernel) and BrokenPipeError
+if ! "$PYTHON" "$script_path" -i "${temp_data}" \
+	--include-pid --include-tid --tidy-java --kernel | head -n 1 > "${temp_out}" || \
+   [ ! -s "${temp_out}" ]; then
+	echo "stackcollapse.py options/pipe test failed"
+	err=1
+elif ! "$PYTHON" "$script_path" -i "${temp_data}" --no-comm > "${temp_out}" || \
+     [ ! -s "${temp_out}" ]; then
+	echo "stackcollapse.py --no-comm test failed"
+	err=1
+else
+	echo "stackcollapse options test passed."
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.56.0.rc1.310.g51773c2048-goog

