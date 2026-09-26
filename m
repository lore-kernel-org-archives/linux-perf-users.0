Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108B39E16B
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403697; cv=none; b=sAcrHPxjQW6wH5ioOdo648VMr4iuU01ra0cx8SbWfajjVqwcyl7imA5ez0h0/PaCnSTY5m52T1LpZQ06Pz/Tmh/fEjjQYimDDUfWkvwsHT/Gbl2PIs5S1OcBT+p/8p9TBzM45LHhlh+yO/1O3lldd5p88jrT93BY5yC7zZvrV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403697; c=relaxed/simple;
	bh=pAq99FGricV4DtVZQ5r6XtCB7Z0x8bMjRJDQV7k5IH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RRj1Q03Dqx7FsoH1+zcn3ljYjn2/bi1dlNw2mVP1y2M+6xO5tAlncUlSxufeB28RFaHOd26n22TFh4Qcb0A5Li8oZXLojVbswTAj/6SkfROKEo2kkmCqJuGwTsiTDNEGJZoVjy6bo6csXBljJ/SSf2kl5CQp0qj1gCPQRARS4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnbVAe8B; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnbVAe8B"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-143826c4a13so1305057c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403694; x=1791008494; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RIqQ8S0ryjMDBhu/T3MQxHUCk7b3KMlk8nqdhZ++QI4=;
        b=EnbVAe8BK43J3YYaWiuts6hvjqn6Wlxct09A48t9gLQg2zZbY/bBgeRFRwaKBEltSn
         glYSf1vhAOK9jW802H7uDktdExqNBsUAn4Kcc8HrvcBGoCiCLHakyQ7p7gvVS33yygeB
         HMSgYFa8I+stQWKO97G9/stID8tGjO3+nS/txVyjqD4ZIHDcXOfvyyS0cGQabzdEtwaU
         uzjZTlxfLWGLooSy4M4qdfpMVCaOTQwsmxG9ezTVH0tBA0ILYB1+BxtJcmj5dl68X9q+
         5yYgJnGA442R/hek+dpePC8DpYofrmwJRUIXFRTxCjLaTKTgeNsvx4AyWqIS9q4B5blB
         ItGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403694; x=1791008494;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIqQ8S0ryjMDBhu/T3MQxHUCk7b3KMlk8nqdhZ++QI4=;
        b=N1LoAblbGweaF0rzxkCoDivjo0zNC9xgmqfXn7e+ceECbd+HmQNHnunBF+aBlJVaYA
         gkJkWEmqpxCdzbqfic2WqO/Z3gLrBnq31/v/JYsFEReneEq5OMSXP5vS3woZiUZiHDdu
         AxG0l+06lvSMntbJHjm1qeE0ujsllB+RiwTMeM/Kw8WKHulSv8SLq0iKNQ6QgTO9747b
         qFs72prsSu72/jQKEyiLiA429efjvmlkZziITCykMo9KLTgSY9SyqHQEpnyOpyPPXizu
         vOiW5QIyzEgnvfhKq5UEc0RGwDYXLbOFY9JK/f4obgf7PGiazzIIioWwzwPCHgXMCmzo
         /41w==
X-Forwarded-Encrypted: i=1; AKwUvBwp+m//rM5+sBuma9LW/ztCOtCA5WlRdIC/N1WPJ144olTbQgNuslmN5fW2ecuLBvW0jslt9mkT+RoA4CMzgavu@vger.kernel.org
X-Gm-Message-State: AFuF++kewOFsIqPLm93/PP3Tj34Uy9cxJdTWepbQJKQ2BYW3RYT0Y1qM
	20ovZCfVuVZebK4UW+7wNNwMTy2kILx3ki+ULp2g+WgUL1mhJQDeEYkVEG/olYs40SOi52NOmK+
	E+ygSozdMeg==
X-Received: from dlag1.prod.google.com ([2002:a05:701b:2501:b0:144:d82d:aebb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4346:b0:13e:aa58:89f8
 with SMTP id a92af1059eb24-146ce86dbddmr1609696c88.15.1790403693890; Fri, 25
 Sep 2026 23:21:33 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:45 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-19-irogers@google.com>
Subject: [PATCH v4 18/49] perf python: Port stackcollapse to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
2.56.0.rc1.315.gc6ed9934b7-goog

