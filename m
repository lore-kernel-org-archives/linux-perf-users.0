Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A373A1A22
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403733; cv=none; b=oYEiXm6GgKgcx7xGTOe8lBVBZQacplzsFWOHNO7FsiKSm3wNIhLYgVJasVsWWzNx76J+PG/bITJPqdY+CspJrQBCwLH8V1LauAlrPmdSOg4nfOhXVZMFkVPEgI8/VxBNOxM+mkMa8ImOS5qLQIaeFubhJ/YyI9Tbz5y4ZVxMwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403733; c=relaxed/simple;
	bh=j2oC8mCOCu8aiK08RyVTj7LZqFYyaVR6vivX0n9U3fA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZRlAaKXH7w8O+jr9pFXz84yGuqql/JAMBkC6KWv5eEeaVZGTqNj0tugvPR6yQv7T0FdtIvCKPXmCAO22ziXKiEEjQKPW0CJuahkNBs3mYf+S6TxKy1Z0x+PJjjERVZrA1YqmZuMPnDZjHM1AJ1DwlU9IYO9rzNkJ8nKZYWuEV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKo78rPB; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKo78rPB"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3437d0cc8c7so120727eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403730; x=1791008530; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjFAH3oF6P2gDkn0im2+gAUvjaxi8G7VV+7T7pCCQ3Q=;
        b=UKo78rPBGWlo0TywM56hSdbuyMw+e0N7URd84NRsa20j9nzHiUHv52hHHQnDf1uidg
         BUMfRFejIT2hzBTMGB61aP7z/Knz+/WFx+6/GX4gNDVzai4tBVC1NmLQM7R0Qr+Vtr88
         qlHifFU4ht1KzaVYe/xabJTZWYQa0XV5C2aGUUueUWuBHGT3jq7uj1uh2/5nOphmAune
         85TzgqhfBvHKKFXCSYvIngB3LunQGmVY7+HIClTDslc4mrin6htRyjbDA4SoW2VXe2J7
         luelqYM8oEhswDuv89EOWeYCaEiYNFg9q+eElO+Nuczgn5JcVsYQOv9Fo8C8sCw6diOk
         I5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403730; x=1791008530;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjFAH3oF6P2gDkn0im2+gAUvjaxi8G7VV+7T7pCCQ3Q=;
        b=LtqXaPLaM8GX3yuYjEkZHDdqZxYJnmx7VkCgnITFaGDZ9JTuM8LYMtlnwUbBuBXsmt
         KZmuMJIkxkZQFWBZCxGUlV0CwK+pLdTOtvGmBdRp4atRiAD5WPiWrgBJR7lxYcdBQmAL
         nHdaS9o6R5Hk+DZ2zhkIFQPz71LPcox6XR1nq1cTisE0b/kZTZZzrKqVa7ynQ/i62jRA
         LV3cYDL6v8q7medEo0Tu7mgjpMTuHR3pi2bYeHZG/FiGnJkphPwpvO/YtR6uDSkkU+7V
         kjSiI3ZD6VXObZCBoQ/jCTUbzolRMkxfHOBaML//cUtLecjVgXik8CP2pGVXGOPsHk44
         J0pw==
X-Forwarded-Encrypted: i=1; AKwUvBxBu7z9etnar1ktSB8p0lJ4mQ+FUYKZuN0efLWKJ0e0nGwCQZYldQRJSqpw62I9/PgTJDZCZZgfqPR92qaHuUPg@vger.kernel.org
X-Gm-Message-State: AFuF++n7jt/6Yq6YBkSTLJSAcmIBapQD62WNBrSWllR+5JgFVEGQBD9W
	oJ25emXD6ov9YLxOWVGBvJ6CRdpxmDveWL0fibgxevwjJ3uqr66L1ZBKYcjwezui8qt7IeEXdUg
	rt01hD7t2sA==
