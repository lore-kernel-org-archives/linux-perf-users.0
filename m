Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C838F65A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157114; cv=none; b=pABUbnPPf1j4rFiSfBB24mU/dQATCSj0LDC/KT9720XdW5TzCHPGlMJ79HQ4hOpG3ObPxrNvN86IwtyI2M/9jLnWoyBDYsUMWA9xfa4hbXsntcejo+hB2ymqcalBdOkUe6jDw7jt772Y7IMxJkm06/MHLOmylYGg7H85t09ZYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157114; c=relaxed/simple;
	bh=5gMnnOsYKM+JhLn9wx2zoIzOqskbDsFXIF1JO3ndg5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T8rdyAppDRrwpCjf9sAyqAMlW3D07t+AqJHlgKUH8XpF6jVm2YY9oY650uiOLGlppuAAAarFhkxgx1K3cK0qM+jxjoBWUwlOns6SLsxouylR/rdg/H63+HFZyLDnbolWPiI5gw2sBtcxg5YbpiUwUF9ZV3vK/c5gl+1KdyNTJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvHEUZwQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvHEUZwQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so33844431c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157112; x=1777761912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeNxtOSoOXwV2zRr64LvO5u7apubipAzZoDUg3KnRw=;
        b=NvHEUZwQQJif0Io6jZN07e65ZxWjpL/m9Hw/Y/ICJCve7vXU220ORIs67V1F0skhmo
         nT3SKNheSHBY8BBn9QDmXI/EfZ0BxVXFhLcb5W88HOccrOqKXzKMpU5ZWtkekhzcvX3s
         5O+3Dsn4p4CGBbdwEtNxD5WPjQzj+Wrk4JNx/B5lTKn+5K1+lw/ZOlTcFw100t+w24qu
         ZaDl5UPHJHieW2fg8fUQQ0fJXyU7v0sKed6bFtiuMuu+nbsujsalCnfuwGHSYeofz7za
         B16Q2zWPCoivnDJY2PVvRir8aWdzinLNKg62PpYoBIUXW001k7qfyDS6Ze+lX1VCKEUc
         7iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157112; x=1777761912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeNxtOSoOXwV2zRr64LvO5u7apubipAzZoDUg3KnRw=;
        b=oyM6lVxRwlSHKHITbgUxS8UOCzjByM6iCo9AGiHJAGGDPIo3H2IxCMSkouli9pd2RB
         QcC0/VEh5PYxfyWgDrjBEWf0xHzVtGzCh/ER7eozmbE5birwDIJBSNo6MqqqNVIRFhT3
         SGbdzqi03qcpvpM4n/+KqbFHhn1VT+f8t/ygo9FV1hmCPwf0ZCSp9YsgtucFQnw7CL6q
         lK8s94x+jDdNYgwCptwoURFClm1eGSfnCENBqDyrAnexMRAQDuPySnYjaaUOZ0Bq0ZaR
         8YqAXKbdM/BLlAQ65rf5R0cde+6eTnTJFDIgxXRggmjOp3Vju2cr+23cQAos+bmY9NKL
         y8dQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vJwCDiBlVpe4do7iaDJKE1RykO8rkirR5dL/K1o8vWiiBvJPMZSFEYmpKsMcMSx7dfpCvtRf5nZfahsuUbi+A@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6fl43ICWhOEHRdmQcdJ4ji7MvCcK40IEwBIJZVfYQUSz19J8
	N+xncn2LdDh5wZUV5SGrICDjl9s3S1pFgm85kxdZTL3fobCh2LCUa7VZEzbmwAzvTDNwtLUPujt
	xaW3BRaRxSw==
X-Received: from dlbur21-n2.prod.google.com ([2002:a05:7022:ea55:20b0:12d:c516:f51])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6728:b0:12b:ec67:3529
 with SMTP id a92af1059eb24-12c73f781e0mr20677481c88.14.1777157111966; Sat, 25
 Apr 2026 15:45:11 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:44:49 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-3-irogers@google.com>
Subject: [PATCH v7 45/59] perf stackcollapse: Port stackcollapse to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Modernize the legacy stackcollapse.py trace script by refactoring it
into a class-based architecture (StackCollapseAnalyzer).
The script uses perf.session for event processing and aggregates call
stacks to produce output suitable for flame graphs.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed Callchain Check: Replaced hasattr(sample, "callchain") with
   getattr(sample, "callchain", None) and checked if it is not None .
   This avoids attempting to iterate over None when a sample lacks a
   callchain, which would raise a TypeError.
 - Fixed Comm Resolution: The code already used
   self.session.process(sample.sample_pid).comm() to resolve the
   command name using the session object (if available), avoiding the
   missing comm attribute on perf.sample_event.
 - Code Cleanup: Broke a long line in process_event to satisfy pylint.
---
 tools/perf/python/stackcollapse.py | 126 +++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100755 tools/perf/python/stackcollapse.py

diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stackcollapse.py
new file mode 100755
index 000000000000..996c73246ebc
--- /dev/null
+++ b/tools/perf/python/stackcollapse.py
@@ -0,0 +1,126 @@
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
+
+import argparse
+from collections import defaultdict
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
+        callchain = getattr(sample, "callchain", None)
+        if callchain is not None:
+            for node in callchain:
+                stack.append(self.tidy_function_name(node.symbol, node.dso))
+        else:
+            # Fallback if no callchain
+            sym = getattr(sample, "symbol", "[unknown]")
+            dso = getattr(sample, "dso", "[unknown]")
+            stack.append(self.tidy_function_name(sym, dso))
+
+        if self.args.include_comm:
+            if hasattr(self, 'session') and self.session:
+                comm = self.session.find_thread(sample.sample_pid).comm()
+            else:
+                comm = "Unknown"
+            comm = comm.replace(" ", "_")
+            sep = "-"
+            if self.args.include_pid:
+                comm = f"{comm}{sep}{getattr(sample, 'sample_pid', 0)}"
+                sep = "/"
+            if self.args.include_tid:
+                comm = f"{comm}{sep}{getattr(sample, 'sample_tid', 0)}"
+            stack.append(comm)
+
+        stack_string = ";".join(reversed(stack))
+        self.lines[stack_string] += 1
+
+    def print_totals(self) -> None:
+        """Print sorted collapsed stacks."""
+        for stack in sorted(self.lines):
+            print(f"{stack} {self.lines[stack]}")
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
+
+    analyzer.print_totals()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

