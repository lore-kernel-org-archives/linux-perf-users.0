Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8936826E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967308; cv=none; b=DfxxCUc4mi18TxJSvVKv4h0lHtgRg8Qh+blbql73E4SPjp7Ki5/NY0YRKxCW7AGWDZ/AVk/R6Bfn+ja9Dz/1N1anP/rISiP+r/wSTn8d6qbsroixNoK+kfe9oXL1qdwyAb3xdcPq0MMjgBtSZwGd0bAJmLZM+Ffo22RlucgxlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967308; c=relaxed/simple;
	bh=xcIaJw+w15sD+EroYPe7dMNl7jlwwNzXMBBOmNAING8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIReQwP31iVCnkYsz2/e8h2/JC81H1JUgBI9Xz5JqcG2X+JTgU3HN2uzxKCRGxNwE/pm9yjgnX5Om9R56JIlB3tSC3TfpQVzkYReFte3jd5s7yMar2ytfKkI6QgHrRboZ7cRwHHNy8byl2dvMc0vqu2HC8x6L0tMM5i76H0D7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5aGg+ek; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5aGg+ek"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so4878375a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967305; x=1790572105; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHbcK54ZX6Nt0N4xNmcJtKZZeZv78jFOS9YGo8xcRJE=;
        b=W5aGg+ekliuxJnqqAwIk37Mk66inx1kK5Ixdi2eEo3N1eSOU8noUY1cDamhJP3jc/Q
         uC+rwEoGjAeuCzO8JzvtgISHI2DF/XYmQdKnJvTSHNNwJuAdQKvnNScLjNV4vfCdRcmZ
         pZPdjNGpN3pGgSb5YbDeR+Ltaj8K1JXLoDuw+5UchhTdna2LSBxYou1N0KK/W+wGNc1F
         oeb0tidvGBta161a7Hwz+AMLbzPIHUXQN6s7NmPGzIa2LQemonha2hQrjsgKrChlSS4+
         ZmTNb7xUuDTiaizBycDtJLrija1yQje6EeG0anjezn4O1ArXZN+/WgTVQqQghuw+vrS4
         WvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967305; x=1790572105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHbcK54ZX6Nt0N4xNmcJtKZZeZv78jFOS9YGo8xcRJE=;
        b=WUoryK6DUlqTkdjeTf+N6Aov+GZeQvge9NrNEtHFy83EqhcgtGrzUtx9Ae1vnMeLTE
         1wKWweL0MiLre8BuF6RqN6ZK54F4CvGOElhlablOLf8rZblTx0fqPFTZy7aHZEZ8v5En
         Cl1CAg5DStzzGyDUf2E3BBQWN1U1yVy5R1i6gFqOPbCiG2spX5M9dKYgHuKBG0k5wsMd
         vREmRlaKRz5VeIsBAlMDdP+cowX25TtCCLwLG3q4HgC58ZoTRpXSmBoGkooGPnM2m8OK
         3NqEZnVsBtb/x7mQqRQ34X7lq/KCPC7gDtNSBVaduQ4osU9ciQI/jQqfMgtkmwJYT2Kx
         twfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfJt83ZLTsNl4+e9rqRqzX32iVxPMPMwFp4v6KSiPyiq+hAa68JcsOjCA1jUjNBsjx/6rfi8OaTwjZ0I2zh0In@vger.kernel.org
X-Gm-Message-State: AFuF++mHufjW5VCScTegqhxn7C5AyfiijRfJ1n+UZEigdPGW7DtUBuX0
	bWF4VKr7wp+8IBaqXXzaLGFuJ40ZvsMZJoLC79EKrsfE0fvpTD8zAx12OGVuwQuJvmjdYoQh5AJ
	q79og08m1zg==
