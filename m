Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF63D88F2
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881792; cv=none; b=Y/Jv5Kzapg4/SW/LwP0QZ3Nz0xZJKiEdLLhohKzLes+xiyTaLTtdlMwrSVWyYLlkKgmKz4SXPHNc9YLjdtcte9d0hLVVxSnLnsYIV6IJNBRgjlXzo33qM+x01gsjmNl5IyEutVKybuJ/bEAXW2bLW63fy671EsmvstXIniQHlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881792; c=relaxed/simple;
	bh=RyF8lGE9kLPt0aNcxuQeNxim+YMoP4Kt7L+sy29FvFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEbatn4DG9eOB1IreTWHFu0wbkOn09QLljDY282d7qvgYlz+fFxi97oL/vrM+wscFu8invgm7IHILmuY3v9pa2fo6p/cPXDL06dberPflgzK5ggKFjWg0QEJGsfK+6KCRqAq6N3/4F21k9qK7E9uT2XBz5QeyOWhBTwtmI6oW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vh9S7xEv; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vh9S7xEv"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso3863280a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881790; x=1790486590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yXD9J6EnD6DNamnRXUvl7fcISLFv+AY3Nw9l52pGwA=;
        b=vh9S7xEv22lzRljzWDw6KhctORhnkZlholwyvwTi7OA5h1FKOgUT8HYyv2j1QTJ3Ml
         MW0/qbQ8iPbTGIKU2FrLnHpoHz+J5OT9+oICCYaK0oK9qKioDmyVd0lOsM7RIHW4yYPg
         kFiXRqPjsGGRoEJg0LRp2mppAp9IBSMki7fi3LpzoG/t2Sgk0tP9lkG5RqsFNvqOX9u7
         IhIs+jIZKf3abVjji5AiddJW6DFrAA3bpeJ3cUayhFjjXj66CURUsIyiu+96ZAqZ6pyv
         D9OonKGgJ25y/Q44+xSMAaFXjnjKR6e0JX8VMW/tEL8rC6I3DlBfUUYaJuszF1rgb4KR
         6TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881790; x=1790486590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yXD9J6EnD6DNamnRXUvl7fcISLFv+AY3Nw9l52pGwA=;
        b=ns1Ejh++ZVCir53t6V2mLVDMSjlI27PuUPtlvOSh9UBda0AD1XlSsjXe6g7HaEAbun
         26tfxr89/F0kWQujKdB0BmO9v2CMZSEwx2c4bNvbMCWLDb6n6T4FJABIYzvh5IDm8jaJ
         x5YBwlSA7qugRQzPIX3mmFxKjgHbAy5nUEQwYK9KR+MeOirWA0kebd9o7lYHiiNMH/MX
         gV8sKE6422MxthUYoSAJb2wUiAPOxVupBP0b6DdzzhfFOkK6MlE4fmcqpqXSRzIyktwO
         jiT0iw1J1nzGBfnTqudQLo1mi0T682usF0LAgfdq39jW8i1kOjxT+9VPUcJOh23bccB7
         w61w==
X-Forwarded-Encrypted: i=1; AKwUvBxg7ImLq4kw9stfsgzcP1rr4dXxETXZPJgV/DSUFGNTQc5RnO8cyMCoHpAiwcOWZJ5NJ6jidj6ZYTWeJyoB9Wts@vger.kernel.org
X-Gm-Message-State: AFuF++kJE3loPmxG81gf8dEF6Pg266UCOe+yOh2Qgf6VzkFYqIdkDhvD
	sMFGvBtRhO/CRUWWdm1LFSIFitCQaEC3uckzmfxqWlmWvssrlzZP4lYWs18zBNXRZXkMXPqRd5h
	5iH2K1SMh6A==
X-Received: from dlea10-n2.prod.google.com ([2002:a05:701b:420a:20b0:144:ceba:493a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b8c:b0:39e:4c7f:8b1a
 with SMTP id 98e67ed59e1d1-39e54d4c6e6mr10444504a91.31.1789881789851; Sat, 19
 Sep 2026 22:23:09 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:10 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <179539c02f8b44ab0ccdad1b686f22577172bcc3.1789880842.git.irogers@google.com>
Subject: [PATCH v1 18/49] perf python: Port stackcollapse to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
 .../tests/shell/test_stackcollapse_python.sh  |  77 ++++++++++
 2 files changed, 222 insertions(+)
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
index 000000000000..e5675332e3cd
--- /dev/null
+++ b/tools/perf/tests/shell/test_stackcollapse_python.sh
@@ -0,0 +1,77 @@
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
+elif ! "$PYTHON" "$script_path" -i "${temp_data}" --no-comm > /dev/null; then
+	echo "stackcollapse.py --no-comm test failed"
+	err=1
+else
+	echo "stackcollapse options test passed."
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

