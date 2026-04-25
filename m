Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF0397695
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139433; cv=none; b=O4EXTraefX+L4tzJl+Cmh2g0B9/fsfN7oZnH4KWEsF1g2Yi3Au6N3LGgBGYwhuZ2steFZVucnycti74rOxhenRU06+e/+Rf9SYFrkRNs7hgugBtVNFo7PYU1eEPJ71NqVvXPkiqVz/nnKMBgpeBRfdtyF583VM//Lmf9WtgNAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139433; c=relaxed/simple;
	bh=5gMnnOsYKM+JhLn9wx2zoIzOqskbDsFXIF1JO3ndg5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9fdeEhfZ+wPFu1Gd8GEbPhBoK9PZ6wHoHUIwLOW3ugLpWvVRKfnfNSAFgsoo8oT/R/TIA5kiD1EuEVZOhR8dfKfVjcvdvhdc1PIEzg8WdLtIgFUpKgdfPwcfD6x3S1ONaaHAmg8QsSSE9AIg1Ah9WFhA18CF94yRWajN7xSaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEpXGBg2; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEpXGBg2"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so15187541eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139431; x=1777744231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeNxtOSoOXwV2zRr64LvO5u7apubipAzZoDUg3KnRw=;
        b=tEpXGBg2YVJRw2sBe7O0eSIjHEX1ZGzl2Ik922kiXKWB3PtTGja1CgOIi8QOAuiRCj
         SnvPFS9EIqinQoFEe6W7a/3msfQK1CS/MCH/jl7RvpHSmrlR1XsHf4ATc/SBxw4NRyuD
         XP7vwJMVB22J/UAW03ZfHdybKBDUKVKiHPMJrLafkxZT8KvdWDmHU+Zex36doYGKGchn
         IfuUX89tcac/0dLnZnw5QBqnlReXju03WKVaugQt8fy0P6C1RdZ/aQFcIpuawnwdHQvO
         2fxUqjNvIbPSnGnVCOleCLtyI5pjmyG3TAv7LUW3WukF2X7bvEqTeteB/BxCUz+qRhyz
         pFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139431; x=1777744231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeNxtOSoOXwV2zRr64LvO5u7apubipAzZoDUg3KnRw=;
        b=iw5TVCGsqO6udc3HmBpNyinZfVRMRkOjEL06mZJUS9/0FWSd8n6WBV+kBItK7ikm2S
         MFPHEPJDErSrFbw7rjouJZaj3PhEUDL8EGwP5vcksuvuLzTivweyG1LzkLbri6IUYtfq
         upZS07xB0I6GEo/msC0L+pGeYY/cXlaV+uyU+YwF1t3uFoIRmO4KygnATQfy7gt/y2Xp
         J8eMgyg0ALhFAIVyiSrB0CDNeoOWwqose3ZJWJieCSUPkICQ/Gg0xEGetJa6XfvXxXmb
         LJfskhq/B9BrXkDN5wUrxfPnHAhnM0gzOyDEzt3WXlkXlUdbAXbulQypFcOB/hV25gpI
         3H1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9sRnShZF/ZYM42hfhiNUf93INk/KPr7dBaAhStIT8V7T9V7dEWaA8I/5oVMku0A6L4LBYi3493Of9gI1ZFfb5c@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsIfbaaNmLHYOP0VUS3EWPtQOiJM2OjFL08VzZT/qxxlS+arK
	gHXVHOYq0H/YPlXQoNC5HQel1LLa3nvvyrHmy+p2+/t67UAnE8I+EB4m6VAmC/Ot4AZuXaIUyt5
	3nIs9/DqQBA==
X-Received: from dlbrl2.prod.google.com ([2002:a05:7022:f502:b0:12d:c3dd:4fba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:90a:b0:119:e56b:958a
 with SMTP id a92af1059eb24-12c73f82134mr19877993c88.15.1777139431153; Sat, 25
 Apr 2026 10:50:31 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:43 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-46-irogers@google.com>
Subject: [PATCH v6 45/59] perf stackcollapse: Port stackcollapse to use python module
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