X-Received: from dlep2-n2.prod.google.com ([2002:a05:701b:4582:20b0:144:c32a:6a84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5903:b0:39e:d36c:ee54
 with SMTP id 98e67ed59e1d1-39ed36cef6amr8101541a91.5.1789967304884; Sun, 20
 Sep 2026 22:08:24 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:53 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <c20f25af247c58025dc6476a9a60c3cfcbc37454.1789966896.git.irogers@google.com>
Subject: [PATCH v2 35/49] perf python: Port net_dropmonitor to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port net_dropmonitor.py from tools/perf/scripts/python/ to a standalone
script in tools/perf/python/:
- Refactor the script into a DropMonitor class with full type
  annotations to encapsulate state.
- Use perf.session for skb:kfree_skb event processing and add argparse
  CLI support (-i/--input and -k/--kallsyms).
- Resolve kernel drop addresses via perf.session symbols/callchains and
  binary search over /proc/kallsyms, ignoring zeroed kptr_restrict
  addresses with graceful fallback when kallsyms is unavailable.
- Remove Python 2 compatibility code.

Add a shell test (test_net_dropmonitor_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/net_dropmonitor.py          | 163 ++++++++++++++++++
 .../shell/test_net_dropmonitor_python.sh      | 103 +++++++++++
 2 files changed, 266 insertions(+)
 create mode 100755 tools/perf/python/net_dropmonitor.py
 create mode 100755 tools/perf/tests/shell/test_net_dropmonitor_python.sh

diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net_dropmonitor.py
new file mode 100755
index 000000000000..8c6b928651da
--- /dev/null
+++ b/tools/perf/python/net_dropmonitor.py
@@ -0,0 +1,163 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Monitor the system for dropped packets and produce a report of drop locations and counts.
+Ported from tools/perf/scripts/python/net_dropmonitor.py
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+import os
+import sys
+from typing import Tuple
+import perf
+
+
+class DropMonitor:
+    """Monitors dropped packets and aggregates counts by location."""
+
+    def __init__(self, kallsyms_path: str | None = None) -> None:
+        self.drop_log: dict[int, int] = defaultdict(int)
+        self.kallsyms: list[Tuple[int, str]] = []
+        self.kallsyms_parsed = False
+        self.resolved_syms: dict[int, Tuple[str, int]] = {}
+        self.callchain_syms: dict[int, str] = {}
+        self.kallsyms_path = (
+            kallsyms_path
+            or os.environ.get("PERF_SYMBOL_KALLSYMS")
+            or "/proc/kallsyms"
+        )
+
+    def _parse_kallsyms(self) -> None:
+        """Parse the kallsyms file and map kernel addresses to function symbols."""
+        self.kallsyms.clear()
+        self.kallsyms_parsed = True
+        try:
+            with open(self.kallsyms_path, "r", encoding="utf-8") as f:
+                for line in f:
+                    parts = line.split()
+                    if len(parts) >= 3 and parts[1] in ('t', 'T', 'w', 'W'):
+                        addr = int(parts[0], 16)
+                        if addr > 0:
+                            self.kallsyms.append((addr, parts[2]))
+            self.kallsyms.sort(key=lambda x: x[0])
+        except (FileNotFoundError, PermissionError):
+            print(f"Failed to read {self.kallsyms_path}. Symbols will not be resolved.")
+
+    def _get_sym(self, loc: int) -> Tuple[str, int]:
+        """Resolve a memory location using session symbols or the kallsyms map."""
+        if loc in self.resolved_syms:
+            return self.resolved_syms[loc]
+        if not self.kallsyms:
+            if loc in self.callchain_syms:
+                return self.callchain_syms[loc], 0
+            return str(loc), 0
+
+        start = 0
+        end = len(self.kallsyms) - 1
+        while start < end:
+            mid = (start + end) // 2
+            if self.kallsyms[mid][0] <= loc < self.kallsyms[mid+1][0]:
+                start = mid
+                break
+            if loc < self.kallsyms[mid][0]:
+                end = mid - 1
+            else:
+                start = mid + 1
+
+        sym_addr, sym_name = self.kallsyms[start]
+        if loc >= sym_addr:
+            res = (sym_name, loc - sym_addr)
+            self.resolved_syms[loc] = res
+            return res
+        if loc in self.callchain_syms:
+            res = (self.callchain_syms[loc], 0)
+            self.resolved_syms[loc] = res
+            return res
+        return str(loc), 0
+
+    def print_drop_table(self) -> None:
+        """Print aggregated results."""
+        if not self.drop_log:
+            print(f"{'LOCATION':>25} {'OFFSET':>25} {'COUNT':>25}")
+            return
+
+        if not self.kallsyms_parsed and len(self.resolved_syms) < len(self.drop_log):
+            print("Gathering kallsyms data")
+            self._parse_kallsyms()
+
+        print(f"{'LOCATION':>25} {'OFFSET':>25} {'COUNT':>25}")
+        sorted_keys = sorted(self.drop_log.keys())
+        for sloc in sorted_keys:
+            sym, off = self._get_sym(sloc)
+            print(f"{sym:>25} {off:>25d} {self.drop_log[sloc]:>25d}")
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single sample event."""
+        if "skb:kfree_skb" not in str(sample.evsel):
+            return
+
+        location = getattr(sample, "location", None)
+        if location is not None:
+            self.drop_log[location] += 1
+            if location not in self.resolved_syms:
+                if getattr(sample, "sample_ip", 0) == location and getattr(sample, "symbol", None):
+                    self.resolved_syms[location] = (
+                        sample.symbol,
+                        getattr(sample, "sym_offset", 0) or 0,
+                    )
+                else:
+                    for entry in getattr(sample, "callchain", []) or []:
+                        if isinstance(entry, dict):
+                            entry_ip = entry.get("ip")
+                            entry_sym = entry.get("sym")
+                            sym_name = (
+                                entry_sym.get("name") if isinstance(entry_sym, dict) else None
+                            )
+                            sym_start = (
+                                entry_sym.get("start")
+                                if isinstance(entry_sym, dict)
+                                else None
+                            )
+                        else:
+                            entry_ip = getattr(entry, "ip", None)
+                            entry_sym = getattr(entry, "sym", None)
+                            sym_name = (
+                                getattr(entry_sym, "name", None)
+                                or getattr(entry, "symbol", None)
+                            )
+                            sym_start = getattr(entry_sym, "start", None)
+                        if entry_ip == location and sym_name:
+                            if sym_start is not None:
+                                self.resolved_syms[location] = (
+                                    sym_name,
+                                    max(0, location - sym_start),
+                                )
+                            else:
+                                self.callchain_syms[location] = sym_name
+                            break
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Monitor the system for dropped packets and produce a "
+                    "report of drop locations and counts.")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("-k", "--kallsyms", default=None,
+                    help="Path to kallsyms file for offline symbol resolution")
+    args = ap.parse_args()
+
+    monitor = DropMonitor(kallsyms_path=args.kallsyms)
+
+    try:
+        session = perf.session(perf.data(args.input), sample=monitor.process_event,
+                               kallsyms=args.kallsyms)
+        session.process_events()
+    except KeyboardInterrupt:
+        print("\nStopping trace...")
+    except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
+        print(f"Error processing events: {e}")
+        sys.exit(1)
+
+    monitor.print_drop_table()
diff --git a/tools/perf/tests/shell/test_net_dropmonitor_python.sh b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
new file mode 100755
index 000000000000..41497f9837cf
--- /dev/null
+++ b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
@@ -0,0 +1,103 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# net_dropmonitor python test
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
+script_path="${script_dir}/net_dropmonitor.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, net_dropmonitor.py not found at $script_path"
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
+trap 'cleanup' EXIT
+trap 'cleanup; exit 1' TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+echo "Testing net_dropmonitor.py..."
+
+# Create a perf.data file. Force dropping a packet if tracepoint is available!
+if ! perf record -e skb:kfree_skb -o "${temp_data}" -a \
+	-- ping -c 1 255.255.255.255 >/dev/null 2>&1; then
+	if ! perf record -e skb:kfree_skb -o "${temp_data}" \
+		-- sleep 0.1 >/dev/null 2>&1; then
+		if ! perf record -o "${temp_data}" -- uname >/dev/null 2>&1; then
+			echo "Skipping test, cannot record perf events"
+			exit 2
+		fi
+	fi
+fi
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes and outputs table header
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "net_dropmonitor.py test failed"
+	err=1
+else
+	if ! grep -q "LOCATION.*OFFSET.*COUNT" "${temp_out}"; then
+		echo "Failed to find the metrics table header"
+		err=1
+	fi
+fi
+
+# Verify DropMonitor event processing and symbol resolution
+if [ $err -eq 0 ]; then
+	if ! "$PYTHON" -c "
+import sys
+sys.path.insert(0, '${script_dir}')
+import net_dropmonitor
+
+class DummySample:
+    evsel = 'skb:kfree_skb'
+    location = 0xffffffff81001010
+    sample_ip = 0xffffffff81001010
+    symbol = 'ip_rcv_finish'
+    sym_offset = 16
+    callchain = []
+
+dm = net_dropmonitor.DropMonitor()
+dm.process_event(DummySample())
+dm.print_drop_table()
+" > "${temp_out}"; then
+		echo "net_dropmonitor.py unit test failed"
+		err=1
+	elif ! grep -q "ip_rcv_finish.*16.*1" "${temp_out}"; then
+		echo "Failed to find expected symbol resolution in net_dropmonitor.py"
+		err=1
+	else
+		echo "net_dropmonitor test passed."
+	fi
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