X-Received: from dlag9.prod.google.com ([2002:a05:701b:2509:b0:143:64ee:152c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2052:20b0:143:2984:6517
 with SMTP id a92af1059eb24-146d096ca13mr2123779c88.38.1790403729265; Fri, 25
 Sep 2026 23:22:09 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:20:02 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-36-irogers@google.com>
Subject: [PATCH v4 35/49] perf python: Port net_dropmonitor to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
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
 tools/perf/python/net_dropmonitor.py          | 173 ++++++++++++++++++
 .../shell/test_net_dropmonitor_python.sh      | 102 +++++++++++
 2 files changed, 275 insertions(+)
 create mode 100755 tools/perf/python/net_dropmonitor.py
 create mode 100755 tools/perf/tests/shell/test_net_dropmonitor_python.sh

diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net_dropmonitor.py
new file mode 100755
index 000000000000..fff637b5c7e9
--- /dev/null
+++ b/tools/perf/python/net_dropmonitor.py
@@ -0,0 +1,173 @@
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
+        # Priority order:
+        # 1. Exact symbols with offsets resolved directly from the perf.data session
+        #    (resolved_syms).
+        # 2. Symbols captured from the sample's callchain in the trace file
+        #    (callchain_syms) before falling back to self.kallsyms, so offline
+        #    trace symbols are not overwritten by the live host's /proc/kallsyms.
+        # 3. Binary search in self.kallsyms (from --kallsyms or /proc/kallsyms).
+        if loc in self.resolved_syms:
+            return self.resolved_syms[loc]
+        if loc in self.callchain_syms:
+            res = (self.callchain_syms[loc], 0)
+            self.resolved_syms[loc] = res
+            return res
+        if not self.kallsyms:
+            return f"{loc:#x}", 0
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
+        return f"{loc:#x}", 0
+
+    def print_drop_table(self) -> None:
+        """Print aggregated results."""
+        if not self.drop_log:
+            print(f"{'LOCATION':>25} {'OFFSET':>25} {'COUNT':>25}")
+            return
+
+        if (not self.kallsyms_parsed
+                and any(loc not in self.resolved_syms and loc not in self.callchain_syms
+                        for loc in self.drop_log)):
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
+                sym = getattr(sample, "symbol", None)
+                if getattr(sample, "sample_ip", 0) == location and sym and sym != "[unknown]":
+                    self.resolved_syms[location] = (
+                        sym,
+                        getattr(sample, "sym_offset", 0) or 0,
+                    )
+                    self.callchain_syms.pop(location, None)
+                else:
+                    for entry in getattr(sample, "callchain", []) or []:
+                        if isinstance(entry, dict):
+                            entry_ip = entry.get("ip")
+                            sym_info = entry.get("sym")
+                            sym_name = sym_info.get("name") if isinstance(sym_info, dict) else None
+                            sym_start = sym_info.get("start") if isinstance(sym_info, dict) else None
+                            sym_off = (max(0, location - sym_start)
+                                       if sym_start is not None else None)
+                        else:
+                            entry_ip = getattr(entry, "ip", None)
+                            entry_sym = getattr(entry, "sym", None)
+                            sym_name = (
+                                getattr(entry_sym, "name", None)
+                                or getattr(entry, "symbol", None)
+                            )
+                            sym_off = getattr(entry, "sym_offset", None)
+                            if sym_off is None:
+                                sym_start = getattr(entry_sym, "start", None)
+                                if sym_start is not None:
+                                    sym_off = max(0, location - sym_start)
+                        if entry_ip == location and sym_name and sym_name != "[unknown]":
+                            if sym_off is not None:
+                                self.resolved_syms[location] = (sym_name, sym_off)
+                                self.callchain_syms.pop(location, None)
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
+    session = None
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
+    finally:
+        session = None
+
+    monitor.print_drop_table()
diff --git a/tools/perf/tests/shell/test_net_dropmonitor_python.sh b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
new file mode 100755
index 000000000000..d00be255d259
--- /dev/null
+++ b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
@@ -0,0 +1,102 @@
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
+sys.path.insert(0, sys.argv[1])
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
+" "${script_dir}" > "${temp_out}"; then
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
2.56.0.rc1.315.gc6ed9934b7-goog

