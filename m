Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD83EF0B4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049363; cv=none; b=u4auZ58HFlohsHvoaVWG1ipNoQ7iFC8wvxuJ2n8bhutZtA5SljgiabjYHOQvB3U4g+v2h2Em/mN72I8CErvJo19uQHWFlVH6ectTmwyA9K/u1nG0L4Ln3lYw9W3duJuzDMTetD6B3g5zK48r+Gb730gkTux7kDZHoGZ8C4CO0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049363; c=relaxed/simple;
	bh=GFvGMbaEmGsRGb/lNY6Y3J48Xc+KL2u2ta9J2z5m3x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZdaCu4pkYqR3ExZwFErLF+kv4s75WDNpbs4vzA1Q5yuRW2WFJz712XvMZL32TZmw7s2zvnaWZnMPCqOGbDMy7Lj8PiYKO3tv8cFiGTTl8mFkX19CPOF/L90Gfdl/zh7bRVY+fsH1CU9gEZWX62GXiHIKjRkrirDP4wdf3z+kJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2mBNJAS; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2mBNJAS"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so7786129eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049360; x=1777654160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMY4VEqc6R5YuPLO69SDBPYcLChwUILoRIT5/wHkEUI=;
        b=r2mBNJASOZHTWhNHfG5FISLYziw38PGRKcDTIK60jIzdxrjOAUYRBGWzY+JaN9JAco
         tH6kt31dNgFEEiVf037A78XSO4jJTZ+jf0qe29PlUU6hTshC6h/tvRpfdUjXcjw49hll
         dIn4QMSVEiQVUKDllb5MmDzPTIvGbdV0+bEDjgeg2N2FwcgbxWJopNILDGajR7PMr5Hq
         0tPzsHHS4v54IZJSxlhwA62m10sak62648iOC2hhfghvj/oyCMstaa1mUJ5WuzZ/zYH8
         WFEQnARlpbhy9kYREqJLf6MKRceAKX5+B3eAPBu5nLkZGXqjXlXk8FECrRQNJ1/W4M+z
         kLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049360; x=1777654160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMY4VEqc6R5YuPLO69SDBPYcLChwUILoRIT5/wHkEUI=;
        b=XqBUSw8tW6XCjl9PfNzjtOeVQa6u1R0DM7dH0e5rkHLGgpnMCdiuZSVWPXDLaFV4W+
         gIyn0cd75bewLs3vkeGv4U8NJNMlNqjNnyGUKtsae3lA56I0eSHT2Y0iBW0plaOE6pwz
         scxDZpsyMliQ+r5LE6plhDOqmmxzliTq+LTIKYTOKVmzQEYcDVDtBhTiEaAXUfsU67z9
         CzZNKB0GX9K2M05ujROUF3urExXFPbfg0v30EV+B6xXpyU5xkHvPHJUkmITDU+tjFAqK
         7J0gnoZdR3ul9oCgSJy7sekDxjdDY6eHf34P7sQxBr+4Ra1Zruk1q751Ymkn09TETxVM
         pMFA==
X-Forwarded-Encrypted: i=1; AFNElJ9kAUBxgc8T04seRdkFBUHZ1L2UHWKqsj5Ze+kyA1wj99yrsfhAyV2qLOn5UMI82XBhd/RvrxhO/eJhYgdK+2M7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/du7KR10+SH00I9Gk0kynXHPZiF/vU14FyA8qUp6z2IwKYF1c
	skAqdSiSBIQe0GPnRVNNhNuh9sNVWGVkUavjdhEyMAvBy0qAKWRU3UMAHFvXI4Yu++4UFj0LeQk
	9/NBHRO8rWw==
X-Received: from dybgt36.prod.google.com ([2002:a05:7301:2224:b0:2d1:6536:ac8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4011:b0:2e6:e916:70ff
 with SMTP id 5a478bee46e88-2e6e916770cmr10884574eec.28.1777049359938; Fri, 24
 Apr 2026 09:49:19 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:07 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-46-irogers@google.com>
Subject: [PATCH v5 45/58] perf stackcollapse: Port stackcollapse to use python module
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
index 000000000000..fae0f0f503a3
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
+                comm = self.session.process(sample.sample_pid).comm()
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

