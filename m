Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2934107F
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643268; cv=none; b=rA+5dnAGYrXQvRg0MnC8iMx8nOsMGqrlbEKRNvVNcX3ChveOv7E19OudlDKtTdgNyVGf5BRWJmjzWS60yfGaDDkC8SwDPM9X4oNFTezHdWlyRYs2FL4t9HXZTjYJL9nvMMupPWgwbDZraq+os/puRrn4qKOBuODN8SnwhqNCFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643268; c=relaxed/simple;
	bh=KESoBbVt4qbZ8quTRsYtOmtUEsNIWIoj0lzmaYfKtaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uocDpn6SRCtZ8DneTCa6GT0cQY7qF17xNAyiNOmt0ddcN4WMUfIKe7/Fko9JbGEWXg97hljk7/USijgPfTCcXnixqbrW4SIaXJAzn8dTTq+2HmhQZWgk4HFovqnOYo4t+2gAVikWy15Z7ZHeRYC3/DvVIItSfwHsqhdF2snimR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWfEM5Ik; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWfEM5Ik"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c20d5d7f4so3514486c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643265; x=1777248065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3t+HRf9SwLQ0SM4OsODRpnUfHqTFKXUpfXt9AwIABc=;
        b=KWfEM5IkJ0e/rL69NVdPISLAz/YNmxwMaZyM33LMcBv81Sw2ky8DgNKyZleEA/3vEg
         X5yYIjnHVW9OmN6+vpg9IQcP75Bb9S8JqoA7GgAf1QWmB8d7xqexLgvWKJCbG0GzwOFe
         IKzJ/zZk1dwtqm4NYuJ4qwvCOlyApbfP+aUTvsfLbsPS66Gi2Z43MkeVtDe4/SX6Xpt5
         cxW2xsr87Be8J++d2X8rbMpFwt4nvx1p4FbL+CA1R53muMM3KrKzyoj/w8P83FL9z1LM
         0xWYqufZVgaZwjx1jdzPQ2uVMiEtU0LQxucP1DF+NgjLip7CRDwhlhJ+q5kBQzM25Mce
         O7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643265; x=1777248065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3t+HRf9SwLQ0SM4OsODRpnUfHqTFKXUpfXt9AwIABc=;
        b=dwc8+XS/ykpHdndLfCg26jGIqzQ2iia2mM9L16FLe/d81t9h+vp5fJYZCRctsiPf+A
         +Y7L/ZTDVnism5WdxmOnXbcILxbJ7Mh1emdFdx+wZ1wYHcRnXTJn+vAX5RsRQHJ3eMGp
         GB7QJAbbdLDVH/phhQrEhTWr/G918m8iYsNa56pTINaaOB0v0/g047jEKD2fAiYqqFJA
         FUYvI0aS/sgbXCAh22Ch1s3se3CHOzhhT05M/zYfqByzhNLCUOX7Vmm6aZdWTx7RSP+Q
         NfK0iMqEfeDh1jZF8Qp313ddVyYrfWfd8ytdv/UznaScryDdxHEJOMhn8IaD8hyU8mY/
         uEsw==
X-Forwarded-Encrypted: i=1; AFNElJ+cBh7EfdctVt8/xKnODnVxyPZXEqfCh+p5C06qJEbRV62S1kxcfugstVi4L/tdngBqn72RVb9J9E2SrM9+Sx0r@vger.kernel.org
X-Gm-Message-State: AOJu0YyHu6J4kVkhRyujRIx5CJ5YIatI1FVe2bPu3Pob6hYylqJJRoyy
	J8lLlfGE48L8ohlWPFF4QmbBc53siQw6l0LBm08zJX+c2lnfm72bGDTD2hwCbqZ+chRdeb0icSa
	8+kAQQX7aEQ==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:12c:3532:1d17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:383:b0:12b:ebb9:1c18
 with SMTP id a92af1059eb24-12c73fa739fmr6415650c88.31.1776643265188; Sun, 19
 Apr 2026 17:01:05 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:57 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-46-irogers@google.com>
Subject: [PATCH v1 45/58] perf stackcollapse: Port stackcollapse to use python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Modernize the legacy stackcollapse.py trace script by refactoring it
into a class-based architecture (StackCollapseAnalyzer).
The script uses perf.session for event processing and aggregates call
stacks to produce output suitable for flame graphs.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/stackcollapse.py | 120 +++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 tools/perf/python/stackcollapse.py

diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stackcollapse.py
new file mode 100755
index 000000000000..22caf97c9cac
--- /dev/null
+++ b/tools/perf/python/stackcollapse.py
@@ -0,0 +1,120 @@
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
+        if hasattr(sample, "callchain"):
+            for node in sample.callchain:
+                stack.append(self.tidy_function_name(node.symbol, node.dso))
+        else:
+            # Fallback if no callchain
+            sym = getattr(sample, "symbol", "[unknown]")
+            dso = getattr(sample, "dso", "[unknown]")
+            stack.append(self.tidy_function_name(sym, dso))
+
+        if self.args.include_comm:
+            comm = getattr(sample, "comm", "Unknown").replace(" ", "_")
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
2.54.0.rc1.513.gad8abe7a5a-goog

