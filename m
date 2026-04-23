Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803283D9021
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916637; cv=none; b=L6memN791rtm0vQavPTNQcQiSheXSBkD5jw0DylM1ubbyaUm5S0LqIjxj/+TY4TuEHuN+x29AZTqbS1siWUpF0pd15gzKTlPh+k9T3ePR/GFF4gDiD3kHs+hwoyi9VopxFOA9GFIIsqs9FWjHFgpFzJfHvBvpey3BMvoWbLe8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916637; c=relaxed/simple;
	bh=etUu9aaVbb2krUU1kIEJO7MnJzNJy28Dtec3Urqn4qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=soulO0+gMThJ8Sh8D8ObsGSHsQKfuPFjkAdqIBZZrTOOcxvDM23SxBayEyDYefkAUlYJE5pPXHT+j66S+oEh6Ws/WEkTcqFIeQ0s+VqOBsWCx8rYBOy6Y0x6KxYqO4IbAjfsiY84/uvgw2ppZ3Jp4TI1/1dTeWG2yWvQcUqMun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuNwl8CC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuNwl8CC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dbf4f678eso3656857c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916635; x=1777521435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFOXYGy1B2tZwiZ2D0Q685i+dNKgnimGIYdyehFT1Es=;
        b=uuNwl8CC1BCX/Btqz1Vwyl8jnLZOnR9ORz95LuqNws2+WFQB88Pb7aIitEZCH7LZmN
         AlzzeoohxtBJIEjVDAZQ9k5gnI/MPeegi/x5WICfYSrFi+RPazDka5rUesruu9SiC/7W
         wx7ppAg1NqynOng5XJiqtJQz70bjgC760ROa/jWWJcr3Lvhf4UIxRKPn5JRi9dTY7jst
         dERGSSeSZKpypVGEEMDHFSVvrNYHPMQtqwoYHhXXnSr5wliae0TGi2f5mcVe9tScjwc4
         DZuxxqjP9cA70D1mfO54q829PkENJvAFKVUGoHGCzfGb7UecgDQU76RvkUgWdK+foId9
         S+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916635; x=1777521435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFOXYGy1B2tZwiZ2D0Q685i+dNKgnimGIYdyehFT1Es=;
        b=Ipkk5srZZdizGHpxMAVSLxv1IdGPd0RDPi6Wdh+XDk8RXnkbJduqhku27Z1SKlAscL
         2Q1xFM+Rk3o/i2PA9hkUNpgqM0cgXMjRVI4vuefZcLFUAFjR/i8HO69VzmpxPs66lELz
         is/Pnq1t3tRARnYXT5Oh4s7ioGl+jMg5jGrvXp5OF6QESyIoPWboZCeMXwQQv0Z4Vg3W
         U+2u8QxA0h93mxpYC4SCVcc4pnK5EnM4MbwaOSaNRY2IpfIGP0QvPe6yQhq4MWZAQc9U
         9Y2UAZdXs3bStfO6FwEDd+S58sRzxPatejRNvlVySYaA/CaB9lKroL21gSvTfD+u4fP/
         kQ6w==
X-Forwarded-Encrypted: i=1; AFNElJ/uJtefTLPMk5WL8uJSxG9PZaNJZaKPuf3AfdvZJqXZdd3/wkJoDPkP6+gZ1JC1kEITwvO1DfBsSvIo2cxWaNkw@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAMEUucSDOtIR6WowD36jt8whGcXv/GN8Dx1FVGZ4++ErrL4S
	4E6nB3+cQkhrdgPP5pt7OIp3WHUe/WwPjdvqZg6oQQCqoCdhRig/u7Eor3eacwCWndJNrOkAkUC
	pzvFxMsa+IQ==
X-Received: from dlbcj6.prod.google.com ([2002:a05:7022:6986:b0:12a:c5dd:73f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9c:b0:11b:88a7:e1b0
 with SMTP id a92af1059eb24-12c73fa3ebbmr14802432c88.26.1776916634021; Wed, 22
 Apr 2026 20:57:14 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:12 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-46-irogers@google.com>
Subject: [PATCH v2 45/58] perf stackcollapse: Port stackcollapse to use python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

