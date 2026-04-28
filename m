Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917740243B
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360852; cv=none; b=Ky3yJHeGb6/HGXJR453JECsvjYclsZYLpmML9qij48FiB5cWFQwbumX2wAsPatJo1HMCZPdFiRnSAeS3Mw5GPehURNqmLUm3jIOu9dI/Rds5FF8JOjvYYQHFAmPMmS9JQ4Wk6w3mm41GeImsPlRgBM8hvdx7N9ZFhdn5UKAAiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360852; c=relaxed/simple;
	bh=5gMnnOsYKM+JhLn9wx2zoIzOqskbDsFXIF1JO3ndg5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xg0A+XC8vSyPEml5hx+81zFrBXYN5bkQAOTZiJfWkmTvqHKW9ukL05G59z8brx0SJBbOOLRbf9nq/TaSsA9bFs84R7n3AGKaU9CbyEtCtQzjQRaiTXYADp/4SYH10KJJZqPgM0mBRKbfS/Vwk/UwrUGlv/PpNc6o6QdEKH6moGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHky0VWy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHky0VWy"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so14539075eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360850; x=1777965650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeNxtOSoOXwV2zRr64LvO5u7apubipAzZoDUg3KnRw=;
        b=dHky0VWyQI5FcG9S2z59rUfIkSJmTaAwPA696eMFEd5D0FFvHOfDi9aQo2CakNNuq6
         rBSCQFa1wmxcNWZa8O+Mcn6F3b6pfUH/QUWuE1Z1NzIidsLepQ0jPUVNMrVVFQbQEaB8
         VbFXfDF6c5CKJFCRnzRfXJW8dT1MwWHWb7PUEw4r8xhQsgmFtxOIE14YKvHpOFmLkkbh
         Q8il87Fv07asgXD0ObTZ0WNV7rDbCEl5LvD68SplnkwP3NFEWITHKt3Pz7hvNL57Vp+K
         lAqFkAgrZ9ofe9Godemq9CYrvisQq+Im4HaEA1hHlFOZk/TOrzvzcVLCTblpmYUWq+K2
         F8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360850; x=1777965650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeNxtOSoOXwV2zRr64LvO5u7apubipAzZoDUg3KnRw=;
        b=RO8VNXUqkIKykI0FG8Yuv3nqeQe+rzkoaEycJsztcewfGP3QrfQaIifQTGt5ANH7Vm
         gH70oVynzfsd/HiWnaLtpu9hmZaOh1L1PlcNOR/Ji5Vdyklm1qEq/ldK+HZ2mCjEMXQP
         VaZ1Bv4lsQlBWRtL834zb6/xSb7IVnSbbN2Ax5PqHZXb8+OyWlIUJuNyeTlDmccebsld
         AxeIcPm06psvqri1l1BU1vHTgCqsyKzZ+6eLZyIu0N2L+3fxd90EieGvhVZVThrFqvQ4
         +WWW7xq34V/RaR45AgKAX4FkdzbnHjBLYo2jJLPTBwPeKxPK2Xw1+dPoHT/kz3+BgLPN
         1lgg==
X-Forwarded-Encrypted: i=1; AFNElJ+xPvCD9iC/+gGWFavcpl0L7T/gcLr6sZMGUKFdgpp0G0vsQgoxO+MmLF1C3Jyy13baAvYK8gseaqsGuG5fWb2z@vger.kernel.org
X-Gm-Message-State: AOJu0YynM75KN2iZxpCdOWUle8aUiQXveUNDMDt6Cf6TEQW/z3o5o1qX
	iKkCVZDJqUPn+BePPbR1/lrSNdIA255kYCLksxrb9+cXATcR9xvZDnSMHnkFVCCqLnggd+O6Sgt
	Y9KlMkNdgpw==
X-Received: from dlbqc1.prod.google.com ([2002:a05:7023:a81:b0:12c:87ba:191d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:251f:b0:12d:de3f:d84b
 with SMTP id a92af1059eb24-12dde3fdd81mr457375c88.36.1777360849585; Tue, 28
 Apr 2026 00:20:49 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:50 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-46-irogers@google.com>
Subject: [PATCH v8 45/58] perf stackcollapse: Port stackcollapse to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

